--19120583
USE master
GO
IF DB_ID('QLDT') IS NOT NULL 
	DROP DATABASE QLDT
GO
CREATE DATABASE QLDT
GO
USE QLDT
GO
CREATE TABLE Khoa
(
MAKHOA CHAR(4),
TENKHOA NVARCHAR(40),
NAMTL INT,
PHONG CHAR(5),
DIENTHOAI CHAR(12),
TRUONGKHOA CHAR(5),
NGAYNHANCHUC DATETIME

CONSTRAINT PK_Khoa
PRIMARY KEY (MAKHOA)
)
GO
CREATE TABLE BoMon
(
MABM CHAR(5),
TENBM NVARCHAR(40),
PHONG CHAR(5),
DIENTHOAI CHAR(12),
TRUONGBM CHAR(5),
MAKHOA CHAR(4),
NGAYNHANCHUC DATETIME

CONSTRAINT PK_BoMon
PRIMARY KEY (MABM)
)

GO
CREATE TABLE GiaoVien
(
MAGV CHAR(5),
HOTEN NVARCHAR(40),
LUONG FLOAT,
PHAI NVARCHAR(3),
NGSINH DATETIME,
DIACHI NVARCHAR(100),
GVQLCM CHAR(5),
MABM CHAR(5)

CONSTRAINT PK_GiaoVien
PRIMARY KEY (MAGV)
)
GO
CREATE TABLE GV_DT
(
MAGV CHAR(5),
DIENTHOAI CHAR(12)

CONSTRAINT PK_GV_DT
PRIMARY KEY (MAGV,DIENTHOAI)
)
GO
CREATE TABLE DeTai
(
MADT CHAR(3),
TENDT NVARCHAR(100),
CAPQL NVARCHAR(40),
KINHPHI FLOAT,
NGAYBD DATETIME,
NGAYKT DATETIME,
MACD NCHAR(4),
GVCNDT CHAR(5)

CONSTRAINT PK_DeTai
PRIMARY KEY (MADT)
)
GO
CREATE TABLE ChuDe
(
MACD NCHAR(4),
TENCD NVARCHAR(50)

CONSTRAINT PK_ChuDe
PRIMARY KEY (MACD)
)
GO
CREATE TABLE CongViec
(
MADT CHAR(3),
SOTT INT,
TENCV NVARCHAR(40),
NGAYBD DATETIME,
NGAYKT DATETIME

CONSTRAINT PK_CongViec
PRIMARY KEY (MADT,SOTT)
)
GO
CREATE TABLE ThamGiaDT
(
MAGV CHAR(5),
MADT CHAR(3),
STT INT,
PHUCAP FLOAT,
KETQUA NVARCHAR(40)

CONSTRAINT PK_ThamGiaDT
PRIMARY KEY (MAGV,MADT,STT)
)
GO
CREATE TABLE NguoiThan
(
MAGV CHAR(5),
TEN NVARCHAR(20),
NGSINH DATETIME,
PHAI NCHAR(3)

CONSTRAINT PK_NguoiThan
PRIMARY KEY (MAGV,TEN)
)

GO
ALTER TABLE Khoa
ADD
	CONSTRAINT FK_K_GV
	FOREIGN KEY(TRUONGKHOA)
	REFERENCES GiaoVien
GO
ALTER TABLE BoMon
ADD
	CONSTRAINT FK_BM_K
	FOREIGN KEY(MAKHOA)
	REFERENCES Khoa,
	CONSTRAINT FK_BM_GV
	FOREIGN KEY(TRUONGBM)
	REFERENCES GiaoVien

GO
ALTER TABLE GiaoVien
ADD
	CONSTRAINT FK_GV_GV
	FOREIGN KEY(GVQLCM)
	REFERENCES GiaoVien,
	CONSTRAINT FK_GV_BM
	FOREIGN KEY(MABM)
	REFERENCES BoMon
GO
ALTER TABLE GV_DT
ADD
	CONSTRAINT FK_GVDT_GV
	FOREIGN KEY(MAGV)
	REFERENCES GiaoVien
GO
ALTER TABLE NguoiThan
ADD
	CONSTRAINT FK_NT_GV
	FOREIGN KEY(MAGV)
	REFERENCES GiaoVien
GO
ALTER TABLE ThamGiaDT
ADD
	CONSTRAINT FK_TGDT_GV
	FOREIGN KEY(MAGV)
	REFERENCES GiaoVien,
	CONSTRAINT FK_TGDT_CV
	FOREIGN KEY(MADT,STT)
	REFERENCES CongViec
GO
ALTER TABLE CongViec
ADD
	CONSTRAINT FK_CV_DT
	FOREIGN KEY(MADT)
	REFERENCES DeTai
GO
ALTER TABLE DeTai
ADD
	CONSTRAINT FK_DT_GV
	FOREIGN KEY(GVCNDT)
	REFERENCES GiaoVien,
	CONSTRAINT FK_DT_CD
	FOREIGN KEY(MACD)
	REFERENCES ChuDe
GO
INSERT GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM)
VALUES
('001',N'Nguyễn Hoài An',2000.0,N'Nam','1973-02-15',N'25/3 Lạc Long Quân,Q.10,TP HCM',NULL),
('002',N'Trần Trà Hương',2500.0,N'Nữ','1960-06-20',N'125 Trần Hưng Đạo,Q.1,TP HCM',NULL),
('003',N'Nguyễn Ngọc Ánh',2200.0,N'Nữ','1975-05-11',N'12/21 Võ Văn Ngân Thủ Đức,TP HCM','002'),
('004',N'Trương Nam Sơn',2300.0,N'Nam','1959-06-20',N'215 Lý Thường Kiệt,TP Biên Hòa',NULL),
('005',N'Lý Hoàng Hà',2500.0,N'Nam','1954-10-23',N'22/5 Nguyễn Xí,Q.Bình Thạnh,TP HCM',NULL),
('006',N'Trần Bạch Tuyết',1500.0,N'Nữ','1980-05-20',N'127 Hùng Vương,TP Mỹ Tho','004'),
('007',N'Nguyễn An Trung',2100.0,N'Nam','1976-06-05',N'234 3/2,TP Biên Hòa',NULL),
('008',N'Trần Trung Hiếu',1800.0,N'Nam','1977-08-06',N'22/11 Lý Thường Kiệt,TP Mỹ Tho','007'),
('009',N'Trần Hoàng Nam',2000.0,N'Nam','1975-11-22',N'234 Trần Não,An Phú,TP HCM','001'),
('010',N'Phạm Nam Thanh',1500.0,N'Nam','1980-12-12',N'221 Hùng Vương,Q.5,TP HCM','007')
GO

