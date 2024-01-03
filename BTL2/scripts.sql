// Khoi tao CLUSTER
arangodb \
    --server.storage-engine=rocksdb \
    --starter.data-dir=data \
    --starter.join 26.182.238.200,26.83.35.244,26.191.62.34

// INSERT HOADON
FOR hoadon in [
    {MAHD: "HD01", KHACHHANG: "Nguyen Duc Tri", SDT: "0937859594", DIACHI: "Ap 3,Tan Thanh, Thu Thua, Long An", MANV: "NV04"}, 
    {MAHD: "HD02", KHACHHANG: "Nguyen Hoang Nhan", SDT: "028347852", DIACHI: "Tan Mai, Bien Hoa, Dong Nai", MANV: "NV03"}, 
    {MAHD: "HD03", KHACHHANG: "Dang Hoang Quan", SDT: "036845271", DIACHI: "Phuong 15, Tan Binh, TP.HCM", MANV: "NV04"}, 
    {MAHD: "HD04", KHACHHANG: "Nguyen Duc Tri", SDT: "0937859594", DIACHI: "Ap 3,Tan Thanh, Thu Thua, Long An", MANV: "NV03"}
] INSERT hoadon INTO HOADON

// INSERT NHANVIEN
FOR nhanvien IN [
    {MANV: "NV01", TENNV: "Pham Phu Phuoc", CHUCVU: "Quan li"}, 
    {MANV: "NV02", TENNV: "Nguyen Thi B", CHUCVU: "Ke toan"}, 
    {MANV: "NV03", TENNV: "Tran Van A", CHUCVU: "Van chuyen"}, 
    {MANV: "NV04", TENNV: "Tran Van B", CHUCVU: "Van chuyen"}
] INSERT nhanvien INTO NHANVIEN

// INSERT CTHD
FOR cthd IN [
    {MAHD: "HD01", MASP: "CAT", SOLUONG: 20, THANHTIEN: 2800000}, 
    {MAHD: "HD01", MASP: "DA", SOLUONG: 10, THANHTIEN: 2300000}, 
    {MAHD: "HD02", MASP: "XM", SOLUONG: 30, THANHTIEN: 2220000}, 
    {MAHD: "HD03", MASP: "CAT", SOLUONG: 10, THANHTIEN: 1400000}
] INSERT cthd INTO CTHD

// INSERT SANPHAM
FOR sanpham IN [
    {MASP: "CAT", TENSP: "Cat", Gia: 140000, SL: 10000}, 
    {MASP: "DA", TENSP: "Da", Gia: 230000, SL: 200000}, 
    {MASP: "XM", TENSP: "Xi mang", Gia: 74000, SL: 5000}
] INSERT sanpham INTO SANPHAM

// Query
FOR doc IN CTHD
    COLLECT group = doc.MAHD
    AGGREGATE s = SUM(doc.THANHTIEN)
    RETURN { group, s }

// View all
FOR doc in HOADON 
    return doc

// View khachhang
FOR doc IN HOADON
    FILTER doc.DIACHI == "Phuong 15, Tan Binh, TP.HCM"
    RETURN doc.KHACHHANG

// Update
UPDATE "16610"
WITH { TENNV : "Dang Quang Nhat" }
IN NHANVIEN

FOR doc in NHANVIEN
    RETURN doc

//Remove
FOR doc IN NHANVIEN
FILTER doc.TENNV == "Dang Quang Nhat"
REMOVE doc IN NHANVIEN

// check remove
FOR doc IN NHANVIEN
    FILTER doc.TENNV == "Dang Quang Nhat"
    RETURN doc.TENNV

// More View
FOR doc IN CTHD
    COLLECT group = doc.MAHD
    AGGREGATE s = SUM(doc.THANHTIEN)
    RETURN { group, s }


