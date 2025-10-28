CREATE DATABASE faker_lab;
USE faker_lab;

CREATE TABLE users (
  email VARCHAR(255) PRIMARY KEY,
  created_at TIMESTAMP DEFAULT NOW()
);

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
