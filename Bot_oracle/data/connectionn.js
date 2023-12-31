import oracledb from 'oracledb';
import dotenv from 'dotenv';

dotenv.config();

// Thiết lập thông tin kết nối Oracle
const oracleConfig = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  connectString: `${process.env.DB_HOST}:${process.env.PORT}/${process.env.DB_NAME}`,
};


// Kết nối và trả về promise
async function connectToOracle() {
  let connection;
  try {
    connection = await oracledb.getConnection(oracleConfig);
    console.log('Kết nối Oracle thành công');
    return connection;
  } catch (error) {
    console.error('Lỗi kết nối Oracle:', error);
    throw error;
  }
}

// Kết nối và trả về promise
const connection = await connectToOracle();

export default connection;