import axios from "axios";
import { hostawayAuthService } from "./hostaway.auth.service";
import { AppError } from "../middlewares/errorHandler";

export const getListingsService = async () => {
  try {
    const token = await hostawayAuthService.getValidToken(); // Always gets a fresh/valid token

    const response = await axios.get("https://api.hostaway.com/v1/listings", {
      headers: {
        Authorization: `Bearer ${token}`,
        "Cache-Control": "no-cache",
      },
    });
    if (response.data.result.length == 0) {
      throw new AppError("No listings found", 404);
    }
    return response.data.result;
  } catch (error) {
    if (error instanceof AppError) throw error;
    throw new AppError(error as string, 500);
  }
};
