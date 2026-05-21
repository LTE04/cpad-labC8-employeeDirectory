Employee Directory - Chapter 8 Assigment

NAME : LEE TUNG ERN
MATRIC NO : A24CS0103
SECTION : 04
COURSE : SCSM2223 CROSS PLATFORM APPLICATION DEVELOPMENT
LECTURER : HISHAMMUDDIN BIN ASMUNI @ HASMUNI


# Setup Instruction
# Step 1 — Start MySQL
- Open Laragon
- Click Start All
- Make sure MySQL shows green

# Step 2 — Set up database
- Open HeidiSQL in Laragon
- File, Load SQL file, choose sql/schema.sql
- Press F9 to run it

# Step 3 — Install dependencies
- Open terminal in project folder
- Run: npm install
- Run: cd server → npm install → cd ..

# Step 4 — Start backend
- Open Terminal 1
- Run: npm run server
- Should see: API running at http://localhost:3001

# Step 5 — Start frontend
- Open Terminal 2
- Run: npm run dev
- Open browser: http://localhost:5174

# this is the project files
- src/api/employeeApi.js — Axios service (all API calls here)
- src/components/EmployeeForm.vue — Add and Edit form
- src/components/EmployeeList.vue — Employee table
- src/App.vue — Main page, controls everything
- server/index.js — Express API routes
- server/db.js — MySQL connection
- sql/schema.sql — Database setup and sample data

# What This App Does
- Shows a list of employees from a MySQL database
- You can Add, Edit, Delete employees
- You can Search by name, ID or email
- You can Sort by name, hire date or salary
- Shows Active or Inactive status with coloured badges
- Salary is shown in Malaysian Ringgit (RM) format

# Tools Used
- Vue 3 (frontend UI)
- Axios (HTTP requests)
- Express + Node.js (backend server)
- MySQL via Laragon (database)

# Features
- Full CRUD: Create, Read, Update, Delete employees
- Server-side search by name, empId, email
- Server-side sort by name, hireDate, salary
- Client-side validation with inline error messages
- Active/Inactive badge display
- Salary formatted as Malaysian Ringgit (RM)
- Loading state and error banner
- Responsive layout for laptop and tablet