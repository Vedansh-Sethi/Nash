import { CreateGroupRequestDTO } from "./dtos/create-group.dto.js"
import { GroupResponseDTO } from "./dtos/group-response.dto.js"
import * as groupsRepo from "./groups.repository.js"

export const createGroup = async (
    input: CreateGroupRequestDTO
): Promise<GroupResponseDTO> => { 
    const newGroup = await groupsRepo.createGroup(input.name, input.description, input.adminId);
    return {
        id: newGroup.id,
        name: newGroup.name,
        description: newGroup.description,
        created_at: newGroup.created_at,
        created_by: newGroup.created_by
    }; 
}

export const getGroupById = async (
    input: string
): Promise<GroupResponseDTO> => { 
    const requestedGroup = await groupsRepo.getGroupById(input);
    return {
        id: requestedGroup.id,
        name: requestedGroup.name,
        description: requestedGroup.description,
        created_at: requestedGroup.created_at,
        created_by: requestedGroup.created_by,
        members: requestedGroup.members
    };
}