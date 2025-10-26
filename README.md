# mysql-faker-data-lab
Generate, insert, and analyze 500+ user records with Node.js, MySQL, and Faker.js — a practical data analytics sandbox


<h1 align="center">⚡ MySQL + Node.js Data Lab</h1>

<p align="center">
  <b>📊 A realistic simulation of user data generation, bulk insertion, and SQL analytics using Node.js, MySQL, and Faker.js.</b><br>
  <i>Learn how to automate database workflows, analyze patterns, and scale data like a backend developer.</i>
</p>

---

## 🌟 Overview

This project demonstrates a **complete backend-to-database workflow** using:

- ⚙️ **Node.js + MySQL2** for database connection  
- 🧩 **Faker.js** to generate 500 realistic fake users  
- 📈 **SQL aggregation & date functions** for analysis  

> 💡 Built as a learning lab for data analytics and backend engineering.

---

## 🧱 Project Structure

📦 mysql-faker-data-lab/
├── db.js # Connection pool setup
├── pool.js # Node.js script to generate and insert users
├── schema.sql # SQL schema and analysis queries
└── assets/ # Screenshots (terminal + SQL output)

---

⚙️ Setup Instructions

1️⃣ Install Dependencies
```bash
npm install mysql2 @faker-js/faker


2️⃣ Start MySQL
sudo service mysql start
mysql -u root

3️⃣ Create Database and Table
CREATE DATABASE faker_lab;
USE faker_lab;

CREATE TABLE users (
  email VARCHAR(255) PRIMARY KEY,
  created_at TIMESTAMP DEFAULT NOW()
);


🧩 File: db.js
const mysql = require('mysql2');

// 🏊 Create a connection pool (for concurrent queries)
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'faker_lab',
  connectionLimit: 10,
});

module.exports = pool;


🧩 File: pool.js
const { faker } = require('@faker-js/faker');
const pool = require('./db');

// Step 1: Generate 500 random users
let data = [];
for (let i = 0; i < 500; i++) {
  data.push([faker.internet.email(), faker.date.past()]);
}

console.log(`⚙️ Preparing to insert ${data.length} users...`);

// Step 2: Insert into MySQL
const q = 'INSERT INTO users (email, created_at) VALUES ?';
pool.query(q, [data], (err, result) => {
  if (err) throw err;
  console.log(`✅ Successfully inserted ${result.affectedRows} users!`);
});

💻 Terminal Output (Mock Example)
<div align="center"> <img src="https://dummyimage.com/720x260/0d1117/00ff91&text=%24+node+pool.js%0A%E2%9A%99%EF%B8%8F+Preparing+to+insert+500+users...%0A%E2%9C%85+Successfully+inserted+500+users!" width="600" alt="Node.js Terminal Output Example"> <br> <sub><i>✔️ Node.js bulk inserted 500 users into MySQL using connection pooling</i></sub> </div>


🧠 SQL Analysis (schema.sql)
🥇 1. Earliest Date a User Joined
SELECT DATE_FORMAT(MIN(created_at), '%b %D %X') AS earliest_date 
FROM users;

🧍‍♂️ 2. Find the First User (Earliest Email)
SELECT email, created_at
FROM users
WHERE created_at = (SELECT MIN(created_at) FROM users);


🗓 3. Users by Month Joined
SELECT 
  MONTHNAME(created_at) AS month,
  COUNT(*) AS total_users
FROM users
GROUP BY month
ORDER BY MIN(MONTH(created_at));

📬 4. Count Yahoo Users
SELECT COUNT(*) AS yahoo_users
FROM users
WHERE email LIKE '%@yahoo.com';

🌐 5. Users by Email Provider
SELECT 
  CASE
    WHEN email LIKE '%@gmail.com' THEN 'gmail'
    WHEN email LIKE '%@yahoo.com' THEN 'yahoo'
    WHEN email LIKE '%@hotmail.com' THEN 'hotmail'
    ELSE 'other'
  END AS provider,
  COUNT(*) AS total_users
FROM users
GROUP BY provider;


📊 SQL Output (Mock Example)
<div align="center"> <img src="https://dummyimage.com/560x260/ffffff/00758f&text=%7C+provider+%7C+total_users+%7C%0A%7C-----------%7C--------------%7C%0A%7C+gmail+++++%7C+243++++++++++%7C%0A%7C+yahoo+++++%7C+136++++++++++%7C%0A%7C+hotmail+++%7C+120++++++++++%7C%0A%7C+other+++++%7C+1++++++++++++%7C" width="520" alt="SQL Output Example"> <br> <sub><i>💾 Aggregated users by email domain using CASE + GROUP BY</i></sub> </div>

🧠 Concepts Learned
| Concept                    | Description                              |
| -------------------------- | ---------------------------------------- |
| `faker.internet.email()`   | Generate random realistic emails         |
| `INSERT INTO ... VALUES ?` | Bulk insert syntax for performance       |
| `CASE WHEN`                | Categorize records based on conditions   |
| `GROUP BY`                 | Aggregate and summarize data             |
| `createPool()`             | Maintain multiple concurrent connections |
| `LIKE '%@gmail.com'`       | Filter by email pattern                  |


🧩 Real-World Applications
✅ Automate fake data generation for testing APIs
✅ Learn SQL analytics (count, filter, group, format)
✅ Understand connection pooling for backend scalability
✅ Practice pattern-matching and subqueries for data analysis

