--19120583
USE master
GO

/****************Phần 1: SP Tính toán (câu a --> câu i)****************/
--Câu a: In ra "Hello world"
CREATE PROCEDURE sp_print
AS
	Print 'Hello world!!!'
GO

EXEC sp_print
GO

--Câu b: In ra tổng 2 số (không có đối số đầu ra)
CREATE PROCEDURE sp_Tong2so @a int, @b int
AS
	Declare @tong int
	Set @tong = @a + @b
	Print @tong
GO

print N'Tổng 2 số là: '
EXEC sp_Tong2so 3,4
GO

--Câu c: In ra tổng 2 số có đối số out
CREATE PROCEDURE sp_Tong2sob @a int, @b int, @ans int out
AS
	Set @ans = @a + @b
GO

Declare @sum int
EXEC sp_Tong2sob 5,6,@sum out
print N'Tổng 2 số là: '
print @sum
GO

--Câu d: In ra tổng 3 số
CREATE PROCEDURE sp_Tong3so @a int, @b int, @c int, @ans int out
AS
	Declare @sum1 int
	EXEC sp_Tong2sob @a,@b,@sum1 out
	Set @ans = @sum1 + @c
GO

Declare @Sum int
EXEC sp_Tong3so 2,3,4,@Sum out
print N'Tổng 3 số là: '
print @Sum
GO

--Câu e: In ra tổng số nguyên từ m đến n
CREATE PROCEDURE sp_Tong_m_n @m int, @n int, @ans int out
AS
Declare @sum int, @i int
Set @sum = @m
Set @i = @m + 1
While(@i <= @n)
BEGIN
	Set @sum = @sum + @i
	Set @i = @i + 1
END
Set @ans = @sum
GO

Declare @Sum int
EXEC sp_Tong_m_n 2,4,@Sum out
print N'Tổng từ m đến n là: '
print @Sum
GO

--Câu f: Kiểm tra 1 số có phải là số nguyên tố hay không
CREATE PROCEDURE sp_isPrime @k int, @res int out
AS
IF (@k < 2) Set @res = 0
ELSE 
IF (@k = 2) Set @res = 1
ELSE
IF (@k % 2 = 0) Set @res = 0
ELSE 
BEGIN
	Declare @i int, @tmp int
	Set @i = 3
	Set @tmp = 0
	While(@i <= @k / 2)
	BEGIN
		IF (@k % @i = 0) 
		BEGIN
		Set @res = 0
		Set @tmp = 1
		break
		END
		Set @i = @i + 2
	END
	IF (@tmp = 0)
		Set @res = 1
END
GO

Declare @n int, @check int
Set @n = 99
EXEC sp_isPrime @n, @check out
if (@check = 0) print 'No'
else print 'Yes'
GO

--Câu g: In ra tổng các số nguyên tố trong đoạn m;n
CREATE PROCEDURE sp_SumPrimes @m int, @n int, @res int out
AS
	Declare @index int,@chezk int
	Set @index = @m
	Set @res = 0
	While(@index <= @n)
	BEGIN
		Set @chezk = 0
		EXEC sp_isPrime @index, @chezk out
		if(@chezk = 1) 
			Set @res = @res + @index
		Set @index = @index + 1
	END
GO

Declare @m int, @n int, @ans int
Set @m = 2
Set @n = 6
EXEC sp_SumPrimes @m, @n, @ans out
print N'Sum of Primes is: '
print @ans
GO

--Câu h: Tính ước chung lớn nhất của 2 số nguyên
CREATE PROCEDURE sp_gcd @a int, @b int, @res int out
AS
	if(@a = 0)
		Set @res = @a + @b
	else
		if(@b = 0)
			Set @res = @a + @b
		else 
			BEGIN
				while(@a != @b)
				BEGIN
					if(@a > @b) Set @a = @a - @b
					else Set @b = @b - @a
				END
			Set @res = @a
			END
GO

Declare @m int, @n int, @ans int
Set @m = 6
Set @n = 8
EXEC sp_gcd @m, @n, @ans out
print N'Greatest Common Divisor is: '
print @ans
GO

--Câu i: Tính bội chung nhỏ nhất của 2 số nguyên
CREATE PROCEDURE sp_lcm @m int, @n int, @res int out
AS
	EXEC sp_gcd @m, @n, @res out
	Set @res = @m * @n / @res
GO


Declare @m int, @n int, @ans int
Set @m = 8
Set @n = 12
EXEC sp_lcm @m, @n, @ans out
print N'Least Common Multiple is: '
print @ans
GO

/*******************Phần 2: SP QLDT (câu j --> câu t)****************/
USE QLDT
GO

