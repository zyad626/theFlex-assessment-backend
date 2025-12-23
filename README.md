# Flex Living - Reviews Dashboard Assessment

This project provides a backend for a property reviews dashboard, integrating with the Hostaway API and managing a local database of mock reviews for testing.

## Prerequisites

* [Docker](https://docs.docker.com/get-docker/)
* [Docker Compose](https://docs.docker.com/compose/install/)
* A `.env` file in the root directory with the following variables:
```env
PORT=3000
DATABASE_URL="postgresql://postgres:postgres@db:5432/theFlex?schema=public"
HOSTAWAY_ACCOUNT_ID=your_account_id
HOSTAWAY_API_KEY=your_api_key

```



## Getting Started

1. **Build and Start the Containers:**
Run the following command in the root directory:
```bash
docker-compose up --build

```


2. **What happens during startup:**
* **Database (`db`)**: A PostgreSQL instance is launched.
* **Healthcheck**: The application waits for the database to be ready to accept connections.
* **Migrations**: `prisma migrate deploy` runs to set up the tables.
* **Seeding**: `npx tsx prisma/seed.ts` runs automatically to populate your database with mock review data.
* **Application (`app`)**: The Express server starts on port `3000`.



---

## API Documentation

### 1. Listings

**`GET /listings`**

* **Description**: Connects to the Hostaway API to fetch property listings.
* **Logic**: It uses an internal `AuthService` to manage the Bearer token. If the token is missing or expired, it automatically refreshes it before making the request.
* **Response**: An array of Hostaway listing objects.

### 2. Reviews (Mock Data)

**`GET /reviews`**

* **Description**: Retrieves all reviews currently stored in the PostgreSQL database.
* **Usage**: Used to populate the Manager Dashboard. It includes category ratings (cleanliness, communication, etc.) and the "approved" status.

**`GET /reviews/:id`**

* **Description**: Retrieves the details of a single review by its ID.
* **Usage**: Useful for a "View Details" modal or a specific review edit page.

### 3. Manager Actions

**`PATCH /reviews/:id/approve`**

* **Description**: Updates the `approved` status of a review.
* **Usage**: This is the core "Product Manager" feature. When a review is marked as `approved: true`, it should then be visible on the public property details page.
* **Request Body**:
```json
{
  "approved": true
}

```



---

## Development Notes

### Database Seeding

The seed script generates 20 realistic reviews using `@faker-js/faker`. Each review includes:

* A random overall rating (1-10).
* Sub-category ratings (Cleanliness, Accuracy, etc.).
* A "published" status.
* Association with one of the predefined property IDs.
