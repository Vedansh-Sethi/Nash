import {z} from "zod";
export const CreateGroupSchema = z.object({
    name: z.string(),
    description: z.string(),
    adminId: z.string()
});
export type CreateGroupRequestDTO = z.infer<typeof CreateGroupSchema>;