--Câu j: Xuất ra toàn bộ danh sách giáo viên
CREATE PROCEDURE sp_PrintGV 
AS 
	SELECT *
	FROM GiaoVien
GO

EXEC sp_PrintGV
GO

--Câu k: Tính số lượng đề tài mà một giáo viên đang thực hiện:
CREATE PROCEDURE sp_CountDT @id char(5), @ans int out
AS
	Set @ans = 
				(SELECT COUNT(*)
				FROM ThamGiaDT TG
				WHERE TG.MAGV = @id)
GO

Declare @MS char(5), @res int 
Set @MS = '001'
EXEC sp_CountDT @MS, @res out
print N'SL đề tài đang thực hiện: '
print @res
GO

--Câu i: In ra thông tin chi tiết của một giáo viên
CREATE PROCEDURE sp_Print1GVi @id char(5)
AS
	Declare @hoten NVARCHAR(50), @luong FLOAT, @phai NCHAR(5), @ngaysinh DATETIME, @diachi NVARCHAR(50), @gvqlcm char(5), @mabm char(5)
	SELECT @hoten = GV.HOTEN, @luong = GV.LUONG, @ngaysinh = GV.NGSINH, @diachi = GV.DIACHI, @gvqlcm = GV.GVQLCM, @mabm = GV.MABM
	FROM GiaoVien GV
	WHERE GV.MAGV = @id

	Declare @sldt int
	Set @sldt = (
			SELECT COUNT(*) 
			FROM ThamGiaDT TG
			WHERE TG.MAGV = @id
			)
	Declare @slnt int 
	set @slnt = (	SELECT COUNT(*) 
					FROM NguoiThan NT
					WHERE NT.MAGV = @id )

	Print N'Thông tin cá nhân của GV: ' + @id + 'là: '
	Print N'Họ và tên: ' + @hoten
	Print N'Lương: ' + CAST(@luong AS VARCHAR)
	Print N'Ngày sinh: ' + CAST(@ngaysinh AS VARCHAR)
	Print N'Địa chỉ: ' + @diachi
	Print N'GVQLCM: ' + @gvqlcm
	Print N'Mã BM: ' + @mabm
	Print N'Số lượng đề tài tham gia: ' + CAST(@sldt AS VARCHAR)
	Print N'Số lượng nhân thân: ' + CAST(@slnt AS VARCHAR)

GO

Declare @MS char(5)
Set @MS = '001'
EXEC sp_Print1GVi @MS 
GO

--Câu m: Kiểm tra xem giáo viên có tồn tại hay không dựa vào MAGV
CREATE PROCEDURE sp_checkExist @id char(5)
AS
	 IF (EXISTS (SELECT * FROM GiaoVien GV WHERE GV.MAGV = @id))
		print N'Exist!'
	ELSE print N'No exist!'
GO

Declare @MS char(5)
Set @MS = '011'
EXEC sp_checkExist @MS 
GO

--Câu n: Kiểm tra GV chỉ thực hiện đề tài mà bộ môn GV đó làm CN
CREATE PROCEDURE sp_CheckGVn @magv char(5), @check int out
AS
	Declare @tmp char(5), @tmp1 char(5), @tmp2 char(5)
	Set @tmp = (SELECT GV.MABM FROM GiaoVien GV WHERE GV.MAGV = @magv)-- lấy MABM của GV cần ktra

	Set @tmp1 = (SELECT GV.GVQLCM FROM GiaoVien GV WHERE GV.MAGV = @magv) --Lấy GVQLCM của GV cần ktra
	Set @tmp2 = (SELECT GV.MABM FROM GiaoVien GV WHERE GV.MAGV = @tmp1) -- Lấy MaBM GVQLCM

	if(@tmp = @tmp2) set @check = 1
	else set @check = 0
GO

Declare @MS char(5), @czeck int
Set @MS = '007'
EXEC sp_CheckGVn @MS,@czeck out
if(@czeck = 1) print 'OK!'
	else print 'NO!'
GO


--Câu o: Thêm phân công cho GV có điều kiện
CREATE PROCEDURE sp_AddGVo @magv char(5), @madt char(5), @stt int
AS
	--Kiểm tra giáo viên, công việc, thời gian
	Declare @isFailed int,@tmp int
	Set @isFailed = 0

	IF (NOT EXISTS (SELECT * FROM GiaoVien GV WHERE GV.MAGV = @magv))
		Set @isFailed = 1
	IF (NOT EXISTS (SELECT * FROM CongViec CV WHERE CV.MADT = @madt AND CV.SOTT = @stt))
		Set @isFailed = 1
	EXEC sp_CheckGVn @magv,@tmp out
	IF(@tmp = 0) Set @isFailed = 1

	IF(@isFailed = 1) print 'ERROR!'
	ELSE
		BEGIN
			INSERT INTO ThamGiaDT(MAGV,MADT,STT)
			VALUES (@magv,@madt,@stt)
		END
