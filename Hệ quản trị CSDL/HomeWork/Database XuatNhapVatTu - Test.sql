-- Tạo  database

-- Create database XuatNhapVatTu
-- use XuatNhapVatTu


create table VATTU
(
Mavtu char(4) not null,
Tenvtu nvarchar(50),
Dvitinh nvarchar(10),
Phantram real
)
go;
create table NHACC
(
Manhacc char(4) not null,
Tenncc nvarchar(50),
Diachi nvarchar(50),
Dienthoai char(15)
)
create table DONDH
(
Sodh char(4) not null,
Ngaydh datetime,
Manhacc char(4) not null
)
create table CTDONDH
(
Sodh char(4) not null,
Mavtu char(4) not null,
Sldat int
)
create table PNHAP
(
Sopn char(4) not null,
Ngaynhap datetime,
Sodh char(4) not null
)
create table CTPNHAP
(
Sopn char(4) not null,
Mavtu char(4) not null,
Slnhap int,
Dgnhap money
)
create table PXUAT
(
Sopx char(4) not null,
Ngayxuat datetime,
Tenkh nvarchar(100)
)
create table CTPXUAT
(
Sopx char(4) not null,
Mavtu char(4) not null,
Slxuat int,
Dgxuat money
)
create table TONKHO
(
Namthang char(6) not null,
Mavtu char(4) not null,
Sldau int,
Tongslnhap int,
Tongslxuat int,
Slcuoi int
)
--Tạo ràng buộc khóa chính, khóa ngoại
alter table VATTU
add constraint PK_VT primary key(Mavtu)
alter table NHACC
add constraint PK_NCC primary key(Manhacc)
alter table DONDH
add
constraint PK_DDH primary key(Sodh),
constraint FK_DDH_MANCC foreign key(Manhacc) references
NHACC(Manhacc)
alter table CTDONDH
add
constraint PK_CTDH primary key(Sodh,Mavtu),
constraint FK_CTDH_SODH foreign key(Sodh) references DONDH(Sodh),
constraint FK_CTDH_MAVT foreign key(Mavtu) references VATTU(Mavtu)
alter table PNHAP
add
constraint PK_PNHAP primary key(Sopn),
constraint FK_PNHAP_Sodh foreign key(Sodh) references DONDH(Sodh)
alter table CTPNHAP
add
constraint PK_CTPNHAP primary key(Sopn,Mavtu),
constraint FK_CTPNHAP_SOPN foreign key(Sopn) references
PNHAP(Sopn),
constraint FK_CTPNHAP_MAVT foreign key(Mavtu) references
VATTU(Mavtu)
alter table PXUAT
add constraint PK_PXUAT primary key(Sopx)
alter table CTPXUAT
add constraint PK_CTPXUAT primary key(Sopx,Mavtu),
constraint FK_CTPXUAT_SOPX foreign key(Sopx) references
PXUAT(Sopx),
constraint FK_CTPXUAT_MAVT foreign key(Mavtu) references
VATTU(Mavtu)
alter table TONKHO
add
constraint PK_TONKHO primary key(Namthang,Mavtu),
constraint FK_TONKHO_MAVT foreign key(Mavtu) references
VATTU(Mavtu)
--Tạo ràng buộc
alter table VATTU
add
constraint UN_VT unique(Tenvtu),
constraint DF_VT_DVT default N'Cái' for dvitinh,
constraint CHK_VT_PT check(PhanTram between 0 and 100)

alter table NHACC
add
constraint UN_NCC_TENNCC unique(Tenncc),
constraint UN_NCC_DC unique(Diachi),
constraint DF_NCC_DT default N'Chưa có' for Dienthoai

alter table CTDONDH
add constraint CHK_CTDH check(Sldat>0)

alter table CTPNHAP
add
constraint CHK_CTPN_SLN check(Slnhap>0),
constraint CHK_CTPN_DGN check(Dgnhap>0)

alter table CTPXUAT
add
constraint CHK_CTPX_SLX check(Slxuat>0),
constraint CHK_CTPX_DGX check(Dgxuat>0)

alter table TONKHO
add
constraint CHK_TONKHO_SLD check(Sldau>=0),
constraint CHK_TONKHO_TSLN check(Tongslnhap>=0),
constraint CHK_TONKHO_TSLX check(Tongslxuat>=0),
constraint DF_TONKHO_SLD default 0 for Sldau,
constraint DF_TONKHO_TSLN default 0 for Tongslnhap,
constraint DF_TONKHO_TSLX default 0 for Tongslxuat

