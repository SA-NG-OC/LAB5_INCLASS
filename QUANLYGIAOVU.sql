CREATE DATABASE QUANLYGIAOVU


CREATE TABLE KHOA 
(
	MAKHOA VARCHAR(4) PRIMARY KEY,
	TENKHOA VARCHAR(40),
	NGTLAP SMALLDATETIME,
	TRGKHOA CHAR(4)
);

CREATE TABLE MONHOC
(
	MAMH VARCHAR(10) PRIMARY KEY,
	TENMH VARCHAR(40),
	TCLT TINYINT,
	TCTH TINYINT,
	MAKHOA VARCHAR(4),
);

CREATE TABLE DIEUKIEN
(
	MAMH VARCHAR(10),
	MAMH_TRUOC VARCHAR(10),
	PRIMARY KEY (MAMH, MAMH_TRUOC)
);

CREATE TABLE GIAOVIEN
(
	MAGV CHAR(4) PRIMARY KEY,
	HOTEN VARCHAR(40),
	HOCVI VARCHAR(10),
	HOCHAM VARCHAR(10),
	GIOITINH VARCHAR(3),
	NGSINH SMALLDATETIME,
	NGVL SMALLDATETIME,
	HESO NUMERIC(4,2),
	MUCLUONG MONEY,
	MAKHOA VARCHAR(4)
);

CREATE TABLE HOCVIEN
(
	MAHV CHAR(5) PRIMARY KEY,
	HO VARCHAR(40),
	TEN VARCHAR(10),
	NGSINH SMALLDATETIME,
	GIOITINH VARCHAR(3),
	NOISINH VARCHAR(40),
	MALOP CHAR(3),
);

CREATE TABLE LOP
(
	MALOP CHAR(3) PRIMARY KEY,
	TENLOP VARCHAR(40),
	TRGLOP CHAR(5),
	SISO TINYINT,
	MAGVCN CHAR(4)
);

CREATE TABLE GIANGDAY
(
	MALOP CHAR(3),
	MAMH VARCHAR(10),
	MAGV CHAR(4),
	HOCKY TINYINT,
	NAM SMALLINT,
	TUNGAY SMALLDATETIME,
	DENNGAY SMALLDATETIME
	PRIMARY KEY (MALOP, MAMH),
);

CREATE TABLE KETQUATHI
(
	MAHV CHAR(5),
	MAMH VARCHAR(10),
	LANTHI TINYINT,
	NGTHI SMALLDATETIME,
	DIEM NUMERIC(4,2),
	KQUA VARCHAR(10)
	PRIMARY KEY (MAHV, MAMH, LANTHI)
);
--Thêm khóa ngoại
ALTER TABLE KHOA ADD CONSTRAINT FK_TRGKHOA FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV);

ALTER TABLE MONHOC ADD CONSTRAINT FK_MAKHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA);

ALTER TABLE DIEUKIEN ADD CONSTRAINT FK_MAMH_TRUOC FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC(MAMH);
ALTER TABLE DIEUKIEN ADD CONSTRAINT FK_MAMH FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH);

ALTER TABLE GIAOVIEN ADD CONSTRAINT FK_MAKHOA2 FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA);

ALTER TABLE LOP ADD CONSTRAINT FK_TRGLOP FOREIGN KEY(TRGLOP) REFERENCES HOCVIEN(MAHV);
ALTER TABLE LOP ADD CONSTRAINT FK_MAGVCN FOREIGN KEY(MAGVCN) REFERENCES GIAOVIEN(MAGV);

ALTER TABLE HOCVIEN ADD CONSTRAINT FK_LOP FOREIGN KEY (MALOP) REFERENCES LOP(MALOP);

ALTER TABLE GIANGDAY ADD CONSTRAINT FK_MAMH2 FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH);
ALTER TABLE GIANGDAY ADD CONSTRAINT FK_MALOP FOREIGN KEY (MALOP) REFERENCES LOP(MALOP);
ALTER TABLE GIANGDAY ADD CONSTRAINT FK_MAGV FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV);

ALTER TABLE KETQUATHI ADD CONSTRAINT FK_MAHV FOREIGN KEY (MAHV) REFERENCES HOCVIEN(MAHV);
ALTER TABLE KETQUATHI ADD CONSTRAINT FK_MAMH3 FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH);
-- I.
-- 3. Thuộc tính của GIOITINH chỉ có giá trị là "Nam" hoặc "Nữ".
ALTER TABLE HOCVIEN ADD
CONSTRAINT CK_GT_HV CHECK (GIOITINH IN ('Nam', 'Nu'))

