// schemas/reviewSchemas.ts
import Joi from 'joi';

// Schema for GET /reviews query params
export const getAllReviewsQuerySchema = Joi.object({
  page: Joi.number().integer().min(1).default(1).optional()
    .messages({ 'number.min': 'Page must be at least 1' }),
  limit: Joi.number().integer().min(1).max(100).default(10).optional()
    .messages({ 
      'number.min': 'Limit must be at least 1',
      'number.max': 'Limit cannot exceed 100'
    }),
});

// Schema for PATCH /reviews/:id/approve body
export const updateReviewApprovalBodySchema = Joi.object({
  approved: Joi.boolean().required()
    .messages({ 'any.required': '`approved` field is required' }),
});

// Schema for route params (e.g., :id)
export const reviewIdParamSchema = Joi.object({
  id: Joi.number().integer().positive().required()
    .messages({
      'number.base': 'ID must be a number',
      'number.integer': 'ID must be an integer',
      'number.positive': 'ID must be positive',
      'any.required': 'Review ID is required',
    }),
});