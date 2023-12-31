import { Client, logger, Variables } from "camunda-external-task-client-js";
import connection from "./data/connecto.js";
import dotenv from 'dotenv';

dotenv.config()

const config = {
    baseUrl: "http://localhost:8080/engine-rest",
    use: logger,
};
// Khởi tạo đối tượng Client
const client = new Client(config);
// Định nghĩa hàm xử lý cho external task với key là "oraclebot"
const registerClaimHandler = async ({ task, taskService }) => {
        // Lấy dữ liệu từ biến của external task
    const CUSID = task.variables.get("CUSTOMERID");
    const CUSNAME = task.variables.get("NAME");
    const PHONE = task.variables.get("PHONE");
    const ADDRESS = task.variables.get("ADDRESS");

    console.log(task.variables);
    
    try {
        // Thực hiện INSERT dữ liệu vào bảng "KHACHHANG" trong cơ sở dữ liệu Oracle
        const data = await connection.execute(`INSERT INTO KHACHHANG VALUES ('${CUSID}', '${CUSNAME}', '${PHONE}', '${ADDRESS}')`);
        console.log(data.rows);
        // Thực hiện COMMIT để xác nhận các thay đổi và lưu trữ dữ liệu
        await connection.execute("COMMIT");
        console.log("Dữ liệu đã được cập nhật thành công");
        
        await taskService.complete(task);
        console.log("Added new claim to database");
    } catch (e) {
        // Nếu có lỗi, thực hiện ROLLBACK để hủy bỏ các thay đổi
        await connection.rollback();
        throw new Error(`Failed completing register claim task: ${e}`);
    } finally {
        // Cuối cùng, đóng kết nối
        await connection.close();
    }

};

client.subscribe("oraclebot", registerClaimHandler);
