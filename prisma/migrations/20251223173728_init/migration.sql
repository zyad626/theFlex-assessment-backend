-- CreateEnum
CREATE TYPE "RoomType" AS ENUM ('ENTIRE_HOME', 'PRIVATE_ROOM', 'SHARED_ROOM');

-- CreateEnum
CREATE TYPE "BathroomType" AS ENUM ('PRIVATE', 'SHARED');

-- CreateEnum
CREATE TYPE "CancellationPolicyType" AS ENUM ('FLEXIBLE', 'MODERATE', 'STRICT', 'CUSTOM');

-- CreateEnum
CREATE TYPE "ExportStatus" AS ENUM ('PENDING', 'SUCCESS', 'FAILED', 'DISABLED');

-- CreateTable
CREATE TABLE "reviews" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "listingId" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "rating" INTEGER,
    "publicReview" TEXT,
    "submittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "guestName" TEXT,
    "listingName" TEXT,

    CONSTRAINT "reviews_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "review_categories" (
    "id" SERIAL NOT NULL,
    "reviewId" INTEGER NOT NULL,
    "category" TEXT NOT NULL,
    "rating" INTEGER NOT NULL,

    CONSTRAINT "review_categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Listing" (
    "id" SERIAL NOT NULL,
    "propertyTypeId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "externalListingName" TEXT,
    "internalListingName" TEXT,
    "description" TEXT,
    "thumbnailUrl" TEXT,
    "houseRules" TEXT,
    "keyPickup" TEXT,
    "specialInstruction" TEXT,
    "doorSecurityCode" TEXT,
    "country" TEXT NOT NULL,
    "countryCode" TEXT NOT NULL,
    "state" TEXT,
    "city" TEXT NOT NULL,
    "street" TEXT,
    "address" TEXT,
    "publicAddress" TEXT,
    "zipcode" TEXT,
    "lat" DOUBLE PRECISION,
    "lng" DOUBLE PRECISION,
    "price" DOUBLE PRECISION NOT NULL,
    "weeklyDiscount" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "monthlyDiscount" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "propertyRentTax" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "guestPerPersonPerNightTax" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "guestStayTax" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "guestNightlyTax" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "refundableDamageDeposit" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "isDepositStayCollected" BOOLEAN NOT NULL DEFAULT false,
    "personCapacity" INTEGER NOT NULL,
    "maxChildrenAllowed" INTEGER,
    "maxInfantsAllowed" INTEGER,
    "maxPetsAllowed" INTEGER,
    "checkInTimeStart" INTEGER NOT NULL,
    "checkInTimeEnd" INTEGER NOT NULL,
    "checkOutTime" INTEGER NOT NULL,
    "cancellationPolicy" "CancellationPolicyType" NOT NULL DEFAULT 'FLEXIBLE',
    "cancellationPolicyId" INTEGER,
    "minNights" INTEGER NOT NULL,
    "maxNights" INTEGER NOT NULL,
    "guestsIncluded" INTEGER NOT NULL DEFAULT 1,
    "cleaningFee" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "checkinFee" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "priceForExtraPerson" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "instantBookable" BOOLEAN NOT NULL DEFAULT true,
    "allowSameDayBooking" BOOLEAN NOT NULL DEFAULT false,
    "sameDayBookingLeadTime" INTEGER,
    "roomType" "RoomType" NOT NULL DEFAULT 'ENTIRE_HOME',
    "bathroomType" "BathroomType" NOT NULL DEFAULT 'PRIVATE',
    "bedroomsNumber" INTEGER NOT NULL,
    "bedsNumber" INTEGER NOT NULL,
    "bathroomsNumber" INTEGER NOT NULL,
    "guestBathroomsNumber" INTEGER,
    "squareMeters" DOUBLE PRECISION,
    "contactName" TEXT,
    "contactSurName" TEXT,
    "contactPhone1" TEXT,
    "contactPhone2" TEXT,
    "contactLanguage" TEXT,
    "contactEmail" TEXT,
    "contactAddress" TEXT,
    "language" TEXT NOT NULL DEFAULT 'en',
    "currencyCode" TEXT NOT NULL DEFAULT 'GBP',
    "timeZoneName" TEXT NOT NULL DEFAULT 'UTC',
    "wifiUsername" TEXT,
    "wifiPassword" TEXT,
    "propertyLicenseNumber" TEXT,
    "propertyLicenseType" TEXT,
    "propertyLicenseIssueDate" TIMESTAMP(3),
    "propertyLicenseExpirationDate" TIMESTAMP(3),
    "airbnbExportStatus" "ExportStatus" DEFAULT 'DISABLED',
    "vrboExportStatus" "ExportStatus" DEFAULT 'DISABLED',
    "marriotExportStatus" "ExportStatus" DEFAULT 'DISABLED',
    "bookingcomExportStatus" "ExportStatus" DEFAULT 'DISABLED',
    "expediaExportStatus" "ExportStatus" DEFAULT 'DISABLED',
    "googleExportStatus" "ExportStatus" DEFAULT 'DISABLED',
    "airbnbListingUrl" TEXT,
    "vrboListingUrl" TEXT,
    "googleVrListingUrl" TEXT,
    "expediaListingUrl" TEXT,
    "marriottListingName" TEXT,
    "cleannessStatus" TEXT,
    "cleaningInstruction" TEXT,
    "cleannessStatusUpdatedOn" TIMESTAMP(3),
    "partnersListingMarkup" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "airbnbOfficialListingMarkup" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "bookingEngineMarkup" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "homeawayApiMarkup" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "marriottListingMarkup" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "latestActivityOn" TIMESTAMP(3),
    "insertedOn" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "averageReviewRating" DOUBLE PRECISION,
    "averageNightlyPrice" DOUBLE PRECISION,

    CONSTRAINT "Listing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ListingAmenity" (
    "id" SERIAL NOT NULL,
    "listingId" INTEGER NOT NULL,
    "amenityId" INTEGER NOT NULL,
    "amenityName" TEXT NOT NULL,

    CONSTRAINT "ListingAmenity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ListingBedType" (
    "id" SERIAL NOT NULL,
    "listingId" INTEGER NOT NULL,
    "bedTypeId" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "bedroomNumber" INTEGER NOT NULL,

    CONSTRAINT "ListingBedType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ListingImage" (
    "id" SERIAL NOT NULL,
    "listingId" INTEGER NOT NULL,
    "caption" TEXT,
    "bookingEngineCaption" TEXT,
    "airbnbCaption" TEXT,
    "vrboCaption" TEXT,
    "url" TEXT NOT NULL,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "ListingImage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ListingTag" (
    "id" SERIAL NOT NULL,
    "listingId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "ListingTag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomField" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "possibleValues" JSONB,
    "isPublic" BOOLEAN NOT NULL DEFAULT true,
    "insertedOn" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedOn" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CustomField_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ListingCustomFieldValue" (
    "id" SERIAL NOT NULL,
    "listingId" INTEGER NOT NULL,
    "customFieldId" INTEGER NOT NULL,
    "value" TEXT,
    "insertedOn" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedOn" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ListingCustomFieldValue_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyType" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "PropertyType_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "review_categories_reviewId_category_key" ON "review_categories"("reviewId", "category");

-- CreateIndex
CREATE INDEX "ListingAmenity_listingId_idx" ON "ListingAmenity"("listingId");

-- CreateIndex
CREATE UNIQUE INDEX "ListingAmenity_listingId_amenityId_key" ON "ListingAmenity"("listingId", "amenityId");

-- CreateIndex
CREATE INDEX "ListingBedType_listingId_idx" ON "ListingBedType"("listingId");

-- CreateIndex
CREATE INDEX "ListingImage_listingId_idx" ON "ListingImage"("listingId");

-- CreateIndex
CREATE INDEX "ListingImage_sortOrder_idx" ON "ListingImage"("sortOrder");

-- CreateIndex
CREATE INDEX "ListingTag_listingId_idx" ON "ListingTag"("listingId");

-- CreateIndex
CREATE UNIQUE INDEX "ListingTag_listingId_name_key" ON "ListingTag"("listingId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "CustomField_name_key" ON "CustomField"("name");

-- CreateIndex
CREATE INDEX "ListingCustomFieldValue_listingId_idx" ON "ListingCustomFieldValue"("listingId");

-- CreateIndex
CREATE INDEX "ListingCustomFieldValue_customFieldId_idx" ON "ListingCustomFieldValue"("customFieldId");

-- CreateIndex
CREATE UNIQUE INDEX "ListingCustomFieldValue_listingId_customFieldId_key" ON "ListingCustomFieldValue"("listingId", "customFieldId");

-- CreateIndex
CREATE UNIQUE INDEX "PropertyType_name_key" ON "PropertyType"("name");

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_listingId_fkey" FOREIGN KEY ("listingId") REFERENCES "Listing"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "review_categories" ADD CONSTRAINT "review_categories_reviewId_fkey" FOREIGN KEY ("reviewId") REFERENCES "reviews"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListingAmenity" ADD CONSTRAINT "ListingAmenity_listingId_fkey" FOREIGN KEY ("listingId") REFERENCES "Listing"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListingBedType" ADD CONSTRAINT "ListingBedType_listingId_fkey" FOREIGN KEY ("listingId") REFERENCES "Listing"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListingImage" ADD CONSTRAINT "ListingImage_listingId_fkey" FOREIGN KEY ("listingId") REFERENCES "Listing"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListingTag" ADD CONSTRAINT "ListingTag_listingId_fkey" FOREIGN KEY ("listingId") REFERENCES "Listing"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListingCustomFieldValue" ADD CONSTRAINT "ListingCustomFieldValue_listingId_fkey" FOREIGN KEY ("listingId") REFERENCES "Listing"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListingCustomFieldValue" ADD CONSTRAINT "ListingCustomFieldValue_customFieldId_fkey" FOREIGN KEY ("customFieldId") REFERENCES "CustomField"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
