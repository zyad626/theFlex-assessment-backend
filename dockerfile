# --- STAGE 1: Build ---
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY prisma ./prisma/
COPY prisma.config.ts ./
# This generates the client into the /app/generated folder
RUN npx prisma generate
COPY . .
RUN npm run build

# --- STAGE 2: Run ---
FROM node:20-alpine
WORKDIR /app

# Copy dependencies
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/prisma.config.ts ./
COPY --from=builder /app/src ./src 
COPY --from=builder /app/dist ./dist

# FIX: Copy the custom generated Prisma client folder
COPY --from=builder /app/generated ./generated 

EXPOSE 3000

# Start command
CMD npx prisma migrate deploy && npx prisma db seed && npm start