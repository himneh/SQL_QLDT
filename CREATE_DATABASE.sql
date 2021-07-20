/******************************************************************************************************************************************************************************
																		TẠO CSDL
******************************************************************************************************************************************************************************/
If not exists (Select*From sys.databases where name = 'QLLV')
	Create database QLLV
Go

Use QLLV


/******************************************************************************************************************************************************************************
																		TẠO BẢNG		
******************************************************************************************************************************************************************************/
Create table SINHVIEN(
	MSSV char(7) not null,
	HOTEN nvarchar(50),
	PHAI nchar(3),
	NGAYSINH datetime,
	DIACHI nvarchar(50),
	LOP char(10),
	MABM char(5),
	constraint PK_SINHVIEN primary key (MSSV)
)

Create table GIANGVIEN(
	MSGV char(6) not null,
	HOTEN nvarchar(50),
	PHAI nchar(3),
	NGAYSINH datetime,
	DIACHI nvarchar(50),
	MABM char(5),
	constraint PK_GIANGVIEN primary key (MSGV)
)

Create table LUANVAN(
	MSLV char(5) not null,
	TENLV nvarchar(125),
	MABM char(5),
	NAM char(4),
	constraint PK_LUANVAN primary key (MSLV)
)


Create table LUANVAN_SINHVIEN(
	MSLV char(5) not null,
	MSSV char(7),
	constraint PK_LUANVAN_SINHVIEN primary key (MSLV, MSSV)
)

Create table LUANVAN_GIANGVIEN(
	MSLV char(5) not null,
	MSGV char(6),
	VAITRO nvarchar(20),--Huong dan hay phan bien
	constraint PK_LUANVAN_GIANGVIEN primary key (MSLV, MSGV)
)

Create table BOMON(
	MABM char(5) not null,
	TENBM nvarchar(30),
	TRBM char(6)
	constraint PK_BOMON primary key (MABM)
)

Create table HOIDONG(
	MAHD int,
	NAM char(4),
	constraint PK_HOIDONG primary key (MAHD, NAM)
)

Create table THANHVIENHD(
	ID char(10),
	MAHD int,
	NAM char(4),
	MSGV char(6),
	VAITRO nvarchar(20),--Chủ tịch, thư kí hay ủy viên
	constraint PK_THANHVIENHD primary key (ID)
)


Create table BUOIBAOVE(
	MSLV char(5),
	NGAYBV datetime,
	PHONG char(4),
	MAHD int,
	NAM char(4),
	constraint PK_BUOIBAOVE primary key (MSLV)
)


Create table KETQUABAOVE(
	MSLV char(5),
	ID char(10),
	DIEM decimal(5,2),
	constraint PK_KETQUABAOVE primary key (MSLV, ID)
)


/******************************************************************************************************************************************************************************
																	TẠO RÀNG BUỘC		
******************************************************************************************************************************************************************************/
--Ràng buộc khóa ngoại giữa các bảng
Alter table SINHVIEN add constraint FK_SINHVIEN_BOMON foreign key (MABM) references BOMON (MABM)

Alter table GIANGVIEN add constraint FK_GIANGVIEN_BOMON foreign key (MABM) references BOMON (MABM)

Alter table LUANVAN_SINHVIEN add constraint FK_LUANVAN_SINHVIEN_SINHVIEN foreign key (MSSV) references SINHVIEN (MSSV)
Alter table LUANVAN_SINHVIEN add constraint FK_LUANVAN_SINHVIEN_LUANVAN foreign key (MSLV) references LUANVAN (MSLV)

Alter table LUANVAN_GIANGVIEN add constraint FK_LUANVAN_GIANGVIEN_GIANGVIEN foreign key (MSGV) references GIANGVIEN (MSGV)
Alter table LUANVAN_GIANGVIEN add constraint FK_LUANVAN_GIANGVIEN_LUANVAN foreign key (MSLV) references LUANVAN (MSLV)