ALTER TABLE GIAOVIEN ADD
CONSTRAINT CK_GT_GV CHECK (GIOITINH IN ('Nam', 'Nu'))

-- 4. Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ (VD: 6.22).
ALTER TABLE KETQUATHI ADD 
CONSTRAINT CK_DIEM CHECK (
	DIEM BETWEEN 0 AND 10 AND
	LEN(SUBSTRING(CAST(DIEM AS VARCHAR), CHARINDEX('.', DIEM) + 1, 1000)) >= 2
)

-- 5. Kết quả thi là “Dat” nếu điểm từ 5 đến 10  và “Khong dat” nếu điểm nhỏ hơn 5.
ALTER TABLE KETQUATHI ADD 
CONSTRAINT CK_KQUA CHECK (KQUA = IIF(DIEM BETWEEN 5 AND 10, 'Dat', 'Khong dat'))

-- 6. Học viên thi một môn tối đa 3 lần.
ALTER TABLE KETQUATHI ADD
CONSTRAINT CK_SOLANTHI CHECK (LANTHI <= 3)

-- 7. Học kì chỉ có giá trị từ 1 đến 3.
ALTER TABLE GIANGDAY ADD
CONSTRAINT CK_HOCKY CHECK (HOCKY BETWEEN 1 AND 3)

