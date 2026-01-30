import { Router } from "express";
import * as controller from "./groups.controller.js"
import { validate } from "../../middleware/validate.middleware.js";
import { CreateGroupSchema } from "./dtos/create-group.dto.js";

const router = Router();

router.post("group/create",validate(CreateGroupSchema),controller.createGroup);
router.get("group/:group_id",controller.getGroupById);

export default router;