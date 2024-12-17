﻿CREATE DATABASE QLBH
USE QLBH

CREATE TABLE KHACHHANG(
	MAKH char(4) PRIMARY KEY,
	HOTEN varchar(40),
	DIACHI varchar(50),
	SDT varchar(20),
	NGSINH smalldatetime,
	DOANHSO money,
	NGDK smalldatetime,
);

CREATE TABLE NHANVIEN(
	MANV char(4) PRIMARY KEY,
	HOTEN varchar(40),
	NGVL smalldatetime,
	SDT varchar(20),
);

CREATE TABLE SANPHAM(
	MASP char(4) PRIMARY KEY,
	TENSP varchar(40),
	DVT varchar(20),
	NUOCSX varchar(20),
	GIA money,
);

CREATE TABLE HOADON(
	SOHD int PRIMARY KEY,
	NGHD smalldatetime,
	MAKH char(4) REFERENCES KHACHHANG(MAKH),
	MANV char(4) REFERENCES NHANVIEN(MANV),
	TRIGIA money,
);

CREATE TABLE CTHD(
	SOHD int REFERENCES HOADON(SOHD),
	MASP char(4) REFERENCES SANPHAM(MASP),
	SL int,
	PRIMARY KEY (SOHD, MASP),
);





ALTER TABLE SANPHAM
ADD GHICHU varchar(20)

ALTER TABLE KHACHHANG
ADD LOAIKH tinyint 

ALTER TABLE SANPHAM
ALTER COLUMN GHICHU varchar(100)

ALTER TABLE SANPHAM
DROP COLUMN GHICHU

ALTER TABLE KHACHHANG ALTER COLUMN LOAIKH varchar(12)
ALTER TABLE KHACHHANG ADD CONSTRAINT CHECKLOAIKH CHECK( LOAIKH IN ('Vang lai', 'Thuong xuyen', 'Vip'))

ALTER TABLE SANPHAM ADD CONSTRAINT CHECKSP CHECK(DVT IN('cay', 'hop', 'cai', 'quyen', 'chuc'))

ALTER TABLE SANPHAM ADD CONSTRAINT CHECKGIA CHECK(GIA>=500)

ALTER TABLE HOADON ADD CONSTRAINT CHECKSOSPMUA CHECK(TRIGIA>0)

ALTER TABLE KHACHHANG ADD CONSTRAINT CHECKNGAYDK CHECK(NGDK>=NGSINH)

--LAB2
--CÂU 1 LAB 2:
INSERT INTO SANPHAM (MASP, TENSP, DVT, NUOCSX, GIA)
VALUES
('BC01', 'But chi', 'cay', 'Singapore', 3000),
('BC02', 'But chi', 'cay', 'Singapore', 5000),
('BC03', 'But chi', 'cay', 'Viet Nam', 3500),
('BC04', 'But chi', 'hop', 'Viet Nam', 30000),
('BB01', 'But bi', 'cay', 'Viet Nam', 5000),
('BB02', 'But bi', 'cay', 'Trung Quoc', 7000),
('BB03', 'But bi', 'hop', 'Thai Lan', 100000),
('TV01', 'Tap 100 giay mong', 'quyen', 'Trung Quoc', 2500),
('TV02', 'Tap 200 giay mong', 'quyen', 'Trung Quoc', 4500),
('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', 3000),
('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', 5500),
('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', 23000),
('TV06', 'Tap 200 trang', 'chuc', 'Viet Nam', 53000),
('TV07', 'Tap 100 trang', 'chuc', 'Trung Quoc', 34000),
('ST01', 'So tay 500 trang', 'quyen', 'Trung Quoc', 40000),
('ST02', 'So tay loai 1', 'quyen', 'Viet Nam', 55000),
('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', 51000),
('ST04', 'So tay', 'quyen', 'Thai Lan', 55000),
('ST05', 'So tay mong', 'quyen', 'Thai Lan', 20000),
('ST06', 'Phan viet bang', 'hop', 'Viet Nam', 5000),
('ST07', 'Phan khong bui', 'hop', 'Viet Nam', 7000),
('ST08', 'Bong bang', 'cai', 'Viet Nam', 1000),
('ST09', 'But long', 'cay', 'Viet Nam', 5000),
('ST10', 'But long', 'cay', 'Trung Quoc', 7000);