GO

--TEST
Declare @MS char(5), @DT CHAR(5), @ST INT
Set @MS = '007'
SET @DT = '002'
SET @ST = 1
EXEC sp_AddGVo @MS, @DT, @ST
GO

--Câu p: Xóa GV theo mã
CREATE PROCEDURE sp_DeleteGV @magv char(5)
AS
	Declare @isFailed int
	Set @isFailed = 0

	if(EXISTS (SELECT * FROM ThamGiaDT TG WHERE TG.MAGV = @magv)) Set @isFailed = 1
	if(EXISTS (SELECT * FROM NguoiThan NT WHERE NT.MAGV = @magv)) Set @isFailed = 1
	if(EXISTS (SELECT * FROM Khoa K WHERE K.TRUONGKHOA = @magv)) Set @isFailed = 1
	if(EXISTS (SELECT * FROM GiaoVien GV WHERE GV.GVQLCM = @magv)) Set @isFailed = 1
	if(EXISTS (SELECT * FROM BoMon BM WHERE BM.TRUONGBM = @magv)) Set @isFailed = 1
	if(EXISTS (SELECT * FROM DeTai DT WHERE DT.GVCNDT = @magv)) Set @isFailed = 1

	IF(@isFailed = 0) 
		delete from GiaoVien
		where MAGV = @magv
	ELSE	PRINT N'ERROR! IT HURTS DATABASE :('
GO

--TEST
INSERT INTO GIAOVIEN(MAGV,HOTEN) --Thêm data ảo để test
values ('111','Park Chaeyoung')
GO
SELECT * FROM GIAOVIEN
GO
DECLARE @MS CHAR(5)
SET @MS = '111'
EXEC sp_DeleteGV @MS
SELECT * FROM GIAOVIEN
GO

DECLARE @MS CHAR(5)
SET @MS = '002'
EXEC sp_DeleteGV @MS
GO

--Câu q: In ra ds GV của 1 phòng ban cùng số lượng đề tài, số thân nhân số giáo viên quản lý
-- => Phòng ban nào ạ? đề sai nên câu này em bỏ qua

--Câu r:
CREATE PROC sp_checkGVr @gva char(5), @gvb char(5)
AS
	--Lấy lương của a
	Declare @tmpa float
	Set @tmpa = (SELECT GV.LUONG FROM GiaoVien GV WHERE GV.MAGV = @gva)

	--Lấy lương của b
	Declare @tmpb float
	Set @tmpb = (SELECT GV.LUONG FROM GiaoVien GV WHERE GV.MAGV = @gvb)

	--Lấy bộ môn của b
	Declare @tmp1 char(5)
	Set @tmp1 = (SELECT GV.MABM FROM GiaoVien GV WHERE GV.MAGV = @gvb)

	--Lấy trưởng bộ môn
	Declare @tmp2 char(5)
	Set @tmp2 = (SELECT GV.MAGV FROM GiaoVien GV JOIN BoMon BM on GV.MAGV = BM.TRUONGBM AND BM.MABM = @tmp1)

	--Kiểm tra a có phải trưởng bộ môn của b không
	if(@tmp2 = @gva) -- a là TBM của b
		--Kiểm tra lương
			if(@tmpa > @tmpb) print 'OK!'
			else print 'NO!'
	else print 'Invalid input'
GO

--TEST
DECLARE @MS1 CHAR(5), @MS2 char(5)
SET @MS1 = '002'
SET @MS2 = '003'
EXEC sp_checkGVr @MS1,@MS2	
GO

--Câu s: Thêm giáo viên có điều kiện
CREATE PROC sp_AddGVs @ma char(5), @hoten NVARCHAR(50), @ngaysinh DATETIME, @luong float
AS
	Declare @isFailed int
	Set @isFailed = 0

	--Kiem tra ten
	if(EXISTS (SELECT * FROM GiaoVien GV WHERE GV.HOTEN = @hoten))
		Set @isFailed = 1
	
	--Kiem tra tuoi
	Declare @tmp int
	Set @tmp = DATEDIFF(year,@ngaysinh,getdate())
	if(@tmp <= 18) Set @isFailed = 1

	--Kiem tra luong
	if(@luong <= 0) Set @isFailed = 1

	if(@isFailed = 1) print 'Invalid Input'
	else INSERT INTO GiaoVien(MAGV,HOTEN,NGSINH,LUONG)
		VALUES (@ma,@hoten,@ngaysinh,@luong)
	