INSERT KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
VALUES
(N'CNTT',N'Công nghệ thông tin','1995','B11','0838123456','002','2005-02-20'),
(N'HH',N'Hóa học','1980','B41','0838456456','007','2001-10-15'),
(N'SH',N'Sinh học','1980','B31','0838454545','004','2000-10-11'),
(N'VL',N'Vật Lý','1976','B21','0838223223','005','2003-09-08')
GO
INSERT BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
VALUES
(N'CNTT',N'Công nghệ tri thức','B15','0838126126',NULL,'CNTT',NULL),
(N'HHC',N'Hóa hữu cơ','B44','838222222',NULL,'HH',NULL),
(N'HL',N'Hóa lý','B42','0838878787',NULL,'HH',NULL),
(N'HPT',N'Hóa phân tích','B43','0838777777','007','HH','2007-10-15'),
(N'HTTT',N'Hệ thống thông tin','B13','0838125125','002','CNTT','2004-09-20'),
(N'MMT',N'Mạng máy tính','B16','0838676767','001','CNTT','2005-05-15'),
(N'SH',N'Sinh hóa','B33','0838898989',NULL,'SH',NULL),
(N'VLĐT',N'Vật lý điện tử','B23','0838234234',NULL,'VL',NULL),
(N'VLƯD',N'Vật lý ứng dụng','B24','0838454545','005','VL','2006-02-18'),
(N'VS',N'Vi sinh','B32','08388909090','004','SH','2007-01-01')
GO
INSERT INTO GV_DT(MAGV,DIENTHOAI)
VALUES
('001','0838912112'),
('001','0903123123'),
('002','0913454545'),
('003','0838121212'),
('003','0903656565'),
('003','0937125125'),
('006','0937888888'),
('008','0653717171'),
('008','0913232323')
GO
INSERT INTO NguoiThan(MAGV,TEN,NGSINH,PHAI)
VALUES
('001',N'Hùng','1990-01-14',N'Nam'),
('001',N'Thủy','1994-12-08',N'Nữ'),
('003',N'Hà','1998-09-03',N'Nữ'),
('003',N'Thu','1998-09-03',N'Nữ'),
('007',N'Mai','2003-03-26',N'Nữ'),
('007',N'Vy','2000-02-14',N'Nữ'),
('008',N'Nam','1991-05-06',N'Nam'),
('009',N'An','1996-08-19','Nam'),
('010',N'Nguyệt','2006-01-24',N'Nữ')
GO