INSERT INTO NHANVIEN (MANV, HOTEN, SDT, NGVL) 
VALUES 
('NV01', 'Nguyen Nhu Nhut', '0927345678', '2006-04-13'),
('NV02', 'Le Thi Phi Yen', '0987567390', '2006-04-21'),
('NV03', 'Nguyen Van B', '0997047382', '2006-04-27'),
('NV04', 'Ngo Thanh Tuan', '0913758498', '2006-06-24'),
('NV05', 'Nguyen Thi Truc Thanh', '0918590387', '2006-07-20');

INSERT INTO KHACHHANG (MAKH, HOTEN, DIACHI, SDT, NGSINH, DOANHSO, NGDK)
VALUES
('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', '08823451', '1960-10-22', 13060000, '2006-07-22'),
('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TpHCM', '0908256478', '1974-04-03', 280000, '2006-07-30'),
('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM', '0938776266', '1980-06-12', 3860000, '2006-08-05'),
('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TpHCM', '0917325476', '1965-03-09', 250000, '2006-10-02'),
('KH05', 'Le Nhat Minh', '34 Truong Dinh, Q3, TpHCM', '08246108', '1950-03-10', 21000, '2006-10-28'),
('KH06', 'Le Hoai Thuong', '227 Nguyen Van Cu, Q5, TpHCM', '08631738', '1981-12-31', 915000, '2006-11-24'),
('KH07', 'Nguyen Van Tam', '32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', '1971-04-06', 12500, '2006-12-01'),
('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TpHCM', '0938435756', '1971-01-10', 365000, '2006-12-13'),
('KH09', 'Le Ha Vinh', '873 Le Hong Phong, Q5, TpHCM', '08654763', '1979-09-03', 70000, '2007-01-14'),
('KH10', 'Ha Duy Lap', '34/34B Nguyen Trai, Q1, TpHCM', '08768904', '1983-05-02', 67500, '2007-01-16');

INSERT INTO HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA)
VALUES
(1001, '2006-07-23', 'KH01', 'NV01', 320000),
(1002, '2006-08-12', 'KH01', 'NV02', 840000),
(1003, '2006-08-23', 'KH02', 'NV01', 100000),
(1004, '2006-09-01', 'KH02', 'NV01', 180000),
(1005, '2006-10-20', 'KH01', 'NV02', 3800000),
(1006, '2006-10-16', 'KH01', 'NV03', 2430000),
(1007, '2006-10-28', 'KH03', 'NV03', 510000),
(1008, '2006-10-28', 'KH01', 'NV03', 440000),
(1009, '2006-10-28', 'KH03', 'NV04', 200000),
(1010, '2006-11-01', 'KH01', 'NV01', 5200000),
(1011, '2006-11-04', 'KH04', 'NV03', 250000),
(1012, '2006-11-30', 'KH05', 'NV03', 21000),
(1013, '2006-12-12', 'KH06', 'NV01', 5000),
(1014, '2006-12-31', 'KH03', 'NV02', 3150000),
(1015, '2007-01-01', 'KH06', 'NV01', 910000),
(1016, '2007-01-01', 'KH07', 'NV02', 12500),
(1017, '2007-01-02', 'KH08', 'NV03', 35000),
(1018, '2007-01-13', 'KH08', 'NV03', 330000),
(1019, '2007-01-13', 'KH01', 'NV03', 30000),
(1020, '2007-01-14', 'KH09', 'NV04', 70000),
(1021, '2007-01-16', 'KH10', 'NV03', 67500),
(1022, '2007-01-16', NULL, 'NV03', 7000),
(1023, '2007-01-17', NULL, 'NV01', 330000);

INSERT INTO CTHD (SOHD, MASP, SL)
VALUES
(1001, 'TV02', 10),
(1001, 'ST01', 5),
(1001, 'BC01', 5),
(1001, 'BC02', 10),
(1001, 'ST08', 10),
(1002, 'BC04', 20),
(1002, 'BB01', 20),
(1002, 'BB02', 20),
(1003, 'BB03', 10),
(1004, 'TV01', 20),
(1004, 'TV02', 10),
(1004, 'TV03', 10),
(1004, 'TV04', 10),
(1005, 'TV05', 50),
(1005, 'TV06', 50),
(1006, 'TV07', 20),
(1006, 'ST01', 30),
(1006, 'ST02', 10),
(1007, 'ST03', 10),
(1008, 'ST04', 8),
(1009, 'ST05', 10),
(1010, 'TV07', 50),
(1010, 'ST07', 50),
(1010, 'ST08', 100),
(1010, 'ST04', 50),
(1010, 'TV03', 100),
(1011, 'ST06', 50),
(1012, 'ST07', 3),
(1013, 'ST08', 5),
(1014, 'BC02', 80),
(1014, 'BB02', 100),
(1014, 'BC04', 60),
(1014, 'BB01', 50),
(1015, 'BB02', 30),
(1015, 'BB03', 7),
(1016, 'TV01', 5),
(1017, 'TV02', 1),
(1017, 'TV03', 1),
(1017, 'TV04', 5),
(1018, 'ST04', 6),
(1019, 'ST05', 1),
(1019, 'ST06', 2),
(1020, 'ST07', 10),
(1021, 'ST08', 5),
(1021, 'TV01', 7),
(1021, 'TV02', 10),
(1022, 'ST07', 1),
(1023, 'ST04', 6);