-- 8. Học vị của giáo viên chỉ có thể là "CN", "KS", "ThS", "TS", "PTS".
ALTER TABLE GIAOVIEN ADD
CONSTRAINT CK_HOCVI CHECK (HOCVI IN ('CN', 'KS', 'ThS', 'TS', 'PTS'))
--LAB2
-- Nhập dữ liệu cho KHOA --
INSERT INTO KHOA VALUES ('KHMT','Khoa hoc may tinh','6/7/2005','GV01'),
('HTTT','He thong thong tin','6/7/2005','GV02'),
('CNPM','Cong nghe phan mem','6/7/2005','GV04'),
('MTT','Mang va truyen thong','10/20/2005','GV03'),
('KTMT','Ky thuat may tinh','12/20/2005','')
-- Nhập dữ liệu cho LOP --
INSERT INTO LOP VALUES('K11','Lop 1 khoa 1','K1108',11,'GV07'),
('K12','Lop 2 khoa 1','K1205',12,'GV09'),
('K13','Lop 3 khoa 1','K1305',12,'GV14')
-- Nhập dữ liệu cho MONHOC --
INSERT INTO MONHOC VALUES('THDC','Tin hoc dai cuong',4,1,'KHMT'),
('CTRR','Cau truc roi rac',5,2,'KHMT'),
('CSDL','Co so du lieu',3,1,'HTTT'),
('CTDLGT','Cau truc du lieu va giai thuat',3,1,'KHMT'),
('PTTKTT','Phan tich thiet ke thuat toan',3,0,'KHMT'),
('DHMT','Do hoa may tinh',3,1,'KHMT'),
('KTMT','Kien truc may tinh',3,0,'KTMT'),
('TKCSDL','Thiet ke co so du lieu',3,1,'HTTT'),
('PTTKHTTT','Phan tich thiet ke he thong thong tin',4,1,'HTTT'),
('HDH','He dieu hanh',4,1,'KTMT'),
('NMCNPM','Nhap mon cong nghe phan mem',3,0,'CNPM'),
('LTCFW','Lap trinh C for win',3,1,'CNPM'),
('LTHDT','Lap trinh huong doi tuong',3,1,'CNPM')
-- Nhập dữ liệu cho GIANGDAY --
INSERT INTO GIANGDAY VALUES('K11','THDC','GV07',1,2006,'1/2/2006','5/12/2006'),
('K12','THDC','GV06',1,2006,'1/2/2006','5/12/2006'),
('K13','THDC','GV15',1,2006,'1/2/2006','5/12/2006'),
('K11','CTRR','GV02',1,2006,'1/9/2006','5/17/2006'),
('K12','CTRR','GV02',1,2006,'1/9/2006','5/17/2006'),
('K13','CTRR','GV08',1,2006,'1/9/2006','5/17/2006'),
('K11','CSDL','GV05',2,2006,'6/1/2006','7/15/2006'),
('K12','CSDL','GV09',2,2006,'6/1/2006','7/15/2006'),
('K13','CTDLGT','GV15',2,2006,'6/1/2006','7/15/2006'),
('K13','CSDL','GV05',3,2006,'8/1/2006','12/15/2006'),
('K13','DHMT','GV07',3,2006,'8/1/2006','12/15/2006'),
('K11','CTDLGT','GV15',3,2006,'8/1/2006','12/15/2006'),
('K12','CTDLGT','GV15',3,2006,'8/1/2006','12/15/2006'),
('K11','HDH','GV04',1,2007,'1/2/2007','2/18/2007'),
('K12','HDH','GV04',1,2007,'1/2/2007','3/20/2007'),
('K11','DHMT','GV07',1,2007,'2/18/2007','3/20/2007')
-- Nhập dữ liệu cho GIAOVIEN --
INSERT INTO GIAOVIEN VALUES('GV01','Ho Thanh Son','PTS','GS','Nam','5/2/1950','1/11/2004',5.00,2250000,'KHMT'),
('GV02','Tran Tam Thanh','TS','PGS','Nam','12/17/1965','4/20/2004',4.50,2025000,'HTTT'),
('GV03','Do Nghiem Phung','TS','GS','Nu','8/1/1950','9/23/2004',4.00,1800000,'CNPM'),
('GV04','Tran Nam Son','TS','PGS','Nam','2/22/1961','1/12/2005',4.50,2025000,'KTMT'),
('GV05','Mai Thanh Danh','ThS','GV','Nam','3/12/1958','1/12/2005',3.00,1350000,'HTTT'),
('GV06','Tran Doan Hung','TS','GV','Nam','3/11/1953','1/12/2005',4.50,2025000,'KHMT'),
('GV07','Nguyen Minh Tien','ThS','GV','Nam','11/23/1971','3/1/2005',4.00,1800000,'KHMT'),
('GV08','Le Thi Tran','KS','','Nu','3/26/1974','3/1/2005',1.69,760500,'KHMT'),
('GV09','Nguyen To Lan','ThS','GV','Nu','12/31/1966','3/1/2005',4.00,1800000,'HTTT'),
('GV10','Le Tran Anh Loan','KS','','Nu','7/17/1972','3/1/2005',1.86,837000,'CNPM'),
('GV11','Ho Thanh Tung','CN','GV','Nam','1/12/1980','5/15/2005',2.67,1201500,'MTT'),
('GV12','Tran Van Anh','CN','','Nu','3/29/1981','5/15/2005',1.69,760500,'CNPM'),
('GV13','Nguyen Linh Dan','CN','','Nu','5/23/1980','5/15/2005',1.69,760500,'KTMT'),
('GV14','Truong Minh Chau','ThS','GV','Nu','11/30/1976','5/15/2005',3.00,1350000,'MTT'),
('GV15','Le Ha Thanh','ThS','GV','Nam','5/4/1978','5/15/2005',3.00,1350000,'KHMT')
-- NHẬP DỮ LIỆU CHO DIEUKIEN --
INSERT INTO DIEUKIEN VALUES('CSDL','CTRR'),
('CSDL','CTDLGT'),
('CTDLGT','THDC'),
('PTTKTT','THDC'),
('PTTKTT','CTDLGT'),
('DHMT','THDC'),
('LTHDT','THDC'),
('PTTKHTTT','CSDL')
-- Nhập dữ liệu cho KETQUATHI --
INSERT INTO KETQUATHI VALUES('K1101','CSDL',1,'7/20/2006',10.00,'Dat'),
('K1101','CTDLGT',1,'12/28/2006',9.00,'Dat'),
('K1101','THDC',1,'5/20/2006',9.00,'Dat'),
('K1101','CTRR',1,'5/13/2006',9.50,'Dat'),
('K1102','CSDL',1,'7/20/2006',4.00,'Khong Dat'),
('K1102','CSDL',2,'7/27/2006',4.25,'Khong Dat'),
('K1102','CSDL',3,'8/10/2006',4.50,'Khong Dat'),
('K1102','CTDLGT',1,'12/28/2006',4.50,'Khong Dat'),
('K1102','CTDLGT',2,'1/5/2007',4.00,'Khong Dat'),
('K1102','CTDLGT',3,'1/15/2007',6.00,'Dat'),
('K1102','THDC',1,'5/20/2006',5.00,'Dat'),
('K1102','CTRR',1,'5/13/2006',7.00,'Dat'),
('K1103','CSDL',1,'7/20/2006',3.50,'Khong Dat'),
('K1103','CSDL',2,'7/27/2006',8.25,'Dat'),
('K1103','CTDLGT',1,'12/28/2006',7.00,'Dat'),
('K1103','THDC',1,'5/20/2006',8.00,'Dat'),
('K1103','CTRR',1,'5/13/2006',6.50,'Dat'),
('K1104','CSDL',1,'7/20/2006',3.75,'Khong Dat'),
('K1104','CTDLGT',1,'12/28/2006',4.00,'Khong Dat'),
('K1104','THDC',1,'5/20/2006',4.00,'Khong Dat'),
('K1104','CTRR',1,'5/13/2006',4.00,'Khong Dat'),
('K1104','CTRR',2,'5/20/2006',3.50,'Khong Dat'),
('K1104','CTRR',3,'6/30/2006',4.00,'Khong Dat'),
('K1201','CSDL',1,'7/20/2006',6.00,'Dat'),
('K1201','CTDLGT',1,'12/28/2006',5.00,'Dat'),
('K1201','THDC',1,'5/20/2006',8.50,'Dat'),
('K1201','CTRR',1,'5/13/2006',9.00,'Dat'),
('K1202','CSDL',1,'7/20/2006',8.00,'Dat'),
('K1202','CTDLGT',1,'12/28/2006',4.00,'Khong Dat'),
('K1202','CTDLGT',2,'1/5/2007',5.00,'Dat'),
('K1202','THDC',1,'5/20/2006',4.00,'Khong Dat'),
('K1202','THDC',2,'5/27/2006',4.00,'Khong Dat'),
('K1202','CTRR',1,'5/13/2006',3.00,'Khong Dat'),
('K1202','CTRR',2,'5/20/2006',4.00,'Khong Dat'),
('K1202','CTRR',3,'6/30/2006',6.25,'Dat'),
('K1203','CSDL',1,'7/20/2006',9.25,'Dat'),
('K1203','CTDLGT',1,'12/28/2006',9.50,'Dat'),
('K1203','THDC',1,'5/20/2006',10.00,'Dat'),
('K1203','CTRR',1,'5/13/2006',10.00,'Dat'),
('K1204','CSDL',1,'7/20/2006',8.50,'Dat'),
('K1204','CTDLGT',1,'12/28/2006',6.75,'Dat'),
('K1204','THDC',1,'5/20/2006',4.00,'Khong Dat'),
('K1204','CTRR',1,'5/13/2006',6.00,'Dat'),
('K1301','CSDL',1,'12/20/2006',4.25,'Khong Dat'),
('K1301','CTDLGT',1,'7/25/2006',8.00,'Dat'),
('K1301','THDC',1,'5/20/2006',7.75,'Dat'),
('K1301','CTRR',1,'5/13/2006',8.00,'Dat'),
('K1302','CSDL',1,'12/20/2006',6.75,'Dat'),
('K1302','CTDLGT',1,'7/25/2006',5.00,'Dat'),
('K1302','THDC',1,'5/20/2006',8.00,'Dat'),
('K1302','CTRR',1,'5/13/2006',8.50,'Dat'),
('K1303','CSDL',1,'12/20/2006',4.00,'Khong Dat'),
('K1303','CTDLGT',1,'7/25/2006',4.50,'Khong Dat'),
('K1303','CTDLGT',2,'8/7/2006',4.00,'Khong Dat'),
('K1303','CTDLGT',3,'8/15/2006',4.25,'Khong Dat'),
('K1303','THDC',1,'5/20/2006',4.50,'Khong Dat'),
('K1303','CTRR',1,'5/13/2006',3.25,'Khong Dat'),
('K1303','CTRR',2,'5/20/2006',5.00,'Dat'),
('K1304','CSDL',1,'12/20/2006',7.75,'Dat'),
('K1304','CTDLGT',1,'7/25/2006',9.75,'Dat'),
('K1304','THDC',1,'5/20/2006',5.50,'Dat'),
('K1304','CTRR',1,'5/13/2006',5.00,'Dat'),
('K1305','CSDL',1,'12/20/2006',9.25,'Dat'),
('K1305','CTDLGT',1,'7/25/2006',10.00,'Dat'),
('K1305','THDC',1,'5/20/2006',8.00,'Dat'),
('K1305','CTRR',1,'5/13/2006',10.00,'Dat')
-- Nhập dữ liệu cho HOCVIEN --
INSERT INTO HOCVIEN VALUES('K1101','Nguyen Van','A','1/27/1986','Nam','TpHCM','K11'),
('K1102','Tran Ngoc','Han','3/1/1986','Nu','Kien Giang','K11'),
('K1103','Ha Duy','Lap','4/18/1986','Nam','Nghe An','K11'),
('K1104','Tran Ngoc','Linh','3/30/1986','Nu','Tay Ninh','K11'),
('K1105','Tran Minh','Long','2/27/1986','Nam','TpHCM','K11'),
('K1106','Le Nhat','Minh','1/24/1986','Nam','TpHCM','K11'),
('K1107','Nguyen Nhu','Nhut','1/27/1986','Nam','Ha Noi','K11'),
('K1108','Nguyen Manh','Tam','2/27/1986','Nam','Kien Giang','K11'),
('K1109','Phan Thi Thanh','Tam','1/27/1986','Nu','Vinh Long','K11'),
('K1110','Le Hoai','Thuong','2/5/1986','Nu','Can Tho','K11'),
('K1111','Le Ha','Vinh','12/25/1986','Nam','Vinh Long','K11'),
('K1201','Nguyen Van','B','2/11/1986','Nam','TpHCM','K12'),
('K1202','Nguyen Thi Kim','Duyen','1/18/1986','Nu','TpHCM','K12'),
('K1203','Tran Thi Kim','Duyen','9/17/1986','Nu','TpHCM','K12'),
('K1204','Truong My','Hanh','5/19/1986','Nu','Dong Nai','K12'),
('K1205','Nguyen Thanh','Nam','4/17/1986','Nam','TpHCM','K12'),
('K1206','Nguyen Thi Truc','Thanh','3/4/1986','Nu','Kien Giang','K12'),
('K1207','Tran Thi Bich','Thuy','2/8/1986','Nu','Nghe An','K12'),
('K1208','Huynh Thi Kim','Trieu','4/8/1986','Nu','Tay Ninh','K12'),
('K1209','Pham Thanh','Trieu','2/23/1986','Nam','TpHCM','K12'),
('K1210','Ngo Thanh','Tuan','2/14/1986','Nam','TpHCM','K12'),
('K1211','Do Thi','Xuan','3/9/1986','Nu','Ha Noi','K12'),
('K1212','Le Thi Phi','Yen','3/12/1986','Nu','TpHCM','K12'),
('K1301','Nguyen Thi Kim','Cuc','6/9/1986','Nu','Kien Giang','K13'),
('K1302','Truong Thi My','Hien','3/18/1986','Nu','Nghe An','K13'),
('K1303','Le Duc','Hien','3/12/1986','Nam','Tay Ninh','K13'),
('K1304','Le Quang','Hien','4/18/1986','Nam','TpHCM','K13'),
('K1305','Le Thi','Huong','3/27/1986','Nu','TpHCM','K13'),
('K1306','Nguyen Thai','Huu','3/30/1986','Nam','Ha Noi','K13'),
('K1307','Tran Minh','Man','5/28/1986','Nam','TpHCM','K13'),
('K1308','Nguyen Hieu','Nghia','4/8/1986','Nam','Kien Giang','K13'),
('K1309','Nguyen Trung','Nghia','1/18/1987','Nam','Nghe An','K13'),
('K1310','Tran Thi Hong','Tham','4/22/1986','Nu','Tay Ninh','K13'),
('K1311','Tran Minh','Thuc','4/4/1986','Nam','TpHCM','K13'),
('K1312','Nguyen Thi Kim','Yen','9/7/1986','Nu','TpHCM','K13')


					
--LAB5: Sinh viên hoàn thành Phần I bài tập QuanLyGiaoVu câu 9, 10 và từ câu 15 đến câu 24. 
--Câu 9: Lớp trưởng của một lớp phải là học viên của lớp đó. 
GO
CREATE TRIGGER trg_LopTrg ON LOP
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @MALOP1 char(3), @MALOP2 char(3), @TRGLOP char(5)
	SELECT @MALOP1=MALOP, @TRGLOP=TRGLOP
	FROM INSERTED
	SELECT @MALOP2=MALOP
	FROM HOCVIEN
	WHERE @TRGLOP=MAHV
	IF (@MALOP1=@MALOP2)
		BEGIN
			PRINT N'Thêm lớp mới thành công'
		END
	ELSE
		BEGIN
			PRINT N'Lớp mới không hợp lệ'
			ROLLBACK TRANSACTION
		END