INSERT INTO ChuDe(MACD,TENCD)
VALUES
('NCPT',N'Nghiên cứu phát triển'),
('QLGD',N'Quản lý giáo dục'),
('UDCN',N'Ứng dụng công nghệ')
GO
INSERT INTO DeTai(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
VALUES
('001',N'HTTT quản lý các trường ĐH',N'ĐHQG',20.0,'2007-10-20','2008-10-20','QLGD','002'),
('002',N'HTTT quản lý giáo vụ cho một Khoa',N'Trường',20.0,'2000-10-12','2001-10-12','QLGD','002'),
('003',N'Nghiên cứu chế tạo sợi Nanô Platin',N'ĐHQG',300.0,'2008-05-15','2010-05-15','NCPT','005'),
('004',N'Tạo vật liệu sinh học bằng màng ối người',N'Nhà nước',100.0,'2007-01-01','2009-12-31','NCPT','004'),
('005',N'Ứng dụng hóa học xanh',N'Trường',200.0,'2003-10-10','2004-12-10','UDCN','007'),
('006',N'Nghiên cứu tế bào gốc',N'Nhà nước',4000.0,'2006-10-20','2009-10-20','NCPT','004'),
('007',N'HTTT quản lý thư viện ở các trường ĐH',N'Trường',20.0,'2009-05-10','2010-05-10','QLGD','001')
GO
INSERT INTO CongViec(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
VALUES
('001',1,N'Khởi tạo và Lập kế hoạch','2007-10-20','2008-12-20'),
('001',2,N'Xác định yêu cầu','2008-12-21','2008-03-21'),
('001',3,N'Phân tích hệ thống','2008-03-22','2008-05-22'),
('001',4,N'Thiết kế hệ thống','2008-05-23','2008-06-23'),
('001',5,N'Cài đặt thử nghiệm','2008-06-24','2008-10-20'),
('002',1,N'Khởi tạo và Lập kế hoạch','2009-05-10','2009-07-10'),
('002',2,N'Xác định yêu cầu','2009-01-11','2009-10-11'),
('002',3,N'Phân tích hệ thống','2009-10-12','2009-12-20'),
('002',4,N'Thiết kế hệ thống','2009-12-21','2010-03-22'),
('002',5,N'Cài đặt thử nghiệm','2010-03-23','2010-05-10'),
('006',1,N'Lấy mẫu','2006-10-20','2007-02-20'),
('006',2,N'Nuôi cấy','2007-02-21','2008-08-21')

GO
INSERT INTO ThamGiaDT(MAGV,MADT,STT,PHUCAP,KETQUA)
VALUES
('001','002',1,0.0,'NULL'),
('001','002',2,2.0,'NULL'),
('002','001',4,2.0,N'Đạt'),
('003','001',1,1.0,N'Đạt'),
('003','001',2,0.0,N'Đạt'),
('003','001',4,1.0,N'Đạt'),
('003','002',2,0.0,'NULL'),
('004','006',1,0.0,N'Đạt'),
('004','006',2,1.0,N'Đạt'),
('006','006',2,1.5,N'Đạt'),
('009','002',3,0.5,'NULL'),
('009','002',4,1.5,'NULL')
GO

UPDATE GiaoVien
SET MABM='MMT'
WHERE MAGV='001' OR MAGV='009'
GO

UPDATE GiaoVien
SET MABM='HTTT'
WHERE MAGV='002' OR MAGV='003'
GO

UPDATE GiaoVien
SET MABM='VS'
WHERE MAGV='004' OR MAGV='006'
GO

UPDATE GiaoVien
SET MABM=N'VLĐT'
WHERE MAGV='005'
GO

UPDATE GiaoVien
SET MABM='HPT'
WHERE MAGV='007' OR MAGV='008' OR MAGV='010'
GO

--Q1
SELECT
HOTEN, LUONG
FROM GiaoVien
WHERE PHAI LIKE N'Nữ'
GO

--Q2
SELECT
HOTEN, LUONG AS N'LƯƠNG TRƯỚC',LUONG * 1.1 AS N'LƯƠNG SAU'
FROM GiaoVien
GO

--Q3
SELECT
MAGV
FROM GiaoVien
WHERE 
HOTEN LIKE N'Nguyễn%' AND LUONG > 2000
UNION 
SELECT
TRUONGBM
FROM BoMon 
WHERE 
YEAR(NGAYNHANCHUC)>1995
GO

--Q4
SELECT
GV.HOTEN
FROM GiaoVien GV JOIN BoMon BM ON GV.MABM = BM.MABM
WHERE MAKHOA LIKE 'CNTT'
GO

--Q5: Cho"biết"thông"tin"của"bộ"môn"cùng"thông"tin"giảng"viên"làm"trưởng"bộ"môn"đó
SELECT 
BM.*,GV.*
FROM BoMon BM LEFT JOIN GiaoVien GV ON BM.TRUONGBM = GV.MAGV
--WHERE 
GO

--Q6 Với mỗi giáo viên, hãy cho biết thông tin của bộ môn mà họ đang làm việc
SELECT 
GV.*,BM.*  
FROM BoMon BM, GiaoVien GV
WHERE BM.MABM = GV.MABM
GO

--Q7: Cho biết tên đề tài và giáo viên chủ nhiệm đề tài. 
SELECT 
DT.TENDT, GV.HOTEN AS N'Giáo Viên Chủ Nhiệm Đề Tài'
FROM DeTai DT, GiaoVien GV
WHERE DT.GVCNDT = GV.MAGV
GO

--Q8: Với"mỗi"khoa"cho"biết"thông"tin"trưởng"khoa.
SELECT
K.*,GV.* 
FROM Khoa K, GiaoVien GV
WHERE K.TRUONGKHOA = GV.MAGV
GO

--Q9: Cho"biết"các"giáo"viên"của"bộ"môn"“Vi"sinh”"có"tham"gia"đề"tài"006."
SELECT
DISTINCT GV.*
FROM GiaoVien GV JOIN ThamGiaDT TG ON TG.MAGV = GV.MAGV
WHERE GV.MABM LIKE 'VS' AND TG.MADT LIKE '006'
GO

--Q10:Với"những"đề"tài"thuộc"cấp"quản"lý"“Thành"phố”,"cho"biết"mã"đề"tài,"đề"tài"thuộc"về"chủ"đề"nào,"họ"tên"
--    người"chủ"nghiệm"đề"tài"cùng"với"ngày"sinh"và"địa"chỉ"của"người"ấy."
SELECT
DT.*, CD.TENCD, CN.HOTEN AS N'HỌ TÊN NGƯỜI CHỦ NHIỆM', CN.NGSINH, CN.DIACHI
FROM DeTai DT, ChuDe CD, GiaoVien CN 
WHERE DT.CAPQL LIKE N'Thành phố'
AND DT.GVCNDT = CN.MAGV
AND DT.MACD = CD.MACD
GO

--Q11: Tìm"họ"tên"của"từng"giáo"viên"và"người"phụ"trách"chuyên"môn"trực"tiếp"của"giáo"viên"đó."
SELECT 
GV.HOTEN,QLCM.HOTEN
FROM GiaoVien GV LEFT JOIN GiaoVien QLCM ON GV.GVQLCM = QLCM.MAGV
GO

--Q12: Tìm"họ"tên"của"những"giáo"viên"được"“Nguyễn"Thanh"Tùng”"phụ"trách"trực"tiếp."
SELECT 
GV.HOTEN
FROM GiaoVien GV LEFT JOIN GiaoVien QLCM ON GV.GVQLCM = QLCM.MAGV
WHERE QLCM.HOTEN = N'Nguyễn Thanh Tùng'
GO

--Q13: Cho"biết"tên"giáo"viên"là"trưởng"bộ"môn"Hệ"thống"thông"tin.
SELECT 
GV.HOTEN
FROM GiaoVien GV JOIN BoMon BM ON BM.TRUONGBM = GV.MAGV
WHERE BM.MABM LIKE 'HTTT'
GO

--Q14: Cho"biết"tên"người"chủ nhiệm"đề tài"của"những"đề tài"thuộc"chủ đề Quản"lý"giáo"dục.
SELECT
DISTINCT GV.HOTEN
FROM DeTai DT, GiaoVien GV, ChuDe CD
WHERE DT.GVCNDT = GV.MAGV AND DT.MACD = CD.MACD AND CD.MACD = 'QLGD'
GO

--Q15: Cho"biết"tên"các"công"việc"của"đề tài"HTTT"quản"lý"các"trường"ĐH"có"thời"gian"bắt"đầu"trong"tháng"3/2008.
SELECT
CV.TENCV
FROM CongViec CV, DeTai DT
WHERE CV.MADT = DT.MADT 
AND DT.TENDT = N'HTTT quản lý các trường ĐH' 
AND MONTH(CV.NGAYBD) = 3
AND YEAR(CV.NGAYBD) = 2008
GO

--Q16: Cho"biết"tên"giáo"viên"và"tên"người"quản"lý"chuyên"môn"của"giáo"viên"đó.
SELECT 
GV.HOTEN,QLCM.HOTEN
FROM GiaoVien GV LEFT JOIN GiaoVien QLCM ON GV.GVQLCM = QLCM.MAGV
GO

--Q17: Cho"các"công"việc"bắt"đầu"trong"khoảng"từ 01/01/2007"đến"01/08/2007
SELECT 
CV.*
FROM CongViec CV
WHERE NGAYBD BETWEEN '2007-01-01' AND '2007-08-01'

--Q18: Cho"biết"họ tên"các"giáo"viên"cùng"bộ môn"với"giáo"viên"“Trần"Trà"Hương”
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.MABM = (
                 SELECT MABM
                 FROM GIAOVIEN
                 WHERE HOTEN = N'Trần Trà Hương'
)

--Q19:  Tìm"những"giáo viên"vừa"là"trưởng"bộ môn"vừa"chủ nhiệm"đề tài.
SELECT 
DISTINCT GV.*
FROM GiaoVien GV JOIN BoMon BM ON GV.MAGV = BM.TRUONGBM 
JOIN DeTai DT ON GV.MAGV = DT.GVCNDT
GO

--Q20: Cho"biết"tên"những"giáo"viên"vừa"là"trưởng"khoa"và"vừa"là"trưởng"bộ môn.
SELECT 
DISTINCT GV.HOTEN
FROM GiaoVien GV JOIN Khoa K ON GV.MAGV = K.TRUONGKHOA 
JOIN BoMon BM ON GV.MAGV = BM.TRUONGBM
GO

--Q21: Cho"biết"tên"những"trưởng"bộ môn"mà"vừa"chủ nhiệm"đề tài"
--TRÙNG CÂU 19

--Q22: Cho"biết"mã"số các"trưởng"khoa"có"chủ nhiệm"đề tài.
SELECT
DISTINCT K.TRUONGKHOA AS N'MÃ SỐ CÁC TRƯỞNG KHOA CÓ CNDT'
FROM Khoa K JOIN DeTai DT ON K.TRUONGKHOA = DT.GVCNDT
GO

--Q23: Cho"biết"mã"số các"giáo"viên"thuộc"bộ môn"HTTT"hoặc"có"tham"gia"đề tài"mã"001
SELECT
DISTINCT GV.MAGV
FROM GiaoVien GV JOIN BoMon BM ON GV.MABM = BM.MABM 
JOIN ThamGiaDT TG ON GV.MAGV = TG.MAGV
WHERE BM.TENBM = 'HTTT' OR TG.MADT = '001'
GO

--Q24: Cho biết"giáo"viên"làm"việc"cùng"bộ môn"với"giáo"viên"002.
SELECT 
DISTINCT GV.*
FROM GiaoVien GV --JOIN BoMon BM ON GV.MABM = BM.MABM
WHERE GV.MABM = (SELECT GVV.MABM FROM GiaoVien GVV WHERE GVV.MAGV = '002')
AND GV.MAGV != '002'
GO

--Q25: Tìm"những"giáo"viên"là"trưởng"bộ môn
SELECT
GV.*
FROM GiaoVien GV JOIN BoMon BM ON GV.MAGV = BM.TRUONGBM
GO

--Q26:  Cho"biết"họ tên"và"mức"lương"của"các"giáo"viên.
SELECT
GV.HOTEN, GV.LUONG
FROM GiaoVien GV
GO

--Q27: Cho"biết"số"lượng"giáo"viên"viên"và"tổng"lương"của"họ."
SELECT COUNT(*) AS N'SỐ LƯỢNG GV', SUM(GV.LUONG) AS N'TỔNG LƯƠNG'
FROM GiaoVien GV
GO

--Q28: Cho"biết"số"lượng"giáo"viên"và"lương"trung"bình"của"từng"bộ"môn."
SELECT MABM, COUNT(*) AS N'SỐ LƯỢNG GV', AVG(LUONG) AS N'LƯƠNG TRUNG BÌNH'
FROM GiaoVien GV
GROUP BY MABM
GO

--Q29: Cho"biết"tên"chủ"đề"và"số"lượng"đề"tài"thuộc"về"chủ"đề"đó."
SELECT CD.TENCD, COUNT(*) AS N'SỐ LƯỢNG ĐỀ TÀI THUỘC CHỦ ĐỀ NÀY'
FROM ChuDe CD JOIN DeTai DT ON CD.MACD = DT.MACD
GROUP BY CD.MACD,CD.TENCD
GO

--Q30: Cho"biết"tên"giáo"viên"và"số"lượng"đề"tài"mà"giáo"viên"đó"tham"gia
SELECT DISTINCT GV.HOTEN, COUNT(DISTINCT TG.MADT) AS N'SỐ LƯỢNG ĐỀ TÀI GV THAM GIA'
FROM GiaoVien GV JOIN ThamGiaDT TG ON GV.MAGV = TG.MAGV
GROUP BY TG.MAGV,GV.HOTEN
GO


--Q31:Cho"biết"tên"giáo"viên"và"số"lượng"đề"tài"mà"giáo"viên"đó"làm"chủ"nhiệm."
SELECT  GV.HOTEN, COUNT(*) AS N'SỐ LƯỢNG ĐỀ TÀI GV CHỦ NHIỆM'
FROM GiaoVien GV JOIN DeTai DT ON GV.MAGV = DT.GVCNDT
GROUP BY DT.GVCNDT,GV.HOTEN
GO

--Q32: Với"mỗi"giáo"viên"cho"tên"giáo"viên"và"số"người"thân"của"giáo"viên"đó."
SELECT  GV.HOTEN, COUNT(*) AS N'SỐ LƯỢNG NGƯỜI THÂN'
FROM GiaoVien GV JOIN NguoiThan NT ON GV.MAGV = NT.MAGV
GROUP BY NT.MAGV,GV.HOTEN
GO

--Q33: Cho"biết"tên"những"giáo"viên"đã"tham"gia"từ"3"đề"tài"trở"lên."
SELECT DISTINCT GV.HOTEN AS N'HỌ TÊN NHỮNG GV THAM GIA TỪ 3 ĐỀ TÀI TRỞ LÊN'
FROM GiaoVien GV JOIN ThamGiaDT TG ON GV.MAGV = TG.MAGV
GROUP BY GV.HOTEN
HAVING COUNT(DISTINCT TG.MADT) >= 2
GO

--Q34:Cho"biết"số"lượng"giáo"viên"đã"tham"gia"vào"đề"tài"Ứng"dụng"hóa"học"xanh."
SELECT COUNT(DISTINCT TG.MAGV) AS N'SỐ LƯỢNG GV THAM GIA ỨNG DỤNG HÓA HỌC XANH'
FROM ThamGiaDT TG JOIN DeTai DT ON DT.MADT = TG.MADT
GROUP BY TG.MADT,DT.TENDT
HAVING DT.TENDT = N'Ứng dụng hóa học xanh' 
GO

--Q35: Cho"biết"mức"lương"cao"nhất"của"các"giảng"viên."
SELECT DISTINCT GV.LUONG AS N'MỨC LƯƠNG CAO NHẤT'
FROM GiaoVien GV
WHERE GV.LUONG >= ALL(SELECT GVV.LUONG FROM GiaoVien GVV)
GO

--Q36: Cho"biết"những"giáo"viên"có"lương"lớn"nhất."
SELECT GV.HOTEN
FROM GiaoVien GV
WHERE GV.LUONG >= ALL(SELECT GVV.LUONG FROM GiaoVien GVV)
GO

--Q37: Cho"biết"lương"cao"nhất"trong"bộ"môn"“HTTT”."
SELECT DISTINCT GV.LUONG AS N'MỨC LƯƠNG CAO NHẤT TRONG BỘ MÔN HTTT'
FROM GiaoVien GV, BoMon BM
WHERE GV.LUONG >= ALL(SELECT GVV.LUONG 
					  FROM GiaoVien GVV
					  WHERE GVV.MABM = 'HTTT')
GO

--Q38: Cho"biết"tên"giáo"viên"lớn"tuổi"nhất"của"bộ"môn"Hệ"thống"thông"tin."
SELECT GV.HOTEN AS N'GIÁO VIÊN LỚN TUỔI NHẤT BỘ MÔN HTTT'
FROM GiaoVien GV, BoMon BM1
WHERE GV.MABM = BM1.MABM AND BM1.TENBM = N'Hệ thống thông tin'
AND 2021 - YEAR(GV.NGSINH) >= ALL(SELECT 2021 - YEAR(GVV.NGSINH)
									FROM GiaoVien GVV,BoMon BM
									WHERE GVV.MABM = BM.MABM
									AND BM.TENBM = N'Hệ thống thông tin')
GO

--Q39: Cho"biết"tên"giáo"viên"nhỏ"tuổi"nhất"khoa"Công"nghệ"thông"tin.
SELECT GV.HOTEN AS N'GIÁO VIÊN LỚN TUỔI NHẤT KHOA CNTT'
FROM GiaoVien GV, BoMon BM1 JOIN Khoa K ON BM1.MAKHOA = K.MAKHOA
WHERE GV.MABM = BM1.MABM AND K.TENKHOA = N'Công nghệ thông tin'
AND GETDATE() - (GV.NGSINH) <= ALL(SELECT GETDATE() - (GVV.NGSINH)
									FROM GiaoVien GVV,BoMon BM, Khoa K1
									WHERE GVV.MABM = BM.MABM
									AND BM.MAKHOA = K1.MAKHOA
									AND K1.TENKHOA = N'Công nghệ thông tin')
GO

--Q40: Cho"biết"tên"giáo"viên"và"tên"khoa"của"giáo"viên"có"lương"cao"nhất."
SELECT GV.HOTEN, K.TENKHOA
FROM BoMon BM JOIN Khoa K ON BM.MAKHOA = K.MAKHOA JOIN GiaoVien GV ON BM.MABM = GV.MABM
WHERE GV.LUONG >= ALL(SELECT GVV.LUONG FROM GiaoVien GVV)
GO
 
--Q41: Cho"biết"những"giáo"viên"có"lương"lớn"nhất"trong"bộ"môn"của"họ."
SELECT *
FROM GiaoVien GV
WHERE GV.LUONG >= ALL(SELECT GVV.LUONG
					FROM GiaoVien GVV
					WHERE GVV.MABM = GV.MABM)
GO

--Q42: Cho"biết"tên"những"đề"tài"mà"giáo"viên"Nguyễn"Hoài"An"chưa"tham"gia."
SELECT TENDT
FROM DETAI DT
WHERE DT.MADT NOT IN (SELECT DISTINCT TG.MADT
					 FROM GIAOVIEN GV,THAMGIADT TG
					 WHERE GV.HOTEN = N'Nguyễn Hoài An'AND GV.MAGV = TG.MAGV)
GO

--Q43: Cho"biết"những"đề"tài"mà"giáo"viên"Nguyễn"Hoài"An"chưa"tham"gia.
--"Xuất"ra"tên"đề"tài,"tên"người"chủ"nhiệm"đề"tài."
SELECT TENDT, GV1.HOTEN
FROM DETAI DT, GiaoVien GV1
WHERE DT.GVCNDT = GV1.MAGV
AND DT.MADT NOT IN (SELECT DISTINCT TG.MADT
					 FROM GIAOVIEN GV,THAMGIADT TG
					 WHERE GV.HOTEN = N'Nguyễn Hoài An'AND GV.MAGV = TG.MAGV)
GO

--Q44: Cho"biết"tên"những"giáo"viên"khoa"Công"nghệ"thông"tin"mà"chưa"tham"gia"đề"tài"nào."
SELECT GV.HOTEN
FROM GiaoVien GV, Khoa K, BoMon BM
WHERE BM.MAKHOA = K.MAKHOA
AND GV.MABM = BM.MABM
AND K.TENKHOA = N'Công nghệ thông tin'
AND GV.MAGV NOT IN (SELECT TG.MAGV FROM ThamGiaDT TG)
GO

--Q45: Tìm"những"giáo"viên"không"tham"gia"bất"kỳ"đề"tài"nào
SELECT GV.*
FROM GiaoVien GV
WHERE GV.MAGV NOT IN (SELECT DISTINCT TG.MAGV FROM ThamGiaDT TG)
GO

--Q46: Cho"biết"giáo"viên"có"lương"lớn"hơn"lương"của"giáo"viên"“Nguyễn"Hoài"An”
SELECT *
FROM GiaoVien GV
WHERE GV.LUONG > (SELECT GVV.LUONG
				FROM GiaoVien GVV
				WHERE GVV.HOTEN = N'Nguyễn Hoài An')
GO

--Q47: Tìm"những"trưởng"bộ"môn"tham"gia"tối"thiểu"1"đề"tài"
SELECT GV.HOTEN,GV.MAGV
FROM GiaoVien GV, BoMon BM
WHERE BM.TRUONGBM = GV.MAGV
AND BM.TRUONGBM IN (SELECT TG.MAGV FROM ThamGiaDT TG)

--Q48: Tìm"giáo"viên"trùng"tên"và"cùng"giới"tính"với"giáo"viên"khác"trong"cùng"bộ"môn"
SELECT *
FROM GIAOVIEN GV1, GIAOVIEN GV2
WHERE GV1.HOTEN = GV2.HOTEN
AND GV2.PHAI = GV1.PHAI 
AND GV1.MAGV != GV2.MAGV 
AND GV1.MABM = GV2.MABM
GO

--Q49: Tìm"những"giáo"viên"có"lương"lớn"hơn"lương"của"ít"nhất"một"giáo"viên"bộ"môn"“Công"nghệ"phần"mềm”"
SELECT GV.HOTEN
FROM GiaoVien GV
WHERE GV.LUONG > (SELECT MIN(GVV.LUONG)
				FROM GiaoVien GVV, BoMon BM
				WHERE GVV.MABM = BM.MABM 
				AND BM.TENBM = N'Công nghệ phần mềm')
GO

--Q50: Tìm"những"giáo"viên"có"lương"lớn"hơn"lương"của"tất"cả"giáo"viên"thuộc"bộ"môn"“Hệ"thống"thông"tin”"
SELECT GV.HOTEN
FROM GiaoVien GV
WHERE GV.LUONG > (SELECT MAX(GVV.LUONG)
				FROM GiaoVien GVV, BoMon BM
				WHERE GVV.MABM = BM.MABM 
				AND BM.TENBM = N'Hệ thống thông tin')
GO

--Q51: Cho"biết"tên"khoa"có"đông"giáo"viên"nhất"
SELECT K1.TENKHOA 
FROM GIAOVIEN GV1, BOMON BM1, KHOA K1
WHERE GV1.MABM = BM1.MABM AND BM1.MAKHOA = K1.MAKHOA
GROUP BY K1.MAKHOA,K1.TENKHOA
HAVING COUNT(GV1.MAGV) >= ALL(
                              SELECT COUNT(GV2.MAGV) FROM GIAOVIEN GV2, BOMON BM2, KHOA K2
							  WHERE GV2.MABM = BM2.MABM AND BM2.MAKHOA = K2.MAKHOA
							  GROUP BY K2.MAKHOA)
GO

--Q52: Cho biết tên của giáo viên chủ nhiệm nhiều đề tài nhất.
SELECT GV.HOTEN
FROM GIAOVIEN GV, DETAI DT
WHERE GV.MAGV = DT.GVCNDT
GROUP BY GV.HOTEN  
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
                       FROM DETAI DT1,GIAOVIEN GV1
					   WHERE DT1.GVCNDT = GV1.MAGV  
                       GROUP BY GV1.HOTEN)  
GO

--Q53: Cho"biết"mã"bộ"môn"có"nhiều"giáo"viên"nhất"
SELECT BM.MABM AS N'MÃ BỘ MÔN CÓ NHIỀU GV NHẤT'
FROM BoMon BM, GiaoVien GV
WHERE BM.MABM = GV.MABM
GROUP BY BM.MABM
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					FROM BoMon BM1, GiaoVien GV1
					WHERE BM1.MABM = GV1.MABM
					GROUP BY BM1.MABM)
