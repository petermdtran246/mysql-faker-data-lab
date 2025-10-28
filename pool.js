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