--LAB5:
--Sinh viên hoàn thành Phần I bài tập QuanLyBanHang từ câu 11 đến 14.
--Câu 11. Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên (NGDK).
GO
CREATE TRIGGER trg_ins_hd ON HOADON
FOR INSERT
AS
BEGIN
DECLARE @NgayHD smalldatetime, @MaKH char(4), @NgayDK smalldatetime
SELECT @NgayHD = NGHD, @MaKH = MAKH
FROM INSERTED
SELECT @NgayDK = NGDK
FROM KHACHHANG
WHERE MAKH = @MaKH
IF (@NgayHD < @NgayDK)
BEGIN
    PRINT 'LOI: NGAY HOA DON KHONG HOP LE!'
    ROLLBACK TRANSACTION
END
ELSE
	BEGIN
		PRINT 'THEM MOI MOT HOA DON THANH CONG!'
	END
END
GO
--Câu 12: Ngày bán hàng (NGHD) của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.
CREATE TRIGGER trg_nhanvien ON HOADON
FOR INSERT
AS
BEGIN
DECLARE @NgayHD smalldatetime, @MaNV char(4), @NgayVL smalldatetime
SELECT @NgayHD = NGHD, @MaNV = MANV
FROM INSERTED
SELECT @NgayVL = NGVL
FROM NHANVIEN
WHERE MANV = @MaNV
IF (@NgayHD < @NgayVL)
BEGIN
    PRINT 'LOI: NGAY HOA DON KHONG HOP LE!'
    ROLLBACK TRANSACTION
END
ELSE
	BEGIN
		PRINT 'THEM MOI MOT HOA DON THANH CONG!'
	END
END
GO
--Câu 13: Trị giá của một hóa đơn là tổng thành tiền (số lượng*đơn giá) của các chi tiết thuộc hóa đơn đó. 
CREATE TRIGGER trg_ins_cthd ON CTHD
FOR INSERT
AS
BEGIN
    DECLARE @SoHD int, @MaSP char(4), @SoLg int, @TriGia money;
    SELECT @SoHD = SOHD, @MaSP = MASP, @SoLg = SL
    FROM INSERTED;
    SET @TriGia = @SoLg * (SELECT GIA FROM SANPHAM WHERE MASP = @MaSP);
    DECLARE cur_cthd CURSOR FOR
        SELECT MASP, SL
        FROM CTHD
        WHERE SOHD = @SoHD;

    OPEN cur_cthd;
    FETCH NEXT FROM cur_cthd INTO @MaSP, @SoLg;

    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        SET @TriGia = @TriGia + @SoLg * (SELECT GIA FROM SANPHAM WHERE MASP = @MaSP);
        FETCH NEXT FROM cur_cthd INTO @MaSP, @SoLg;
    END;

    CLOSE cur_cthd;
    DEALLOCATE cur_cthd;
    UPDATE HOADON
    SET TRIGIA = @TriGia
    WHERE SOHD = @SoHD;
END;
GO
--Câu 14: Doanh số của một khách hàng là tổng trị giá các hóa đơn mà khách hàng thành viên đó đã mua. 
CREATE TRIGGER trg_update_doanhso ON HOADON
FOR INSERT
AS
BEGIN
    DECLARE @MaKH char(4), @TriGia money;
    SELECT @MaKH = MAKH, @TriGia = TRIGIA
    FROM INSERTED;
    UPDATE KHACHHANG
    SET DOANHSO = ISNULL(DOANHSO, 0) + @TriGia
    WHERE MAKH = @MaKH;
END;
