-- 创建个人表
CREATE TABLE IF NOT EXISTS "T_Person" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "age" INTEGER,
    "height" REAL
);


-- 创建公司表
CREATE TABLE IF NOT EXISTS "T_Commpany" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "companyName" TEXT
);