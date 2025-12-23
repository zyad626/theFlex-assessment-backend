import { NextFunction, Request, Response } from "express";
import { getListingsService } from "../services/listing.service";

export const getListings = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const listings = await getListingsService();
    return res.status(200).json(listings);
  } catch (error) {
    next(error);
  }
};