GO

--Q54: Cho"biết"tên"giáo"viên"và"tên"bộ"môn"của"giáo"viên"tham"gia"nhiều"đề"tài"nhất."
SELECT GV.HOTEN,BM.TENBM
FROM GiaoVien GV, BoMon BM, ThamGiaDT TG
WHERE GV.MABM = BM.MABM
AND TG.MAGV = GV.MAGV
GROUP BY GV.HOTEN,BM.TENBM
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
						FROM GiaoVien GV1, ThamGiaDT TG1
						WHERE TG1.MAGV = GV1.MAGV
						GROUP BY GV1.HOTEN
						)
GO

--Q55: Cho"biết"tên"giáo"viên"tham"gia"nhiều"đề"tài"nhất"của"bộ"môn"HTTT."
SELECT GV.HOTEN
FROM GiaoVien GV, BoMon BM, ThamGiaDT TG
WHERE GV.MABM = BM.MABM
AND TG.MAGV = GV.MAGV
AND BM.MABM = 'HTTT'
GROUP BY GV.HOTEN,BM.TENBM
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
						FROM GiaoVien GV1, ThamGiaDT TG1
						WHERE TG1.MAGV = GV1.MAGV
						AND GV1.MABM = 'HTTT'
						GROUP BY GV1.HOTEN
						)
