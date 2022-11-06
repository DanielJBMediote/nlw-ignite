/*
  Warnings:

  - Added the required column `firstTeamCountryCode` to the `Game` table without a default value. This is not possible if the table is not empty.
  - Added the required column `secondTeamCountryCode` to the `Game` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Game" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "firstTeamPoints" INTEGER NOT NULL,
    "secondTeamPoints" INTEGER NOT NULL,
    "firstTeamCountryCode" TEXT NOT NULL,
    "secondTeamCountryCode" TEXT NOT NULL,
    "createAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Game" ("createAt", "firstTeamPoints", "id", "secondTeamPoints") SELECT "createAt", "firstTeamPoints", "id", "secondTeamPoints" FROM "Game";
DROP TABLE "Game";
ALTER TABLE "new_Game" RENAME TO "Game";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
