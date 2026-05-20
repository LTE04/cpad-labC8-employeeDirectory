-- sql/schema.sql
CREATE DATABASE IF NOT EXISTS employee_db
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE employee_db;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  empId      VARCHAR(10)    NOT NULL UNIQUE,
  name       VARCHAR(100)   NOT NULL,
  email      VARCHAR(100)   NOT NULL,
  department ENUM('IT','HR','Finance','Marketing','Operations') NOT NULL,
  position   VARCHAR(100)   NOT NULL,
  hireDate   DATE           NOT NULL,
  salary     DECIMAL(10,2)  NOT NULL,
  active     TINYINT(1)     NOT NULL DEFAULT 1,
  CHECK (salary >= 1500 AND salary <= 50000)
) ENGINE=InnoDB;

INSERT INTO employees
  (empId,name,email,department,position,hireDate,salary,active)
VALUES
  ('EMP001','Ahmad Zulkifli','ahmad@company.my','IT','Software Developer','2021-03-15',5500.00,1),
  ('EMP002','Siti Nurhaliza','siti@company.my','HR','HR Manager','2019-07-01',6200.00,1),
  ('EMP003','Tan Wei Liang','tan@company.my','Finance','Financial Analyst','2020-01-10',5800.00,1),
  ('EMP004','Nurul Ain','nurul@company.my','Marketing','Marketing Executive','2022-05-20',4500.00,1),
  ('EMP005','Rajesh Kumar','rajesh@company.my','IT','Senior Developer','2018-11-05',8500.00,1),
  ('EMP006','Farah Diana','farah@company.my','Operations','Operations Coordinator','2023-02-14',4200.00,0),
  ('EMP007','David Lim','david@company.my','Finance','Chief Financial Officer','2017-06-01',15000.00,1);