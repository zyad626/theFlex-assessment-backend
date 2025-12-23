import { NextFunction, Request, Response } from "express";
import { AppError } from "../middlewares/errorHandler";
import { getAllReviewsService, getReviewService, setReviewApproval } from "../services/review.service";

export const getReview = async (req: Request, res: Response, next: NextFunction) => {
  const { id } = req.params;
  if (!id) {
    return next(new AppError("id query parameter is required", 400));
  }
  try {
    const review = await getReviewService(parseInt(id));
    return res.status(200).json(review)
  } catch (error) {
    next(error)
  }
};
export const getAllReviews = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const options = {
      page: req.query.page ? Number(req.query.page) : 1,
      limit: req.query.limit ? Number(req.query.limit) : 100,
    };

    const result = await getAllReviewsService(options);
    res.status(200).json({ success: true, data: result });
  } catch (error) {
    next(error);
  }
};

export const updateReviewApproval = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    // req.params.id and req.body.approved are validated
    const id = Number(req.params.id);
    const { approved } = req.body;

    const updatedReview = await setReviewApproval(id, approved);
    
    res.status(200).json({
      success: true,
      data: updatedReview,
      message: `Review ${id} ${approved ? 'approved' : 'rejected'} successfully`,
    });
  } catch (error) {
    next(error);
  }
};