Alter table LUANVAN add constraint FK_LUANVAN_BOMON foreign key (MABM) references BOMON (MABM)

Alter table THANHVIENHD add constraint FK_THANHVIENHD_HOIDONG foreign key (MAHD,NAM) references HOIDONG (MAHD,NAM)
Alter table THANHVIENHD add constraint FK_THANHVIENHD_GIANGVIEN foreign key (MSGV) references GIANGVIEN (MSGV)

Alter table BUOIBAOVE add constraint FK_BUOIBAOVE_LUANVAN foreign key (MSLV) references LUANVAN (MSLV)
Alter table BUOIBAOVE add constraint FK_BUOIBAOVE_HOIDONG foreign key (MAHD, NAM) references HOIDONG (MAHD, NAM)

Alter table KETQUABAOVE add constraint FK_KETQUABAOVE_LUANVAN foreign key (MSLV) references LUANVAN (MSLV)
Alter table KETQUABAOVE add constraint FK_KETQUABAOVE_THANHVIENHD foreign key (ID) references THANHVIENHD (ID)

--Ràng buộc miền giá trị trên các bảng
Alter table SINHVIEN add constraint CHK_SINHVIEN_GIOITINH check (PHAI in (N'Nam',N'Nữ'))
Alter table GIANGVIEN add constraint CHK_GIANGVIEN_GIOITINH check (PHAI in (N'Nam',N'Nữ'))
Alter table BOMON add constraint CHK_BOMON_TENBM check (TENBM in (N'Công nghệ phần mềm',N'Hệ thống thông tin',N'Khoa học máy tính',N'Công nghệ tri thức',N'Mạng máy tính'))
Alter table LUANVAN_GIANGVIEN add constraint CHK_LUANVAN_GIANGVIEN_VAITRO check (VAITRO in(N'Phản biện',N'Hướng dẫn'))
Alter table THANHVIENHD add constraint CHK_THANHVIENHD_VAITRO check (VAITRO in(N'Chủ tịch hội đồng',N'Thư ký',N'Ủy viên'))


/******************************************************************************************************************************************************************************
																			NHẬP LIỆU	
******************************************************************************************************************************************************************************/
--Nhập liệu bộ môn
Insert into BOMON values('CNPM',N'Công nghệ phần mềm','GV0009')
Insert into BOMON values('HTTT',N'Hệ thống thông tin','GV1002')
Insert into BOMON values('KHMT',N'Khoa học máy tính','GV1013')
Insert into BOMON values('MMT',N'Mạng máy tính','GV1010')
Insert into BOMON values('CNTT',N'Công nghệ tri thức','GV1014')


--Nhập liệu luận văn
Insert into LUANVAN values('0001',N'Xây dựng phần mềm quản lý nhà sách Nguyễn Văn Cừ', 'HTTT', '2009')
Insert into LUANVAN values('0002',N'Nghiên cứu xây dựng website học online', 'HTTT', '2009')
Insert into LUANVAN values('0003',N'Nghiên cứu công nghệ lập trình di động và xây dựng ứng dụng minh họa', 'CNPM', '2009')
Insert into LUANVAN values('0004',N'Nghiên cứu công nghệ xử lý tiếng nói và xây dựng ứng dụng minh họa', 'KHMT', '2009')
Insert into LUANVAN values('0005',N'Xây dựng website bán đấu giá sản phẩm', 'HTTT', '2009')


