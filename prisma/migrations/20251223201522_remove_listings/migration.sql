/*
  Warnings:

  - You are about to drop the column `listingId` on the `reviews` table. All the data in the column will be lost.
  - You are about to drop the `CustomField` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Listing` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ListingAmenity` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ListingBedType` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ListingCustomFieldValue` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ListingImage` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ListingTag` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PropertyType` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `listingMapId` to the `reviews` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "ListingAmenity" DROP CONSTRAINT "ListingAmenity_listingId_fkey";

-- DropForeignKey
ALTER TABLE "ListingBedType" DROP CONSTRAINT "ListingBedType_listingId_fkey";

-- DropForeignKey
ALTER TABLE "ListingCustomFieldValue" DROP CONSTRAINT "ListingCustomFieldValue_customFieldId_fkey";

-- DropForeignKey
ALTER TABLE "ListingCustomFieldValue" DROP CONSTRAINT "ListingCustomFieldValue_listingId_fkey";

-- DropForeignKey
ALTER TABLE "ListingImage" DROP CONSTRAINT "ListingImage_listingId_fkey";

-- DropForeignKey
ALTER TABLE "ListingTag" DROP CONSTRAINT "ListingTag_listingId_fkey";

-- DropForeignKey
ALTER TABLE "reviews" DROP CONSTRAINT "reviews_listingId_fkey";

-- AlterTable
ALTER TABLE "review_categories" ALTER COLUMN "rating" DROP NOT NULL;

-- AlterTable
ALTER TABLE "reviews" DROP COLUMN "listingId",
ADD COLUMN     "listingMapId" INTEGER NOT NULL;

-- DropTable
DROP TABLE "CustomField";

-- DropTable
DROP TABLE "Listing";

-- DropTable
DROP TABLE "ListingAmenity";

-- DropTable
DROP TABLE "ListingBedType";

-- DropTable
DROP TABLE "ListingCustomFieldValue";

-- DropTable
DROP TABLE "ListingImage";

-- DropTable
DROP TABLE "ListingTag";

-- DropTable
DROP TABLE "PropertyType";

-- DropEnum
DROP TYPE "BathroomType";

-- DropEnum
DROP TYPE "CancellationPolicyType";

-- DropEnum
DROP TYPE "ExportStatus";

-- DropEnum
DROP TYPE "RoomType";
