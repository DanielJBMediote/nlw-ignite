import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function main() {
  const user = await prisma.user.create({
    data: {
      name: "Daniel j. B. Mediote",
      email: "danieljbmediote@hotmail.com",
      avatarUrl: "https://github.com/DanielJBMediote.png",
    },
  });

  const pool = await prisma.pool.create({
    data: {
      title: "Bolão do Xesquedale",
      code: "BOL1234",
      ownerId: user.id,

      participants: {
        create: {
          ownerId: user.id,
        },
      },
    },
  });

  await prisma.game.create({
    data: {
      date: "2022-11-06T12:00:00.201Z",
      firstTeamCountryCode: "DE",
      secondTeamCountryCode: "BR",
    },
  });

  await prisma.game.create({
    data: {
      date: "2022-11-06T12:00:00.201Z",
      firstTeamCountryCode: "BR",
      secondTeamCountryCode: "AR",

      guesses: {
        create: {
          firstTeamPoints: 1,
          secondTeamPoints: 0,

          participant: {
            connect: {
              ownerId_poolId: {
                ownerId: user.id,
                poolId: pool.id,
              },
            },
          },
        },
      },
    },
  });
}

main();
