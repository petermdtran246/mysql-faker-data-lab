// db.js
const mysql = require('mysql2');

// 🏊 Tạo connection pool (hồ chứa kết nối)
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '',   // nếu MySQL của mày không có password
  database: 'join_us',
  connectionLimit: 10,  // tối đa 10 kết nối cùng lúc
});

// ✅ Export pool ra để các file khác dùng
module.exports = pool;