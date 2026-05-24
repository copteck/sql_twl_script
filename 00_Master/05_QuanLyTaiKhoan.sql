-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHINH (MASTER)
-- FILE: 05_QuanLyTaiKhoan.sql
-- MO TA: NguoiDung, VaiTro, Quyen, GanVaiTro, GanQuyen
-- ============================================================
USE TWL_MASTER;
GO

-- ============================================================
-- BANG: NguoiDung
-- Thong tin dang nhap va tai khoan nguoi dung toan he thong
-- ============================================================
CREATE TABLE NguoiDung (
    Ma                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenDangNhap             NVARCHAR(100)     NOT NULL,
    EmailDangNhap           NVARCHAR(255)     NOT NULL,
    MatKhauBam              NVARCHAR(500)     NOT NULL,
    MuoiMatKhau             NVARCHAR(100)     NULL,
    HoTen                   NVARCHAR(255)     NOT NULL,
    SoDienThoai             NVARCHAR(20)      NULL,
    UrlAnhDaiDien           NVARCHAR(500)     NULL,
    MaChiNhanh              UNIQUEIDENTIFIER  NULL REFERENCES DangKyChiNhanh(Ma),
    LoaiNguoiDung           NVARCHAR(30)      NOT NULL DEFAULT 'NHAN_VIEN',
    -- QUANTRI_HETHONG | QUANTRI_CHINHANH | NHAN_VIEN | DAI_LY | KHACH_HANG | KHACH_VANGLAI
    DaXacThucEmail          BIT               NOT NULL DEFAULT 0,
    DaXacThucSdt            BIT               NOT NULL DEFAULT 0,
    XacThuc2Buoc            BIT               NOT NULL DEFAULT 0,
    LoaiXacThuc2Buoc        NVARCHAR(20)      NULL,
    -- OTP_SMS | OTP_EMAIL | GOOGLE_AUTH
    BiMatXacThuc2B          NVARCHAR(255)     NULL,
    SoLanDangNhapLoi        INT               NOT NULL DEFAULT 0,
    NgayKhoaTaiKhoan        DATETIME2         NULL,
    LyDoKhoa                NVARCHAR(500)     NULL,
    TokenLamMoiMatKhau      NVARCHAR(255)     NULL,
    HanTokenLamMoi          DATETIME2         NULL,
    LanDangNhapCuoi         DATETIME2         NULL,
    IpDangNhapCuoi          NVARCHAR(50)      NULL,
    TrangThai               NVARCHAR(20)      NOT NULL DEFAULT 'HOATDONG',
    -- HOATDONG | CHUA_KICHHOAT | DA_KHOA | DA_XOA
    NgayTao                 DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat             DATETIME2         NULL,
    DaXoa                   BIT               NOT NULL DEFAULT 0,
    CONSTRAINT PK_NguoiDung PRIMARY KEY (Ma),
    CONSTRAINT UQ_NguoiDung_TenDangNhap UNIQUE (TenDangNhap),
    CONSTRAINT UQ_NguoiDung_Email UNIQUE (EmailDangNhap)
);
GO

-- ============================================================
-- BANG: VaiTro
-- Danh sach cac vai tro trong he thong
-- ============================================================
CREATE TABLE VaiTro (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaVaiTro        NVARCHAR(50)      NOT NULL,
    TenVaiTro       NVARCHAR(100)     NOT NULL,
    MoTaVaiTro      NVARCHAR(500)     NULL,
    CapChiNhanh     TINYINT           NOT NULL DEFAULT 0,
    -- 0=TatCaCap, 1=TruSoChinh, 2=ChiNhanh, 3=Nhom/Doi
    LaVaiTroHeThong BIT               NOT NULL DEFAULT 0,
    ThuTuHienThi    INT               NOT NULL DEFAULT 0,
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_VaiTro PRIMARY KEY (Ma),
    CONSTRAINT UQ_VaiTro_MaVT UNIQUE (MaVaiTro)
);
GO

-- ============================================================
-- BANG: Quyen
-- Danh sach quyen han chi tiet trong he thong
-- ============================================================
CREATE TABLE Quyen (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaQuyen         NVARCHAR(100)     NOT NULL,
    TenQuyen        NVARCHAR(255)     NOT NULL,
    PhanHe          NVARCHAR(50)      NOT NULL,
    -- BANGDIEUHIEN | CHINHANH | DAILY | KHACHHANG | HOPDONG | HOAHONG | DOISOAT | SANPHAM | BAOCAO | HETHONG
    HanhDong        NVARCHAR(30)      NOT NULL,
    -- XEM | TAO | CAPNHAT | XOA | DUYET | XUATBAN | CAUHINH
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_Quyen PRIMARY KEY (Ma),
    CONSTRAINT UQ_Quyen_MaQ UNIQUE (MaQuyen)
);
GO

-- ============================================================
-- BANG: GanVaiTroNguoiDung
-- Gan vai tro cho nguoi dung
-- ============================================================
CREATE TABLE GanVaiTroNguoiDung (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaNguoiDung     UNIQUEIDENTIFIER  NOT NULL REFERENCES NguoiDung(Ma),
    MaVaiTro        UNIQUEIDENTIFIER  NOT NULL REFERENCES VaiTro(Ma),
    MaChiNhanh      UNIQUEIDENTIFIER  NULL REFERENCES DangKyChiNhanh(Ma),
    HieuLucTu       DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    HieuLucDen      DATETIME2         NULL,
    NguoiGan        UNIQUEIDENTIFIER  NULL,
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_GanVaiTroNguoiDung PRIMARY KEY (Ma),
    CONSTRAINT UQ_GanVaiTro UNIQUE (MaNguoiDung, MaVaiTro, MaChiNhanh)
);
GO

-- ============================================================
-- BANG: GanQuyenVaiTro
-- Gan quyen vao vai tro
-- ============================================================
CREATE TABLE GanQuyenVaiTro (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaVaiTro        UNIQUEIDENTIFIER  NOT NULL REFERENCES VaiTro(Ma),
    MaQuyen         UNIQUEIDENTIFIER  NOT NULL REFERENCES Quyen(Ma),
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_GanQuyenVaiTro PRIMARY KEY (Ma),
    CONSTRAINT UQ_GanQuyenVaiTro UNIQUE (MaVaiTro, MaQuyen)
);
GO

-- ============================================================
-- BANG: PhienDangNhap
-- Quan ly phien lam viec cua nguoi dung
-- ============================================================
CREATE TABLE PhienDangNhap (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaNguoiDung     UNIQUEIDENTIFIER  NOT NULL REFERENCES NguoiDung(Ma),
    TokenPhien      NVARCHAR(500)     NOT NULL,
    TokenLamMoi     NVARCHAR(500)     NULL,
    DiaChiIP        NVARCHAR(50)      NULL,
    ThietBi         NVARCHAR(255)     NULL,
    TrinhDuyet      NVARCHAR(255)     NULL,
    HeDieuHanh      NVARCHAR(100)     NULL,
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayHetHan      DATETIME2         NOT NULL,
    DaHuy           BIT               NOT NULL DEFAULT 0,
    NgayHuy         DATETIME2         NULL,
    CONSTRAINT PK_PhienDangNhap PRIMARY KEY (Ma)
);
GO
