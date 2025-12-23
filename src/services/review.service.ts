import { Review } from "../../generated/prisma/client";
import { prisma } from "../config/prisma";
import { AppError } from "../middlewares/errorHandler";

// Retrieve review by id
export const getReviewService = async (id: number): Promise<Review> => {
  try {
    const review = await prisma.review.findUnique({
      where: {
        id,
      },
    });
    if (!review) throw new AppError(`No Reviews found for id: ${id}`, 404);
    return review;
  } catch (error) {
    if (error instanceof AppError) throw error;
    throw new AppError(error as string, 500);
  }
};

// Retrieve all reviews with pagination
interface GetAllReviewsOptions {
  page?: number;
  limit?: number;
}

interface PaginatedReviews {
  reviews: Review[];
  total: number;
  page: number;
  totalPages: number;
  limit: number;
}

export const getAllReviewsService = async (
  options: GetAllReviewsOptions = {}
): Promise<PaginatedReviews> => {
  try {
    const page = Math.max(1, options.page ?? 1);
    const limit = Math.min(100, options.limit ?? 10); // Cap limit for safety
    const skip = (page - 1) * limit;

    // Get total count for pagination metadata
    const total = await prisma.review.count();

    // Fetch reviews with pagination
    const reviews = await prisma.review.findMany({
      skip,
      take: limit,
    });

    const totalPages = Math.ceil(total / limit);

    return {
      reviews,
      total,
      page,
      totalPages,
      limit,
    };
  } catch (error) {
    throw new AppError(`Failed to retrieve reviews: ${error}`, 500);
  }
};

// Update review approval status
export const setReviewApproval = async (
  id: number,
  approved: boolean
): Promise<Review> => {
  try {
    // First, check if the review exists
    const existingReview = await prisma.review.findUnique({
      where: { id },
    });

    if (!existingReview) {
      throw new AppError(`Review with id ${id} not found`, 404);
    }

    // Update the approved status
    const updatedReview = await prisma.review.update({
      where: { id },
      data: {
        approved,
      },
    });

    return updatedReview;
  } catch (error) {
    if (error instanceof AppError) throw error;
    throw new AppError(
      `Failed to update approval status for review ${id}: ${error}`,
      500
    );
  }
};