END
GO
--Câu 10: Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”. 
ALTER TRIGGER TRG_TRGKHOA ON KHOA
FOR INSERT, UPDATE
AS 
BEGIN
	DECLARE @MAKHOA1 VARCHAR(4), @MAKHOA2 VARCHAR(4), @TRGKHOA CHAR(4), @HOCVI VARCHAR(10)
	SELECT @MAKHOA1=MAKHOA, @TRGKHOA=TRGKHOA
	FROM INSERTED
	SELECT @MAKHOA2=MAKHOA, @HOCVI=HOCVI
	FROM GIAOVIEN
	WHERE MAGV=@TRGKHOA
	IF(@MAKHOA1 = @MAKHOA2 AND @HOCVI IN ('TS', 'PTS') AND @MAKHOA1 IS NOT NULL)
		BEGIN
			PRINT N'Thêm khoa mới thành công'
		END
	ELSE
		BEGIN
			PRINT N'Không đủ điều kiện thành lập khoa'
			ROLLBACK TRANSACTION
		END
END
--Câu 15: Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này
GO
CREATE TRIGGER TRG_THI ON KETQUATHI
FOR INSERT, UPDATE
AS 
BEGIN
	DECLARE @MAHV CHAR(5), @MAMH VARCHAR(10), @MALOP CHAR(3), @DENNGAY SMALLDATETIME, @NGTHI SMALLDATETIME
	SELECT @MAHV=MAHV, @MAMH=MAMH, @NGTHI=NGTHI
	FROM INSERTED
	SELECT @MALOP=MALOP
	FROM HOCVIEN
	WHERE MAHV=@MAHV
	SELECT @DENNGAY=DENNGAY
	FROM GIANGDAY
	WHERE @MAMH=MAMH AND @MALOP=MALOP
	IF(@DENNGAY IS NOT NULL AND @DENNGAY< @NGTHI)
		BEGIN
			PRINT N'Thêm KETQUATHI thành công'
		END
	ELSE
		BEGIN
			PRINT N'Dữ liệu không hợp lệ'
			ROLLBACK TRANSACTION
		END
