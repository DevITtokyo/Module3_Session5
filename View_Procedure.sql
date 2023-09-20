Create database QuanLySanPham;
Use QuanLySanPham;
Create table DanhMucSP(
	MaDanhMuc int primary key auto_increment,
    TenDanhMuc varchar(50) not null unique,
    MoTa text,
    TrangThai bit default 1
);
Create table SanPham(
	MaSP varchar(5) primary key,
    TenSP varchar(100) not null unique,
    NgayTao date default (current_date),
    Gia float default 0,
    MoTaSP text,
    TieuDe varchar(200),
    MaDanhMuc int ,
    TrangThaiSP bit default 1,
	foreign key (MaDanhMuc) references DanhMucSP(MaDanhMuc)
);
-- Thêm dữ liệu vào bảng Danh mục SP
Insert into DanhMucSP (MaDanhMuc, TenDanhMuc, MoTa, TrangThai)
Values (1,'Quần áo','Hàng VN chất lượng cao',1),
	   (2,'Nội thất','Đồ gỗ', 0),
       (3,'Trái cây','Nhập khẩu',1);
      
-- Thêm dữ liệu vào bảng SanPham     
Insert into SanPham (MaSP, TenSP, NgayTao, Gia, MoTaSP, TieuDe, MaDanhMuc,TrangThaiSP)
Values ('SP01','Bàn ăn',current_date(), 1000000,'1m*1m2*1m','Phong Cách Sống',2,true),
       ('SP02','Táo',current_date(), 15000,'1kg','Trái Cây Nhiệt Đới',3,true),
       ('SP03','Áo phông',current_date(), 200000,'Màu trắng','Thời trang và cuộc sống',1,false),
	   ('SP04','Nho',current_date(), 80000,'1kg','Trái Cây Nhiệt Đới',3,true)

-- 4. Tạo view gồm các sản phẩm có giá lớn hơn 20000 gồm các thông tin sau: 
    -- mã danh mục, tên danh mục, trạng thái danh mục, mã sản phẩm, tên sản phẩm 
    -- giá sản phẩm, trạng thái sản phẩm
    
Create view vw_GiaSanPham
as 
select  DanhMucSP.MaDanhMuc, DanhMucSP.TenDanhMuc, DanhMucSP.TrangThai,
        SanPham.MaSP, SanPham.TenSP, SanPham.Gia, SanPham.TrangThaiSP
from SanPham 
join DanhMucSP on SanPham.MaDanhMuc = DanhMucSP.MaDanhMuc
where SanPham.Gia > 20000

-- 5. Tạo các procedure sau:

-- procedure cho phép thêm mới của bảng danh mục 
DELIMITER //
create procedure insert_DanhMuc(
     in Ten varchar(50),
	 in MoTaDM text,
     in TrangThaiDM bit
)
BEGIN
	insert into DanhMucSP(TenDanhMuc, MoTa, TrangThai)
    values(Ten, MoTaDM,TrangThaiDM);
END //
DELIMITER ;
call insert_DanhMuc ('Danh muc', 'Danh muc mới thêm',1);

-- procedure cho phép sửa danh muc
DELIMITER //
Create procedure update_DanhMuc(
	MaDM int,
    TenDM varchar(50),
    MoTa text,
    TrangThai bit
)
BEGIN
	update DanhMucSP
    set TenDanhMuc = TenDM,
		MoTa = Mota,
        TrangThai = TrangThai
	where MaDanhMuc = MaDM;
END //
DELIMITER ;
call update_DanhMuc (2,'Nội thất','Chất liệu gỗ', 0)

-- procedure cho phép xoá danh muc
DELIMITER //
create procedure delete_DanhMuc(
	Ma_Danh_Muc int
)
BEGIN
	delete from DanhMucSP where Ma_Danh_Muc = MaDanhMuc;
END //
DELIMITER ;
call delete_DanhMuc(4);

-- procedure cho phép lấy tất cả dữ liệu
DELIMITER //
create procedure get_all_DanhMuc(
)
BEGIN
	select * from DanhMucSP;
END //
DELIMITER ;
call get_all_DanhMuc();

-- procedure cho phép thêm mới của bảng sản phẩm
 DELIMITER //