GO

--TEST
Declare @ten NVARCHAR(50), @tuoi DATETIME, @salary float, @MS char(5)
Set @MS = '111'
Set @ten = N'Lê B'
Set @tuoi = '02/20/2000'
Set @salary = 2500
EXEC sp_AddGVs @MS, @ten, @tuoi, @salary
SELECT * FROM GiaoVien

Delete from GiaoVien 
WHERE MAGV = '111'

SELECT * FROM GiaoVien
GO

--Câu t: Xác định mã GV
CREATE PROC sp_IdenMGV @res char(5) out
AS 
	Declare @max int
	Set @max = (SELECT MAX(GV.MAGV) FROM GiaoVien GV)
	Declare @i int
	Set @i = 1
	while(@i <= @max)
		BEGIN
			IF(EXISTS (SELECT * FROM GiaoVien GV WHERE CAST(GV.MAGV AS INT) = @i))
				Set @i = @i + 1
			ELSE break
		END
	Set @res = CAST(@i AS char)
GO

Declare @ans char(5)
EXEC sp_IdenMGV @ans out

print @ans

/*******************Phần 3: QLKS****************/

IF DB_ID('QLKS') IS NOT NULL 
	DROP DATABASE QLKS
GO

CREATE DATABASE QLKS
GO
USE QLKS
GO

CREATE TABLE PHONG
(
MAPHONG CHAR(5),
TINHTRANG NCHAR(4),
LOAIPHONG CHAR(7),
DONGIA INT

CONSTRAINT PK_PHONG
PRIMARY KEY (MAPHONG)
)
GO

CREATE TABLE KHACH
(
MAKH CHAR(5),
HOTEN NVARCHAR(50),
DIACHI NVARCHAR(50),
DIENTHOAI char(13)

CONSTRAINT PK_KHACH
PRIMARY KEY (MAKH)
)
GO

CREATE TABLE DATPHONG
(
MADP INT,
MAKHDP CHAR(5),
MAPHONGDAT CHAR(5),
NGAYDP DATE,
NGAYTRA DATE,
THANHTIEN INT

CONSTRAINT PK_DP
PRIMARY KEY (MADP)

)
GO

ALTER TABLE DATPHONG
ADD 
	CONSTRAINT FK_DP_P
	FOREIGN KEY (MAPHONGDAT)
	REFERENCES PHONG,

	CONSTRAINT FK_DP_KH
	FOREIGN KEY (MAKHDP)
	REFERENCES KHACH
GO

INSERT PHONG(MAPHONG,TINHTRANG,LOAIPHONG,DONGIA)
VALUES
	('S1001',N'Rảnh','Single',2000),
	('D2001',N'Rảnh','Double',3500),
	('T3003',N'Bận','Tripple',5500),
	('Q4002',N'Rảnh','Quad',7500)
GO

INSERT KHACH(MAKH,HOTEN,DIACHI,DIENTHOAI)
VALUES 
	('001',N'Kim "Jisoo" Jisoo', N'227 Nguyễn Văn Cừ, Q5, Tp.HCM','0123456789'),
	('002',N'Kim "Jennie" Jennie', N'10 Trần Phú, P3, Tp. Đà Lạt','0135799797'),
	('003',N'Park "Rosé" Chaeyoung',N'357 Ngự Bình, An Cựu, Tp. Huế','0246810101'),
	('004',N'Pranpriya "Lisa" Manoban Lalisa',N'246 Chùa Hà, Cầu Giấy, Tp. Hà Nội','0987654312'),
	('005',N'Anonymous',N'Tp. Đà Nẵng','0988886868')
GO

INSERT DATPHONG(MADP,MAKHDP,MAPHONGDAT)
VALUES (1,'005','T3003')
GO