END
GO
--Câu 16: Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn.
ALTER TRIGGER TRG_HOCKY ON GIANGDAY
FOR INSERT, UPDATE
AS 
BEGIN
	IF EXISTS (
        SELECT MALOP, HOCKY, NAM
        FROM GIANGDAY
        GROUP BY MALOP, HOCKY, NAM
        HAVING COUNT(MAMH) > 3
    )
		BEGIN
			PRINT N'Dữ liệu thêm không hợp lệ.';
			ROLLBACK TRANSACTION;   
		END
	ELSE
		BEGIN
			PRINT 'Thêm dữ liệu thành công';
		END	
END
GO
--Câu 17: Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó.
ALTER TRIGGER TRG_SISO ON LOP
FOR INSERT, UPDATE
AS 
BEGIN
	DECLARE @SISO TINYINT, @SOHOCVIEN TINYINT, @MALOP CHAR(3)
	SELECT @SISO=SISO, @MALOP=MALOP
	FROM INSERTED
	SELECT @SOHOCVIEN=COUNT(MAHV)
	FROM HOCVIEN
	WHERE MALOP=@MALOP
	IF(@SISO=@SOHOCVIEN)
		BEGIN
			PRINT 'Thêm dữ liệu thành công';
		END
	ELSE
		BEGIN
			PRINT N'Dữ liệu thêm không hợp lệ.';
			ROLLBACK TRANSACTION;   
		END
