import pool from "../../config/db.js";
import { v4 as uuidv4 } from "uuid";
import { Group } from "./groups.model.js";

const mapRowToGroup = (row: any): Group => {
    return {
        id: row.id,
        name: row.name,
        description: row.description,
        created_at: row.created_at,
        created_by: row.created_by
    };
};

const mapRowToMember = (row: any) => {
    return {
        username: row.username,
        email: row.email,
        role: row.role
    };
};

export const createGroup = async (name: string, description: string, adminId: string): Promise<Group> => {
    const client = await pool.connect();
    try {
        const id: string = uuidv4();
        const now: Date = new Date(Date.now());
        await client.query("BEGIN");
        const newGroup = await client.query(
            `INSERT INTO groups (id, name, description, created_by, created_at)
            VALUES ($1, $2, $3, $4, $5)
            RETURNING *` ,
            [id, name, description, adminId, now],
        );
        await client.query(
            `INSERT INTO group_members (group_id, user_id, role, joined_at)
            VALUES ($1, $2, $3, $4)`,
            [id, adminId, , now],
        );
        await client.query("COMMIT");
        return mapRowToGroup(newGroup.rows[0]);
    } catch (err: any) {
        await client.query("ROLLBACK");
        throw err;
    } finally {
        client.release();
    }
};

export const getGroupById = async (groupId: string): Promise<Group> => {
    const client = await pool.connect()
    try {
        await client.query("BEGIN");
        const groupResponse = await client.query(
            `SELECT id, name, description, created_by, created_at
            FROM groups
            WHERE id = $1`,
            [groupId]
        );

        if (!groupResponse.rows[0]) throw new Error("Group not found");

        const membersResponse = await client.query(
            `SELECT username, email, role
            FROM group_members
            JOIN users ON group_members.user_id = users.id
            WHERE group_id = $1`,
            [groupId]
        );
        await client.query("COMMIT");

        const group = mapRowToGroup(groupResponse.rows[0]);
        group.members = membersResponse.rows.map((row: any) => mapRowToMember(row));

        return group;
    } catch (err: any) {
        await client.query("ROLLBACK");
        throw err;
    } finally { client.release(); }
}