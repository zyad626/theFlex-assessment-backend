// middleware/validation.ts
import { Request, Response, NextFunction } from 'express';
import { Schema } from 'joi';
import { AppError } from './errorHandler';

export const validate = (schema: Schema) => {
    //the actual middleware, the validate function itself is like a 'factory'
  return (req: Request, res: Response, next: NextFunction): void => {
    const { error } = schema.validate(req.body || {}, { 
      abortEarly: false,
      stripUnknown: true 
    });

    if (error) {
      const message = error.details.map((d) => d.message).join(', ');
      return next(new AppError(`Validation error: ${message}`, 400));
    }

    next();
  };
};

// For query params
export const validateQuery = (schema: Schema) => {
  return (req: Request, res: Response, next: NextFunction): void => {
    const { error } = schema.validate(req.query || {}, { 
      abortEarly: false,
      stripUnknown: true 
    });

    if (error) {
      const message = error.details.map((d) => d.message).join(', ');
      return next(new AppError(`Validation error: ${message}`, 400));
    }

    next();
  };
};

// For params (e.g., route params like :id)
export const validateParams = (schema: Schema) => {
  return (req: Request, res: Response, next: NextFunction): void => {
    const { error } = schema.validate(req.params || {}, { 
      abortEarly: false,
      stripUnknown: true 
    });

    if (error) {
      const message = error.details.map((d) => d.message).join(', ');
      return next(new AppError(`Validation error: ${message}`, 400));
    }

    next();
  };
};