--Nhập liệu sinh vien
Insert into SINHVIEN values('0512043',N'Nguyễn Nam',N'Nam','03/29/1988',N'25 Lê Lợi - TP HCM','TH2004/01','CNPM')
Insert into SINHVIEN values('0512044',N'Trần Văn Duy',N'Nam','01/02/1987',N'514 XVNT - TP HCM','TH2004/01','HTTT')
Insert into SINHVIEN values('0512045',N'Lê Thúy Hằng',N'Nữ','08/16/1987',N'21 Pasteur - TP HCM','TH2004/01','MMT')
Insert into SINHVIEN values('0512046',N'Trần Diễm My',N'Nữ','01/20/1988',N'227 CMT8 - TP HCM','TH2004/01','CNPM')
Insert into SINHVIEN values('0512047',N'Lê Văn Minh',N'Nam','10/01/1988',N'78 Lê Lợi - TP HCM','TH2004/02','HTTT')
Insert into SINHVIEN values('0512048',N'Phạm Ngọc Thảo',N'Nữ','12/08/1988',N'1 Bạch Đằng - TP HCM','TH2004/02','HTTT')
Insert into SINHVIEN values('0512049',N'Phạm Thị Mỹ Hạnh',N'Nữ','01/01/1988',N'116 An Dương Vương - TP HCM','TH2004/02','MMT')
Insert into SINHVIEN values('0512050',N'Phan Thanh Duy',N'Nam','11/20/1988',N'28 Bùi Thị Xuân - TP HCM','TH2004/02','KHMT')
Insert into SINHVIEN values('0512051',N'Đinh Gia Bảo',N'Nam','04/18/1988',N'225 Nguyễn Văn Cừ - TP HCM','TH2004/02','KHMT')


--Nhập liệu giảng viên
Insert into GIANGVIEN values('GV1003',N'Nguyễn Thùy Trâm',N'Nữ','06/29/1970',N'16 CMT8 - TP HCM','HTTT')
Insert into GIANGVIEN values('GV1005',N'Trần Trung Tín',N'Nam','09/17/1980',N'22 Bạch Đằng - TP HCM','CNPM')
Insert into GIANGVIEN values('GV0009',N'Vũ Nam Phong',N'Nam','05/04/1978',N'556 XVNT - TP HCM','CNPM')
Insert into GIANGVIEN values('GV1010',N'Lê Thị Ngọc Lan',N'Nữ','01/19/1968',N'315 CMT8 - TP HCM','MMT')
Insert into GIANGVIEN values('GV1002',N'Phan Thị Lan Anh',N'Nữ','07/28/1979',N'45 Pasteur - TP HCM','HTTT')
Insert into GIANGVIEN values('GV1013',N'Lê Thanh Tuyền',N'Nữ','05/31/1980',N'315 CMT8 - TP HCM','KHMT')
Insert into GIANGVIEN values('GV1014',N'Đặng Trung Dũng',N'Nam','08/02/1969',N'40 Pasteur - TP HCM','CNTT')


--Nhập liệu luận văn - sinh viên
Insert into LUANVAN_SINHVIEN values('0001','0512043')
Insert into LUANVAN_SINHVIEN values('0001','0512044')
Insert into LUANVAN_SINHVIEN values('0002','0512045')
Insert into LUANVAN_SINHVIEN values('0002','0512046')
Insert into LUANVAN_SINHVIEN values('0003','0512047')
Insert into LUANVAN_SINHVIEN values('0003','0512048')
Insert into LUANVAN_SINHVIEN values('0004','0512049')
Insert into LUANVAN_SINHVIEN values('0004','0512050')
Insert into LUANVAN_SINHVIEN values('0005','0512051')


--Nhập liệu luận văn - giảng viên
Insert into LUANVAN_GIANGVIEN values('0001','GV1003',N'Hướng dẫn')
Insert into LUANVAN_GIANGVIEN values('0001','GV1002',N'Phản biện')
Insert into LUANVAN_GIANGVIEN values('0002','GV1002',N'Hướng dẫn')
Insert into LUANVAN_GIANGVIEN values('0002','GV0009',N'Phản biện')
Insert into LUANVAN_GIANGVIEN values('0003','GV1005',N'Hướng dẫn')
Insert into LUANVAN_GIANGVIEN values('0003','GV1013',N'Phản biện')
Insert into LUANVAN_GIANGVIEN values('0004','GV1013',N'Hướng dẫn')
Insert into LUANVAN_GIANGVIEN values('0004','GV1010',N'Phản biện')
Insert into LUANVAN_GIANGVIEN values('0005','GV1002',N'Hướng dẫn')
Insert into LUANVAN_GIANGVIEN values('0005','GV1005',N'Phản biện')


