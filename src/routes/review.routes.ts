// routes/reviewRoutes.ts
import { Router } from "express";
import {
  getAllReviews,
  getReview,
  updateReviewApproval,
} from "../controllers/review.controller";

import {
  validateQuery,
  validateParams,
  validate,
} from "../middlewares/validation";

import {
  getAllReviewsQuerySchema,
  reviewIdParamSchema,
  updateReviewApprovalBodySchema,
} from "../validators/review.validator";

const router = Router();

router.get("/reviews/:id", validateParams(reviewIdParamSchema), getReview);

// GET /reviews?page=1&limit=10
router.get("/reviews", validateQuery(getAllReviewsQuerySchema), getAllReviews);

// PATCH /reviews/:id/approve => body: { approved: true }
router.patch(
  "/reviews/:id/approve",
  validateParams(reviewIdParamSchema),
  validate(updateReviewApprovalBodySchema),
  updateReviewApproval
);

export default router;