GO

--Q56: Cho"biết"tên"giáo"viên"và"tên"bộ"môn"của"giáo"viên"có"nhiều"người"thân"nhất."
SELECT GV.HOTEN,BM.TENBM
FROM GiaoVien GV, BoMon BM, NguoiThan NT
WHERE GV.MABM = BM.MABM
AND NT.MAGV = GV.MAGV
GROUP BY GV.HOTEN,BM.TENBM
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
						FROM GiaoVien GV1, NguoiThan NT1
						WHERE NT1.MAGV = GV1.MAGV
						GROUP BY GV1.HOTEN
						)
GO

--Q57: Cho"biết"tên"trưởng"bộ"môn"mà"chủ"nhiệm"nhiều"đề"tài"nhất.
SELECT GV.HOTEN
FROM GIAOVIEN GV, DETAI DT, BoMon BM
WHERE GV.MAGV = DT.GVCNDT
AND GV.MAGV = BM.TRUONGBM
GROUP BY GV.HOTEN  
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
                       FROM DETAI DT1,GIAOVIEN GV1, BoMon BM1
					   WHERE DT1.GVCNDT = GV1.MAGV  
					   AND GV1.MAGV = BM1.TRUONGBM
                       GROUP BY GV1.HOTEN)  
GO

--Q58: Cho"biết"tên"giáo"viên"nào"mà"tham"gia"đề tài"đủ tất"cả các"chủ đề.
SELECT GV.HOTEN
FROM GIAOVIEN GV 
WHERE NOT EXISTS 
	(SELECT CD.MACD
	FROM ChuDe CD
	EXCEPT
	SELECT CD1.MACD
	FROM ThamGiaDT TG JOIN DeTai DT ON TG.MADT = DT.MADT
	JOIN ChuDe CD1 ON DT.MACD = CD1.MACD
	JOIN GiaoVien GV1 ON GV1.MAGV = TG.MAGV
	)