--Nhập liệu hội đồng
Insert into HOIDONG values(1,'2009')
Insert into HOIDONG values(2,'2009')
Insert into HOIDONG values(3,'2009')


--Nhập liệu buổi bảo vệ
Insert into BUOIBAOVE values('0001','07/18/2008','I11',1,'2009')
Insert into BUOIBAOVE values('0002','07/21/2009','I11',1,'2009')
Insert into BUOIBAOVE values('0003','07/18/2009','I52',2,'2009')
Insert into BUOIBAOVE values('0004','07/20/2009','I52',2,'2009')
Insert into BUOIBAOVE values('0005','07/22/2009','I64',3,'2009')


--Nhập liệu thành viên hội đồng
Insert into THANHVIENHD values('1109',1,'2009','GV1003',N'Chủ tịch hội đồng')
Insert into THANHVIENHD values('2109',1,'2009','GV1002',N'Thư ký')
Insert into THANHVIENHD values('3109',1,'2009','GV1005',N'Ủy viên')
Insert into THANHVIENHD values('4109',1,'2009','GV0009',N'Ủy viên')
Insert into THANHVIENHD values('5109',1,'2009','GV1013',N'Ủy viên')
Insert into THANHVIENHD values('1209',1,'2009','GV0009',N'Chủ tịch hội đồng')
Insert into THANHVIENHD values('2209',2,'2009','GV1005',N'Thư ký')
Insert into THANHVIENHD values('3209',2,'2009','GV1003',N'Ủy viên')
Insert into THANHVIENHD values('4209',2,'2009','GV1013',N'Ủy viên')
Insert into THANHVIENHD values('5209',2,'2009','GV1010',N'Ủy viên')
Insert into THANHVIENHD values('1309',3,'2009','GV1002',N'Chủ tịch hội đồng')
Insert into THANHVIENHD values('2309',3,'2009','GV1003',N'Thư ký')
Insert into THANHVIENHD values('3309',3,'2009','GV1013',N'Ủy viên')
Insert into THANHVIENHD values('4309',3,'2009','GV1005',N'Ủy viên')
Insert into THANHVIENHD values('5309',3,'2009','GV0009',N'Ủy viên')


--Nhập liệu kết quả bảo vệ
Insert into KETQUABAOVE values('0001','1109',8.5)
Insert into KETQUABAOVE values('0001','2109',7.5)
Insert into KETQUABAOVE values('0001','3109',8)
Insert into KETQUABAOVE values('0001','4109',8.5)
Insert into KETQUABAOVE values('0001','5109',8.5)

Insert into KETQUABAOVE values('0002','1109',8.5)
Insert into KETQUABAOVE values('0002','2109',7.5)
Insert into KETQUABAOVE values('0002','3109',8)
Insert into KETQUABAOVE values('0002','4109',8.5)
Insert into KETQUABAOVE values('0002','5109',8.5)

Insert into KETQUABAOVE values('0003','1209',8.5)
Insert into KETQUABAOVE values('0003','2209',8)
Insert into KETQUABAOVE values('0003','3209',8.5)
Insert into KETQUABAOVE values('0003','4209',8)
Insert into KETQUABAOVE values('0003','5209',8)

Insert into KETQUABAOVE values('0004','1209',9)
Insert into KETQUABAOVE values('0004','2209',9.5)
Insert into KETQUABAOVE values('0004','3209',8.5)
Insert into KETQUABAOVE values('0004','4209',9)
Insert into KETQUABAOVE values('0004','5209',9)

Insert into KETQUABAOVE values('0005','1309',8.5)
Insert into KETQUABAOVE values('0005','2309',7.5)
Insert into KETQUABAOVE values('0005','3309',8)
Insert into KETQUABAOVE values('0005','4309',8.5)
Insert into KETQUABAOVE values('0005','5309',8.5)