--Câu 1: 
CREATE PROCEDURE sp_DatPhong @makh char(5), @maphong char(5), @ngaydat date
AS
	BEGIN
		Declare @madatphong int, @maxMADP int
		Set @maxMADP = ( --Tìm ra mã đặt phòng lớn nhất
					SELECT(MAX(DP.MADP))
					FROM DATPHONG DP
					) 
		Set @madatphong = @maxMADP + 1 --Lưu lại để sau đó insert vào database

		Declare @isFail int -- Khởi tạo biến kiểm tra lỗi
		Set @isFail = 0 -- = 0 nếu dữ liệu hợp lệ và > 0 thì không hợp lệ

		--Kiểm tra mã khách hàng hợp lệ
		 IF (NOT EXISTS (SELECT * FROM KHACH k WHERE k.MAKH = @makh))
			BEGIN
			Set @isFail = @isFail + 1
			print 'Invalid MAKH!'
			END

		-- Kiểm tra mã phòng hợp lệ
		IF (NOT EXISTS (SELECT * FROM PHONG p WHERE p.MAPHONG = @maphong))
			BEGIN
			Set @isFail = @isFail + 1
			print 'Invalid MAPHONG!'
			END
		
		Declare @isReserved int, @tam NCHAR(5) -- tạo biến kiểm tra tình trạng phòng
		Set @isReserved = 0 -- = 0 là bận, = 1 là rảnh
		Set @tam = N'Rảnh'
		--Kiểm tra tình trạng phòng
		IF (@tam = (SELECT p.TINHTRANG FROM PHONG p WHERE p.MAPHONG = @maphong))
			Set @isReserved = 1
		ELSE 
			IF (@isFail = 0)
			print 'Room is reserved!'

		Declare @tmp int -- Khởi tạo biến kiểm tra có ghi nhận thông tin thành công hay không
		Set @tmp = 0
		-- Ghi nhận thông tin xuống CSDL
		if(@isFail = 0 AND @isReserved = 1) --Kiểm tra dữ liệu
			BEGIN
			INSERT DATPHONG(MADP,MAKHDP,MAPHONGDAT,NGAYDP)
			VALUES (@madatphong,@makh,@maphong,@ngaydat)
			Set @tmp = 1
			END

		--Cập nhật trình trạng phòng
		if(@tmp = 1)
			UPDATE PHONG
			SET TINHTRANG = N'Bận'
			WHERE MAPHONG = @maphong
	END
GO

--TEST
Declare @tmp1 char(5), @tmp2 char(5), @tmp3 date
Set @tmp1 = '001'
Set @tmp2 = 'S1001'
Set @tmp3 = '05/10/2021'
EXEC sp_DatPhong @tmp1,@tmp2,@tmp3

SELECT * FROM DATPHONG
SELECT * FROM PHONG
--Câu 2:
CREATE PROCEDURE sp_TraPhong @madp int, @makh char(5)
AS
	BEGIN
		--Kiếm tra tính hợp lệ của mã đặt phòng, mã khách hàng
		Declare @isFailed int --Khởi tạo biến kiểm tra
		Set @isFailed = 0 -- = 0 nếu Dữ liệu hợp lệ và = 1 nếu ngược lại
		IF(NOT EXISTS (SELECT * FROM DATPHONG DP WHERE DP.MADP = @madp AND @makh = DP.MAKHDP))
			Set @isFailed = 1
		IF(@isFailed = 1) print 'Invalid input!'

		Declare @ngaytra date
		Set @ngaytra = GETDATE()--lấy ngày hiện hành

		--Tính tiền thanh toán
		Declare @money int, @days int, @tmp DATE, @res int
		Set @tmp = (SELECT DP.NGAYDP FROM DATPHONG DP WHERE DP.MADP = @madp) --Lấy ngày đặt phòng
		Set @days = DATEDIFF(day,@tmp,@ngaytra) -- Tính số ngày đặt phòng
		Set @money = (SELECT P.DONGIA FROM PHONG P JOIN DATPHONG DP ON DP.MAPHONGDAT = P.MAPHONG AND DP.MADP = @madp)
		Set @res = @money * @days --Tổng tiền

		Declare @temp int -- Khởi tạo biến kiểm tra ghi nhận dữ liệu
		Set @temp = 0
		--Ghi nhận dữ liệu vào CSDL
		if(@isFailed = 0)
		BEGIN
			UPDATE DATPHONG
			SET THANHTIEN = @res
			WHERE MADP = @madp

			UPDATE DATPHONG
			SET NGAYTRA = @ngaytra
			WHERE MADP = @madp

			Set @temp = 1
		END
	
		--Cập nhật tình trạng phòng
			--Lấy mã phòng
			Declare @mph char(5)
			Set @mph = (SELECT P.MAPHONG FROM PHONG P JOIN DATPHONG DP ON DP.MAPHONGDAT = P.MAPHONG AND DP.MADP = @madp )
			
			if(@temp = 1)
				UPDATE PHONG
				SET TINHTRANG = N'Rảnh'
				WHERE MAPHONG = @mph
	END
GO

--TEST
Declare @tmp1 char(5), @tmp2 char(5)
Set @tmp2 = '001'
Set @tmp1 = '3'

EXEC sp_TraPhong @tmp1,@tmp2
SELECT * From DATPHONG

SELECT * FROM PHONG