GO

--DÙNG GROUP BY
SELECT GV.HOTEN
FROM GiaoVien GV, ThamGiaDT TG, DeTai DT, ChuDe CD
WHERE GV.MaGV = TG.MaGV AND TG.MaDT = DT.MaDT AND DT.MaCD = CD.MaCD
GROUP BY GV.HoTen
HAVING COUNT(DISTINCT CD.MaCD) = (SELECT COUNT(*) FROM CHUDE)
GO

--Q59: Cho"biết"tên"đề tài"nào"mà"được"tất"cả các"giáo"viên"của"bộ môn"HTTT"tham"gia.
SELECT DISTINCT DT.TENDT
FROM DeTai DT JOIN ThamGiaDT TG ON DT.MADT = TG.MADT
WHERE NOT EXISTS
(SELECT *
FROM GiaoVien GV WHERE GV.MABM = 'HTTT'
AND NOT EXISTS
	(SELECT *
	FROM ThamGiaDT TG1
	WHERE TG1.MADT = TG.MADT
	AND GV.MAGV = TG1.MAGV
	)
)

--Q60: Cho"biết"tên"đề tài"có"tất"cả giảng"viên"bộ môn"“Hệ thống"thông"tin” tham"gia
SELECT DISTINCT DT.TENDT
FROM DeTai DT JOIN ThamGiaDT TG ON DT.MADT = TG.MADT
WHERE NOT EXISTS
(SELECT *
FROM GiaoVien GV JOIN BoMon BM ON GV.MABM = BM.MABM AND BM.TENBM = N'Hệ thống thông tin'
WHERE NOT EXISTS
	(SELECT *
	FROM ThamGiaDT TG1
	WHERE TG1.MADT = TG.MADT
	AND GV.MAGV = TG1.MAGV
	)
)

--Q61: Cho"biết"giáo"viên"nào"đã"tham"gia"tất"cả các"đề tài"có"mã"chủ đề là"QLGD.
SELECT DISTINCT GV.*
FROM GiaoVien GV
WHERE NOT EXISTS
	(SELECT *
	FROM  DeTai DT
	WHERE DT.MACD = 'QLGD'
	AND NOT EXISTS
		(
		SELECT *
		FROM ThamGiaDT TG1 
		WHERE GV.MAGV = TG1.MAGV AND TG1.MADT = DT.MADT
		)
)

--Q62: Cho"biết"tên"giáo"viên"nào"tham"gia"tất"cả các"đề tài"mà"giáo"viên"Trần"Trà"Hương"đã"tham"gia
SELECT DISTINCT GV.HOTEN
FROM GiaoVien GV JOIN ThamGiaDT TG ON TG.MAGV = GV.MAGV
WHERE NOT EXISTS
	(
	SELECT *
	FROM GiaoVien GV1 JOIN ThamGiaDT TG1 ON TG1.MAGV = GV1.MAGV
	AND GV1.HOTEN = N'Trần Trà Hương'
	JOIN DeTai DT ON DT.MADT = TG1.MADT
	WHERE NOT EXISTS (
					SELECT *
					FROM ThamGiaDT TG2
					WHERE TG2.MADT = DT.MADT AND TG2.MAGV = TG.MAGV
					)
	)
GO

--Q63: Cho"biết"tên"đề tài"nào"mà"được"tất"cả các"giáo"viên"của"bộ môn"Hóa"Hữu"Cơ"tham"gia.
SELECT DISTINCT DT.TENDT
FROM DeTai DT JOIN ThamGiaDT TG ON DT.MADT = TG.MADT
WHERE NOT EXISTS
	(
	SELECT *
	FROM GiaoVien GV JOIN BoMon BM ON GV.MABM = BM.MABM AND BM.TENBM = N'Hóa hữu cơ'
	WHERE NOT EXISTS
		(SELECT *
		FROM ThamGiaDT TG1
		WHERE TG1.MADT = TG.MADT
		AND GV.MAGV = TG1.MAGV
		)
	)
GO

--Q64: Cho"biết"tên"giáo"viên"nào"mà"tham"gia"tất"cả các"công"việc"của"đề tài"006
	SELECT DISTINCT GV.HOTEN
	FROM GiaoVien GV 
	WHERE NOT EXISTS
		(
		SELECT *
		FROM CongViec CV 
		WHERE CV.MADT = '006'
		AND NOT EXISTS (
						SELECT *
						FROM ThamGiaDT TG
						WHERE GV.MAGV = TG.MAGV AND CV.MADT = TG.MADT AND CV.SOTT = TG.STT
						)
		)
GO

