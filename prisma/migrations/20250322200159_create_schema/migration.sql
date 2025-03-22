-- CreateTable
CREATE TABLE "Builder" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Apartament" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "builderId" INTEGER NOT NULL,
    CONSTRAINT "Apartament_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Builder" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TypeVehicle" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "type" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Vehicle" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "licensePlate" TEXT NOT NULL,
    "description" TEXT,
    "typeId" INTEGER NOT NULL,
    CONSTRAINT "Vehicle_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "TypeVehicle" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TypeDocument" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "type" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "State" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "state" TEXT NOT NULL DEFAULT 'Activo'
);

-- CreateTable
CREATE TABLE "Resident" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "idCard" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "documentTypeId" INTEGER NOT NULL,
    "stateId" INTEGER NOT NULL,
    "apartmentId" INTEGER NOT NULL,
    CONSTRAINT "Resident_documentTypeId_fkey" FOREIGN KEY ("documentTypeId") REFERENCES "TypeDocument" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Resident_stateId_fkey" FOREIGN KEY ("stateId") REFERENCES "State" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Resident_apartmentId_fkey" FOREIGN KEY ("apartmentId") REFERENCES "Apartament" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "VehicleResident" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "vehicleId" INTEGER NOT NULL,
    "residentId" INTEGER NOT NULL,
    "stateId" INTEGER NOT NULL,
    CONSTRAINT "VehicleResident_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "VehicleResident_residentId_fkey" FOREIGN KEY ("residentId") REFERENCES "Resident" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "VehicleResident_stateId_fkey" FOREIGN KEY ("stateId") REFERENCES "State" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Visitant" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "idCard" TEXT NOT NULL,
    "photo" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Visit" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "dateEntry" DATETIME NOT NULL,
    "timeEntry" TEXT NOT NULL,
    "dateExit" DATETIME,
    "timeExit" TEXT,
    "observation" TEXT,
    "stateId" INTEGER NOT NULL,
    "apartmentId" INTEGER NOT NULL,
    "authorizerId" INTEGER NOT NULL,
    "visitantId" INTEGER NOT NULL,
    CONSTRAINT "Visit_stateId_fkey" FOREIGN KEY ("stateId") REFERENCES "State" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Visit_apartmentId_fkey" FOREIGN KEY ("apartmentId") REFERENCES "Apartament" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Visit_authorizerId_fkey" FOREIGN KEY ("authorizerId") REFERENCES "Resident" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Visit_visitantId_fkey" FOREIGN KEY ("visitantId") REFERENCES "Visitant" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Role" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "roleId" INTEGER NOT NULL,
    "stateId" INTEGER NOT NULL,
    CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "User_stateId_fkey" FOREIGN KEY ("stateId") REFERENCES "State" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Sesion" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "token" TEXT,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Sesion_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Configuration" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "theme" TEXT NOT NULL DEFAULT 'light',
    "builderType" TEXT NOT NULL DEFAULT 'Torre',
    "maxVehiclesPerResident" INTEGER NOT NULL DEFAULT 2
);

-- CreateIndex
CREATE UNIQUE INDEX "Builder_name_key" ON "Builder"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Apartament_name_key" ON "Apartament"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Apartament_builderId_name_key" ON "Apartament"("builderId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "TypeVehicle_type_key" ON "TypeVehicle"("type");

-- CreateIndex
CREATE UNIQUE INDEX "Vehicle_licensePlate_key" ON "Vehicle"("licensePlate");

-- CreateIndex
CREATE UNIQUE INDEX "TypeDocument_type_key" ON "TypeDocument"("type");

-- CreateIndex
CREATE UNIQUE INDEX "State_state_key" ON "State"("state");

-- CreateIndex
CREATE UNIQUE INDEX "Resident_idCard_key" ON "Resident"("idCard");

-- CreateIndex
CREATE INDEX "Resident_idCard_name_idx" ON "Resident"("idCard", "name");

-- CreateIndex
CREATE UNIQUE INDEX "VehicleResident_vehicleId_residentId_key" ON "VehicleResident"("vehicleId", "residentId");

-- CreateIndex
CREATE UNIQUE INDEX "Visitant_idCard_key" ON "Visitant"("idCard");

-- CreateIndex
CREATE UNIQUE INDEX "Role_name_key" ON "Role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Sesion_token_key" ON "Sesion"("token");
