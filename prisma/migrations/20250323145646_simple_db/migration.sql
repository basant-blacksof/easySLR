/*
  Warnings:

  - You are about to drop the column `createdById` on the `Task` table. All the data in the column will be lost.
  - You are about to drop the column `deadline` on the `Task` table. All the data in the column will be lost.
  - You are about to drop the column `progress` on the `Task` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Task` table. All the data in the column will be lost.
  - The `priority` column on the `Task` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `emailVerified` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Account` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Session` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Tag` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TaskAssignment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `VerificationToken` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_TagToTask` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `assignees` to the `Task` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tags` to the `Task` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "TaskStatus" AS ENUM ('TODO', 'IN_PROGRESS', 'DONE');

-- CreateEnum
CREATE TYPE "TaskPriority" AS ENUM ('CRITICAL', 'HIGH', 'MEDIUM', 'LOW');

-- DropForeignKey
ALTER TABLE "Account" DROP CONSTRAINT "Account_userId_fkey";

-- DropForeignKey
ALTER TABLE "Session" DROP CONSTRAINT "Session_userId_fkey";

-- DropForeignKey
ALTER TABLE "Task" DROP CONSTRAINT "Task_createdById_fkey";

-- DropForeignKey
ALTER TABLE "TaskAssignment" DROP CONSTRAINT "TaskAssignment_taskId_fkey";

-- DropForeignKey
ALTER TABLE "TaskAssignment" DROP CONSTRAINT "TaskAssignment_userId_fkey";

-- DropForeignKey
ALTER TABLE "_TagToTask" DROP CONSTRAINT "_TagToTask_A_fkey";

-- DropForeignKey
ALTER TABLE "_TagToTask" DROP CONSTRAINT "_TagToTask_B_fkey";

-- AlterTable
ALTER TABLE "Task" DROP COLUMN "createdById",
DROP COLUMN "deadline",
DROP COLUMN "progress",
DROP COLUMN "updatedAt",
ADD COLUMN     "assignees" JSONB NOT NULL,
ADD COLUMN     "dueDate" TIMESTAMP(3),
ADD COLUMN     "status" "TaskStatus" NOT NULL DEFAULT 'TODO',
ADD COLUMN     "tags" JSONB NOT NULL,
DROP COLUMN "priority",
ADD COLUMN     "priority" "TaskPriority" NOT NULL DEFAULT 'MEDIUM';

-- AlterTable
ALTER TABLE "User" DROP COLUMN "emailVerified",
DROP COLUMN "image",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "password" TEXT NOT NULL;

-- DropTable
DROP TABLE "Account";

-- DropTable
DROP TABLE "Session";

-- DropTable
DROP TABLE "Tag";

-- DropTable
DROP TABLE "TaskAssignment";

-- DropTable
DROP TABLE "VerificationToken";

-- DropTable
DROP TABLE "_TagToTask";

-- DropEnum
DROP TYPE "Priority";