END
GO
--Câu 18: Trong quan hệ DIEUKIEN giá trị của thuộc tính MAMH và MAMH_TRUOC trong cùng 
--một bộ không được giống nhau (“A”,”A”) và cũng không tồn tại hai bộ (“A”,”B”) và (“B”,”A”).
CREATE TRIGGER TRG_DIEUKIEN ON DIEUKIEN
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @MAMH VARCHAR(10), @MAMH_TRUOC VARCHAR(10)
	SELECT @MAMH=MAMH, @MAMH_TRUOC=MAMH_TRUOC
	FROM INSERTED
	IF( @MAMH=@MAMH_TRUOC OR EXISTS( SELECT 1
									  FROM DIEUKIEN D1
									  JOIN DIEUKIEN D2
									  ON D1.MAMH = D2.MAMH_TRUOC
									  AND D1.MAMH_TRUOC = D2.MAMH)
	)
		BEGIN
			PRINT N'Dữ liệu thêm không hợp lệ.';
			ROLLBACK TRANSACTION;   
		END
	ELSE
		BEGIN
			PRINT 'Thêm dữ liệu thành công';
		END
END
--Câu 19: Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau. 
GO
CREATE TRIGGER TRG_LUONGGV ON GIAOVIEN
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
        SELECT HOCVI, HOCHAM, HESO
        FROM GIAOVIEN
        GROUP BY HOCVI, HOCHAM, HESO
        HAVING COUNT(DISTINCT MUCLUONG) > 1
    )
		BEGIN
			PRINT N'Dữ liệu thêm không hợp lệ.';
			ROLLBACK TRANSACTION;   
		END
	ELSE
		BEGIN
			PRINT 'Thêm dữ liệu thành công';
		END