create procedure insert_SanPham(
      MaSanPham varchar(5),
      TenSanPham varchar(100),
      NgayTaoSP date,
      GiaSanPham float,
      MoTaSanPham text,
      TieuDeSP varchar(200),
      MaDM int ,
      TrangThaiSanPham bit
)
BEGIN
	insert into SanPham(MaSP, TenSp, NgayTao, Gia, MoTaSP,TieuDe, MaDanhMuc, TrangThaiSP)
    values(MaSanPham, TenSanPham, NgayTaoSP, GiaSanPham, MoTaSanPham, TieuDeSP, MaDM, TrangThaiSanPham);
END //
DELIMITER ;
call insert_SanPham ('SP005', 'Sản Phẩm 5','2023-09-20',1000,'sản phẩm thêm mới','tiêu đề mới',2,0);

-- procedure cho phép sửa sản phẩm
DELIMITER //
Create procedure update_SanPham(
	 MaSanPham varchar(5),
     TenSanPham varchar(100),
     NgayTaoSP date,
     GiaSanPham float,
     MoTaSanPham text,
     TieuDeSP varchar(200),
     MaDM int,
     TrangThaiSanPham bit
)
BEGIN
	update SanPham
    set MaSP = MaSanPham,
		TenSP = TenSanPham,
        NgayTao = NgayTaoSP,
        Gia = GiaSanPham,
        MoTaSP = MoTaSanPham,
        TieuDe = TieuDeSP,
        MaDanhMuc = MaDM,
        TrangThaiSP = TrangThaiSanPHam
        where MaSP = MaSanPham;
END //
DELIMITER ;
call update_SanPham ('SP005','Sản Phẩm 5','2023-09-20',2000,'SP thêm mới','tiêu đề mới',2,1)

-- procedure cho phép xoá sản phẩm
DELIMITER //
create procedure delete_SanPham(
	MaSanPham varchar(5)
)
BEGIN
	delete from SanPham where MaSanPham = MaSP;
END //
DELIMITER ;
call delete_SanPham('SP005');

-- procedure cho phép lấy tất cả dữ liệu
DELIMITER //
create procedure get_all_SanPham(
)
BEGIN
	select * from SanPham;
END //
DELIMITER ;

-- procedure cho phép lấy tất cả dữ liệu theo mã sản phẩm
DELIMITER //
create procedure get_all_SanPham_byID(
	MaSanPham varchar(5)
)
BEGIN
    select * from SanPham where MaSP = MaSanPham;
END;
//
DELIMITER ;
call get_all_SanPham_byID('SP02');


-- procedure cho phép lấy tất cả dữ liệu theo mã danh mục
DELIMITER //
create procedure get_all_Danhmuc_byID(
	Ma_Danh_Muc int
)
BEGIN
    select * from DanhMucSP where MaDanhMuc = Ma_Danh_Muc;
END;
//
DELIMITER ;
call get_all_Danhmuc_byID(2);

-- procedure cho phép lấy ra tất cả các phẩm có trạng thái là 1 bao gồm mã sản phẩm, tên sản phẩm, giá, tên danh mục, trạng thái sản phẩm
DELIMITER //
create procedure SP_TrangThai_1()
BEGIN
    select MaSP, TenSP, Gia, TenDanhMuc, SanPham.TrangThaiSP
    from SanPham
            join DanhMucSP on SanPham.MaDanhMuc = DanhMucSP.MaDanhMuc
    where SanPham.TrangThaiSP = 1;
END;
//
DELIMITER ;
call SP_TrangThai_1();

-- procedure cho phép thống kê số sản phẩm theo từng mã danh mục
DELIMITER //
create procedure ThongKe_SanPham()
BEGIN
    select MaDanhMuc, COUNT(MaSP)
    from SanPham
    group by MaDanhMuc;
END;
//
DELIMITER ;
call ThongKe_SanPham();

-- procedure cho phép tìm kiếm sản phẩm theo tên sản phầm: mã sản phẩm, tên sản phẩm, giá, trạng thái sản phẩm, tên danh mục, trạng thái danh mục
DELIMITER //
create procedure TimKiem_SP(
    Ten_SP VARCHAR(100)
)
BEGIN
    select MaSP, TenSP, Gia, SanPham.TrangThaiSP, TenDanhMuc, DanhMucSP.TrangThai
    from SanPham
             join DanhMucSP on SanPham.MaDanhMuc = DanhMucSP.MaDanhMuc
    where SanPham.TenSP like CONCAT('%', Ten_SP, '%');
END;
//
DELIMITER ;
call TimKiem_SP('a');