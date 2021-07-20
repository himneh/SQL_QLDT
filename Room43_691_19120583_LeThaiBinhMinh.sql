--Lớp: CQ2019/03
--Room: 43
--Mã đề thi: 691
--MSSV: 19120583
--Họ và tên: Lê Thái Bình Minh

--TẠO CSDL
IF DB_ID('QLTH') IS NOT NULL 
	DROP DATABASE QLTH
GO
CREATE DATABASE QLTH
GO
USE QLTH
GO

--TẠO BẢNG VÀ RÀNG BUỘC KHÓA CHÍNH
CREATE TABLE TRUONG
(
	MaTruong CHAR(5),
	TenTruong NVARCHAR(40),
	DiaChi NVARCHAR(50),
	NamTL INT,
	ChiDoanTruong CHAR(5)

	CONSTRAINT PK_TRUONG
	PRIMARY KEY (MaTruong)
)
GO

CREATE TABLE LOPHOC
(
	MaLop CHAR(5),
	TenLop NVARCHAR(40),
	GVCN NVARCHAR(50),
	MaTruongLH CHAR(5),
	LopTruong CHAR(5)

	CONSTRAINT PK_LOP
	PRIMARY KEY (MaLop)
)
GO

CREATE TABLE HOCSINH
(
	MaHS CHAR(5),
	MaTruongHS CHAR(5),
	HoTen NVARCHAR(50),
	NgaySinh DATE,
	GioiTinh NCHAR(3),
	MaLopHS CHAR(5)

	CONSTRAINT PK_HS
	PRIMARY KEY (MaHS,MaTruongHS)
)
GO

--TẠO BẢNG VÀ RÀNG BUỘC KHÓA NGOẠI
ALTER TABLE TRUONG
ADD
	CONSTRAINT FK_TR_HS
	FOREIGN KEY(ChiDoanTruong,MaTruong)
	REFERENCES HOCSINH
GO

ALTER TABLE LOPHOC
ADD	
	CONSTRAINT FK_LOP_HS
	FOREIGN KEY(LopTruong, MaTruongLH)
	REFERENCES HocSinh
GO

ALTER TABLE HOCSINH
ADD
	CONSTRAINT FK_HS_TR
	FOREIGN KEY(MaTruongHS)
	REFERENCES TRUONG,

	CONSTRAINT FK_HS_LOP
	FOREIGN KEY(MaLopHS)
	REFERENCES LOPHOC
GO

--NHẬP DỮ LIỆU
INSERT INTO TRUONG(MaTruong, TenTruong, DiaChi, NamTL)
VALUES
	('TR01',N'Lê Hồng Phong',N'225 Nguyễn Văn Cừ, Quận 5, TP.HCM',1995),
	('TR02',N'Lê Quý Đôn',N'125 Lê Quý Đôn, Quận 3, TP.HCM',1993)
GO

INSERT INTO LOPHOC(MaLop, TenLop, GVCN, MaTruongLH)
VALUES
	('LA001',N'10 chuyên Toán',N'Vương Hải','TR01'),
	('LA002',N'10 chuyên Văn',N'Nguyễn Hồng Hạnh','TR01'),
	('LD001',N'11 chuyên Anh',N'Trấn Trung Trí','TR02')
GO

INSERT INTO HOCSINH(MaHS, MaTruongHS, HoTen, NgaySinh, GioiTinh, MaLopHS)
VALUES
	('HS01','TR01',N'Trần Hải','2/12/1999',N'Nam','LA001'),
	('HS02','TR01',N'Lê Anh Đào','12/30/1987',N'Nữ','LA001'),
	('HS03','TR01',N'Lý Khanh','6/6/1960',N'Nam','LA002'),
	('HS04','TR01',N'Phan Minh Trí','6/6/1960',N'Nam','LA002'),
	('HS01','TR02',N'Nguyễn Lan','3/7/1982',N'Nữ','LD001'),
	('HS02','TR02',N'Vũ Bình Phương','3/17/1980',N'Nam','LD001'),
	('HS03','TR02',N'Đặng Khải Minh','10/22/1980',N'Nam','LD001')
GO

UPDATE TRUONG
SET ChiDoanTruong = 'HS01'
WHERE MaTruong = 'TR01' OR MaTruong = 'TR02'
GO

UPDATE LOPHOC
SET LopTruong = 'HS02'
WHERE MaLop = 'LA001'
GO

UPDATE LOPHOC
SET LopTruong = 'HS03'
WHERE MaLop = 'LA002'
GO

UPDATE LOPHOC
SET LopTruong = 'HS01'
WHERE MaLop = 'LD001'
GO

--TRUY VẤN
--CÂU 4: CHO BIẾT THÔNG TIN MÃ VÀ TÊN LỚP CÓ LỚP TRƯỞNG HỌ 'NGUYỄN'
SELECT LH.MaLop, LH.TenLop
FROM LOPHOC LH JOIN HOCSINH HS ON LH.LopTruong = HS.MaHS
WHERE HS.HoTen LIKE N'Nguyễn %'
GO

--CÂU 5: CHO BIẾT THÔNG TIN MÃ, TÊN TRƯỜNG VÀ SỐ LƯỢNG HỌC SINH CỦA TỪNG TRƯỜNG
SELECT T.MaTruong, T.TenTruong, COUNT(HS.MaTruongHS) AS N'Số Lượng Học Sinh'
FROM TRUONG T JOIN HOCSINH HS ON HS.MaTruongHS = T.MaTruong
GROUP BY HS.MaTruongHS, T.MaTruong, T.TenTruong
GO

--CÂU 6: CHO BIẾT MÃ VÀ HỌ TÊN CHI ĐOÀN TRƯỞNG CỦA CÁC TRƯỜNG CÓ TỪ 2 LỚP HỌC TRỞ LÊN
SELECT T.ChiDoanTruong, HS.HoTen
FROM TRUONG T JOIN HOCSINH HS ON HS.MaHS = T.ChiDoanTruong AND HS.MaTruongHS = T.MaTruong
JOIN LOPHOC LH ON LH.MaTruongLH = T.MaTruong 
GROUP BY LH.MaTruongLH, T.ChiDoanTruong, HS.HoTen
HAVING COUNT(LH.MaTruongLH) >= 2
GO