END
GO
--Câu 20: Học viên chỉ được thi lại (lần thi >1) khi điểm của lần thi trước đó dưới 5
CREATE TRIGGER TRG_Lanthi ON KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @LANTHI TINYINT, @DIEM NUMERIC(4,2), @MAHV CHAR(5)
	SELECT @LANTHI=LANTHI, @MAHV=MAHV
	FROM INSERTED
	SELECT @DIEM=DIEM
	FROM KETQUATHI
	WHERE @MAHV=MAHV AND LANTHI=@LANTHI-1
	IF(@LANTHI=1 OR (@DIEM<5 AND @DIEM IS NOT NULL))
		BEGIN
			PRINT 'Thêm dữ liệu thành công';
		END
	ELSE
		BEGIN
			PRINT N'Dữ liệu thêm không hợp lệ.';
			ROLLBACK TRANSACTION;   
		END
END
GO
--Câu 21: Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước (cùng học viên, cùng môn học).
ALTER TRIGGER TRG_NgayThi ON KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @NGTHI SMALLDATETIME, @MAHV CHAR(5), @MAMH VARCHAR(10), @LANTHI TINYINT
	SELECT @NGTHI=NGTHI, @MAHV=MAHV, @MAMH=MAMH
	FROM INSERTED
	IF EXISTS(SELECT 1 
			  FROM KETQUATHI
			  WHERE @MAHV=MAHV AND @MAMH=MAMH AND @LANTHI>LANTHI AND @NGTHI<NGTHI 
			  )
		BEGIN
			PRINT N'Dữ liệu thêm không hợp lệ.';
			ROLLBACK TRANSACTION;   
		END
	ELSE
		BEGIN
			PRINT 'Thêm dữ liệu thành công';
		END
END
GO
--Câu 22: Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước sau giữa các môn học (sau 
--khi học xong những môn học phải học trước mới được học những môn liền sau).
ALTER TRIGGER TRG_PHANCONG ON GIANGDAY
FOR INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM INSERTED I
        JOIN DIEUKIEN DK 
          ON I.MAMH = DK.MAMH
        JOIN GIANGDAY GD_TRUOC 
          ON GD_TRUOC.MALOP = I.MALOP 
         AND GD_TRUOC.MAMH = DK.MAMH_TRUOC
        WHERE GD_TRUOC.DENNGAY > I.TUNGAY
    )
    BEGIN
        PRINT N'Không thể phân công giảng dạy: Môn học trước chưa hoàn thành.';
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        PRINT N'Phân công giảng dạy thành công.';
    END
END;
GO
--Câu 23: Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách.
ALTER TRIGGER TRG_PHANCONG_GV ON GIANGDAY
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM INSERTED I
        JOIN MONHOC MH ON I.MAMH = MH.MAMH
        JOIN GIAOVIEN GV ON I.MAGV = GV.MAGV
        WHERE MH.MAKHOA <> GV.MAKHOA
    )
    BEGIN
        PRINT N'Phân công không hợp lệ: Giáo viên không thuộc khoa của môn học.';
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        PRINT N'Phân công giảng dạy thành công.';
    END
END;
GO
