/*
  Warnings:

  - You are about to drop the column `firstTeamPoints` on the `Game` table. All the data in the column will be lost.
  - You are about to drop the column `secondTeamPoints` on the `Game` table. All the data in the column will be lost.
  - Added the required column `firstTeamPoints` to the `Guess` table without a default value. This is not possible if the table is not empty.
  - Added the required column `secondTeamPoints` to the `Guess` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Guess" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "firstTeamPoints" INTEGER NOT NULL,
    "secondTeamPoints" INTEGER NOT NULL,
    "gameId" TEXT NOT NULL,
    "participantId" TEXT NOT NULL,
    CONSTRAINT "Guess_participantId_fkey" FOREIGN KEY ("participantId") REFERENCES "Participant" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Guess_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Guess" ("gameId", "id", "participantId") SELECT "gameId", "id", "participantId" FROM "Guess";
DROP TABLE "Guess";
ALTER TABLE "new_Guess" RENAME TO "Guess";
CREATE TABLE "new_Game" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "date" DATETIME NOT NULL,
    "firstTeamCountryCode" TEXT NOT NULL,
    "secondTeamCountryCode" TEXT NOT NULL,
    "createAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Game" ("createAt", "date", "firstTeamCountryCode", "id", "secondTeamCountryCode") SELECT "createAt", "date", "firstTeamCountryCode", "id", "secondTeamCountryCode" FROM "Game";
DROP TABLE "Game";
ALTER TABLE "new_Game" RENAME TO "Game";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
