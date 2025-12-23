import express from "express";
import { errorHandler } from "./middlewares/errorHandler";
import listingRouter from "./routes/listing.routes";
import reviewRouter from "./routes/review.routes";

const app = express();

app.use(express.json());

app.use("/listings", listingRouter);
app.use("/reviews", reviewRouter);

app.use(errorHandler);
export default app;