--Q65: Cho"biết"giáo"viên"nào"đã"tham"gia"tất"cả các"đề tài"của"chủ đề Ứng"dụng"công"nghệ.
SELECT DISTINCT GV.*
FROM GiaoVien GV
WHERE NOT EXISTS
	(SELECT *
	FROM  DeTai DT JOIN ChuDe CD ON DT.MACD = CD.MACD
	WHERE CD.TENCD = N'Ứng dụng công nghệ'
	AND NOT EXISTS
		(
		SELECT *
		FROM ThamGiaDT TG1 
		WHERE GV.MAGV = TG1.MAGV AND TG1.MADT = DT.MADT
		)
)
GO

--Q66:	Cho"biết"tên"giáo"viên"nào"đã"tham"gia"tất"cả các"đề tài"của"do"Trần"Trà"Hương"làm"chủ nhiệm.
SELECT DISTINCT GV.HOTEN
FROM GiaoVien GV JOIN ThamGiaDT TG ON TG.MAGV = GV.MAGV
WHERE NOT EXISTS
	(
	SELECT *
	FROM GiaoVien GV1
	JOIN DeTai DT ON DT.GVCNDT = GV1.MAGV AND GV1.HOTEN = N'Trần Trà Hương'
	WHERE NOT EXISTS (
					SELECT *
					FROM ThamGiaDT TG2
					WHERE TG2.MADT = DT.MADT AND TG2.MAGV = TG.MAGV
					)
	)
GO

--Q67: Cho"biết"tên"đề tài"nào"mà"được"tất"cả các"giáo"viên"của"khoa"CNTT"tham"gia
SELECT DISTINCT DT.TENDT
FROM DeTai DT JOIN ThamGiaDT TG ON DT.MADT = TG.MADT
WHERE NOT EXISTS
	(SELECT *
	FROM GiaoVien GV JOIN BoMon BM ON GV.MABM = BM.MABM AND BM.MAKHOA = 'CNTT'
	WHERE NOT EXISTS
		(SELECT *
		FROM ThamGiaDT TG1
		WHERE TG1.MADT = TG.MADT
		AND GV.MAGV = TG1.MAGV
		)
	)
GO

--Q68: Cho"biết"tên"giáo"viên"nào"mà"tham"gia"tất"cả các"công"việc"của"đề tài"Nghiên"cứu"tế bào"gốc.
	SELECT DISTINCT GV.HOTEN
	FROM GiaoVien GV 
	WHERE NOT EXISTS
		(
		SELECT *
		FROM CongViec CV JOIN DeTai DT ON CV.MADT = DT.MADT 
		WHERE DT.TENDT = N'Nghiên cứu tế bào gốc'
		AND NOT EXISTS (
						SELECT *
						FROM ThamGiaDT TG
						WHERE GV.MAGV = TG.MAGV AND CV.MADT = TG.MADT AND CV.SOTT = TG.STT
						)
		)
GO

--Q69: Tìm"tên"các"giáo"viên"được"phân"công"làm"tất"cả các"đề tài"có"kinh"phí"trên"100"triệu?
SELECT DISTINCT GV.HOTEN
FROM GiaoVien GV
WHERE NOT EXISTS
	(SELECT *
	FROM  DeTai DT 
	WHERE DT.KINHPHI > 100
	AND NOT EXISTS
		(
		SELECT *
		FROM ThamGiaDT TG1 
		WHERE GV.MAGV = TG1.MAGV AND TG1.MADT = DT.MADT
		)
)
GO

--Q70: Cho"biết"tên"đề tài"nào"mà"được"tất"cả các"giáo"viên"của"khoa"Sinh"Học"tham"gia.
SELECT DISTINCT DT.TENDT
FROM DeTai DT JOIN ThamGiaDT TG ON DT.MADT = TG.MADT
WHERE NOT EXISTS
	(SELECT *
	FROM GiaoVien GV JOIN BoMon BM ON GV.MABM = BM.MABM
	JOIN Khoa K ON K.MAKHOA = BM.MAKHOA AND K.TENKHOA = N'Sinh học'
	WHERE NOT EXISTS
		(SELECT *
		FROM ThamGiaDT TG1
		WHERE TG1.MADT = TG.MADT
		AND GV.MAGV = TG1.MAGV
		)
	)
GO

--Q71: Cho"biết"mã"số,"họ tên,"ngày"sinh"của"giáo"viên"tham"gia"tất"cả các"công"việc"
--của"đề tài"“Ứng"dụng"hóa"học"xanh”
	SELECT DISTINCT GV.MAGV, GV.HOTEN, GV.NGSINH
	FROM GiaoVien GV 
	WHERE NOT EXISTS
		(
		SELECT *
		FROM CongViec CV JOIN DeTai DT ON CV.MADT = DT.MADT 
		WHERE DT.TENDT = N'Ứng dụng hóa học xanh'
		AND NOT EXISTS (
						SELECT *
						FROM ThamGiaDT TG
						WHERE GV.MAGV = TG.MAGV AND CV.MADT = TG.MADT AND CV.SOTT = TG.STT
						)
		)
GO

--Q72: Cho"biết"mã"số,"họ tên,"tên"bộ môn"và"tên"người"quản"lý"chuyên"môn"của"giáo"viên"
--tham"gia"tất"cả các"đề tài"thuộc"chủ đề “Nghiên"cứu"phát"triển”.
SELECT DISTINCT GV.MAGV, GV.HOTEN, BM.TENBM, (SELECT GVV.HOTEN FROM GiaoVien GVV WHERE GVV.MAGV = GV.GVQLCM) AS 'GVQLCM'
FROM GiaoVien GV JOIN BoMon BM ON GV.MABM = BM.MABM
WHERE NOT EXISTS
	(SELECT *
	FROM  DeTai DT JOIN ChuDe CD ON DT.MACD = CD.MACD
	WHERE CD.TENCD = N'Nghiên cứu phát triển'
	AND NOT EXISTS
		(
		SELECT *
		FROM ThamGiaDT TG1 
		WHERE GV.MAGV = TG1.MAGV AND TG1.MADT = DT.MADT
		)
)
GO

