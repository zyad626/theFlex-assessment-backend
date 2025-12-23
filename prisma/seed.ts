import { prisma } from "../src/config/prisma";
import { faker } from '@faker-js/faker';

const CATEGORIES = ['cleanliness', 'communication', 'value', 'accuracy', 'location', 'check-in'];
const LISTINGS = [
  { id: 346994, name: 'The Putney Apart 2' },
  { id: 155615, name: 'The Peckham Apartments' },
  { id: 155613, name: 'The Bromley Collection' },
];

async function main() {
    console.log('Database URL check:', process.env.DATABASE_URL);
  console.log('Cleaning database...');
  await prisma.reviewCategory.deleteMany();
  await prisma.review.deleteMany();

  console.log('Generating mock reviews...');

  for (let i = 0; i < 20; i++) {
    const listing = faker.helpers.arrayElement(LISTINGS);
    const type = faker.helpers.arrayElement(['guest-to-host', 'host-to-guest']);
    
    // Create the review and its categories in a single transaction
    await prisma.review.create({
      data: {
        listingMapId: listing.id,
        listingName: listing.name,
        approved: false, // 80% chance of being approved
        type: type,
        status: 'published',
        rating: faker.number.int({ min: 1, max: 10 }), // Hostaway uses 1-10
        publicReview: faker.lorem.paragraph(),
        guestName: faker.person.fullName(),
        submittedAt: faker.date.past({ years: 1 }),
        
        // Nested create for categories
        reviewCategories: {
          create: CATEGORIES.map(cat => ({
            category: cat,
            rating: faker.number.int({ min: 1, max: 10 })
          }))
        }
      }
    });
  }

  console.log('Seed successful!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });