const bcrypt = require('bcryptjs'), mysql = require('mysql2/promise');
require('dotenv').config();
async function setupUsers() {
  try {
    const connection = await mysql.createConnection({ host: process.env.DB_HOST, user: process.env.DB_USER, password: process.env.DB_PASSWORD, database: process.env.DB_NAME });
    console.log('✓ Connesso al database');
    const adminPasswordHash = await bcrypt.hash('admin', 10), userPasswordHash = await bcrypt.hash('utente', 10);

    // Use Stored Procedure to setup users
    const [result] = await connection.query('CALL sp_setup_users(?, ?)', [adminPasswordHash, userPasswordHash]);
    const users = result[0]; // SP returns result set in first index

    console.log('✓ Setup completato!\nCredenziali:\nAdmin: username=admin, password=admin\nUser: username=utente, password=utente');
    console.table(users);
    await connection.end();
  } catch (error) {
    console.error('❌ Errore:', error.message);
    process.exit(1);
  }
}

setupUsers();