--Chèn dữ liệu
insert into VATTU values('BU01',N'Bàn ủi Philip A',N'Cái',17)
insert into VATTU values('BU02',N'Bàn ủi Philip B',N'Cái',17)
insert into VATTU values('BU03',N'Bàn ủi Philip C',N'Cái',17)
insert into VATTU values('DD01',N'Đầu Hitachi 1 đĩa',N'Bộ',40)
insert into VATTU values('DD02',N'Đầu Hitachi 3 đĩa',N'Bộ',40)
insert into VATTU values('KO02',N'Đầu Karaoke',N'Bộ',30)
insert into VATTU values('KO04',N'Đầu Karaoke 6 số',N'Bộ',30)
insert into VATTU values('MH01',N'Máy hát sony đời IK-2002',N'Bộ',NULL)
insert into VATTU values('TL15',N'Tủ lạnh Sanyo 150 lít',N'Cái',25)
insert into VATTU values('TL90',N'Tủ lạnh Sanyo 90 lít',N'Cái',20)
insert into VATTU values('TV14',N'Tivi Sony 14 inches',N'Cái',15)
insert into VATTU values('TV21',N'Tivi Sony 21 inches',N'Cái',10)
insert into VATTU values('TV29',N'Tivi Sony 29 inches',N'Cái',10)
insert into VATTU values('TV35',N'Tivi Sony 35 inches',N'Cái',100)
insert into VATTU values('TV40',N'Tivi Sony 40 inches',N'Cái',100)
insert into VATTU values('TV50',N'Tivi Sony 50 inches',N'Cái',37)
insert into VATTU values('TV51',N'Tivi Sony 51 inches',N'cái',37)
insert into VATTU values('TV53',N'Tivi Sony 53 inches',N'Cái',80)
insert into VATTU values('VD01',N'Đầu VCD Sony 1 đĩa',N'Bộ',30)
insert into VATTU values('VD02',N'Đầu VCD Sony 3 đĩa',N'Bộ',15)

--THEM GIA TRI VAO BANG NHACC--
insert into NHACC Values('C01',N'Lê Minh Trí',N'54,Hậu Giang,Q6,HCM',8781024)
insert into NHACC Values('C02',N'Trần Minh Thạch',N'145, Hùng Vương, Mỹ Tho',7698154)
insert into NHACC Values('C03',N'Hùng Phương',N'154/85, Lê Lai, Q1,HCM',9600125)
insert into NHACC Values('C04',N'Nhã Thương',N'198/40,Hương Lộ 14,QTB,HCM',8757757)
insert into NHACC Values('C05',N'Luu Nguyệt Quế',N'178, Nguyễn Văn Luông, Ðà Lạt',796451)
insert into NHACC Values('C07',N'Cao Minh Trung',N'125,Lê Quang Trung',default)

--THEM GIA TRI VAO BANG DONDH--
insert into DONDH Values('D002','2/1/2002','C01')
insert into DonDH Values('D003','2/10/2006','C02')
insert into DONDH Values('D004','2/17/2006','C05')
insert into DONDH Values('D005','3/1/2006','C02')
insert into DONDH Values('D001', '7/1/2006','C04')
--THEM GIA TRI VAO BANG CTDONDH--
insert into CTDONDH Values('D001','DD01',20)
insert into CTDONDH Values('D001','DD02',15)
insert into CTDONDH Values('D002','VD02',30)
insert into CTDONDH Values('D001','TV14',30)
insert into CTDONDH Values('D003','TV14',10)
insert into CTDONDH Values('D003','TV29',20)
insert into CTDONDH Values('D004','TL90',10)
insert into CTDONDH Values('D005','TV14',10)
insert into CTDONDH Values('D005','TV29',20)
--THEM GIA TRI VAO BANG PNHAP--
insert into PNHAP Values('N001','1/17/2006','D001')
insert into PNHAP Values('N002','1/20/2006','D004')
insert into PNHAP Values('N003','1/31/2006','D002')
insert into PNHAP Values('N004','2/15/2006','D003')
insert into PNHAP Values('N005','2/15/2007','D003')
insert into PNHAP Values('N006','2/28/2007','D005')

--THEM GIA TRI VAO BANG CTPNHAP--
insert into CTPNHAP Values('N001','DD01',8,2500000)
insert into CTPNHAP Values('N001','DD02',10,3500000)
insert into CTPNHAP Values('N002','DD02',5,3500000)
insert into CTPNHAP Values('N003','VD02',30,2500000)
insert into CTPNHAP Values('N004','TV14',5,2500000)
insert into CTPNHAP Values('N004','TV29',2,3500000)
insert into CTPNHAP Values('N006','DD01',190,200000)
insert into CTPNHAP Values('N006','TV29',2,200000)

--THEM GIA TRI VAO BANG PXUAT--
insert into PXuat Values('X001','1/17/2006',N'Nguyễn Thị Phương Nhi')
insert into PXuat Values('X002','1/25/2006',N'Nguyễn Hùng Phương')
insert into PXuat Values('X003','1/31/2006',N'Nguyễn Tuấn Tú')
--THEM GIA TRI VAO BANG CTPXUAT--
insert into CTPXUAT Values('X001','DD01',2,3500000)
insert into CTPXUAT Values('X002','DD01',2,3500000)
insert into CTPXUAT Values('X002','DD02',5,4900000)
insert into CTPXUAT Values('X003','DD01',3,3500000)
insert into CTPXUAT Values('X003','DD02',2,4900000)
insert into CTPXUAT Values('X003','VD02',10,3250000)
--THEM GIA TRI VAO BANG TONKHO--
insert into TONKHO Values(200601,'DD01',0,10,6,4)
insert into TONKHO Values(200601,'DD02',0,15,7,8)
insert into TONKHO Values(200601,'TV29',12,0,0,12)
insert into TONKHO Values(200601,'VD02',0,30,10,20)
insert into TONKHO Values(200602,'DD01',4,0,0,4)
insert into TONKHO Values(200602,'DD02',8,0,0,8)
insert into TONKHO Values(200602,'TV14',5,0,0,5)
insert into TONKHO Values(200602,'VD01',20,0,0,20)
insert into TONKHO Values(200603,'DD01',0,190,0,190)








