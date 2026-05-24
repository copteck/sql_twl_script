-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - KHO DU LIEU BAO CAO
-- FILE: 01_BangChieuDuLieu.sql
-- MO TA: Cac bang chieu (Dimension) cho bao cao
-- ============================================================
USE TWL_BAO_CAO;
GO

-- ============================================================
-- BANG: ChieuThoiGian
-- ============================================================
CREATE TABLE ChieuThoiGian (
    MaKhoaThoiGian      INT             NOT NULL,  -- YYYYMMDD
    NgayDayDu           DATE            NOT NULL,
    Nam                 INT             NOT NULL,
    Quy                 INT             NOT NULL,
    Thang               INT             NOT NULL,
    Tuan                INT             NOT NULL,
    NgayTrongThang      INT             NOT NULL,
    NgayTrongTuan       INT             NOT NULL,
    TenNgay             NVARCHAR(20)    NOT NULL,
    TenThang            NVARCHAR(20)    NOT NULL,
    LaNgayLamViec       BIT             NOT NULL DEFAULT 1,
    LaNgayLe            BIT             NOT NULL DEFAULT 0,
    TenNgayLe           NVARCHAR(100)   NULL,
    CONSTRAINT PK_ChieuThoiGian PRIMARY KEY (MaKhoaThoiGian)
);
GO

-- ============================================================
-- BANG: ChieuChiNhanh
-- ============================================================
CREATE TABLE ChieuChiNhanh (
    MaKhoaChiNhanh      UNIQUEIDENTIFIER  NOT NULL,
    MaSoChiNhanh        NVARCHAR(50)      NOT NULL,
    TenChiNhanh         NVARCHAR(255)     NOT NULL,
    LoaiChiNhanh        NVARCHAR(30)      NOT NULL,
    TinhThanh           NVARCHAR(100)     NULL,
    VungMien            NVARCHAR(50)      NULL,
    -- BAC | TRUNG | NAM
    TrangThai           NVARCHAR(20)      NOT NULL,
    NgayTao             DATETIME2         NOT NULL,
    NgayCapNhat         DATETIME2         NULL,
    CONSTRAINT PK_ChieuChiNhanh PRIMARY KEY (MaKhoaChiNhanh)
);
GO

-- ============================================================
-- BANG: ChieuDaiLy
-- ============================================================
CREATE TABLE ChieuDaiLy (
    MaKhoaDaiLy         UNIQUEIDENTIFIER  NOT NULL,
    MaSoDaiLy           NVARCHAR(50)      NOT NULL,
    HoTen               NVARCHAR(255)     NOT NULL,
    MaChiNhanh          UNIQUEIDENTIFIER  NOT NULL,
    TenChiNhanh         NVARCHAR(255)     NULL,
    MaDonVi             NVARCHAR(50)      NULL,
    TenDonVi            NVARCHAR(255)     NULL,
    CapBac              NVARCHAR(100)     NULL,
    SoThuTuCap          INT               NULL,
    TinhThanh           NVARCHAR(100)     NULL,
    NgayThamGia         DATE              NULL,
    TrangThai           NVARCHAR(20)      NOT NULL,
    NgayCapNhat         DATETIME2         NULL,
    CONSTRAINT PK_ChieuDaiLy PRIMARY KEY (MaKhoaDaiLy)
);
GO

-- ============================================================
-- BANG: ChieuSanPham
-- ============================================================
CREATE TABLE ChieuSanPham (
    MaKhoaSanPham       UNIQUEIDENTIFIER  NOT NULL,
    MaSoSanPham         NVARCHAR(100)     NOT NULL,
    TenSanPham          NVARCHAR(255)     NOT NULL,
    MaDanhMuc           NVARCHAR(50)      NULL,
    TenDanhMuc          NVARCHAR(255)     NULL,
    LoaiBaoHiem         NVARCHAR(50)      NOT NULL,
    MaNCC               NVARCHAR(50)      NOT NULL,
    TenNCC              NVARCHAR(255)     NOT NULL,
    TrangThai           NVARCHAR(20)      NOT NULL,
    NgayCapNhat         DATETIME2         NULL,
    CONSTRAINT PK_ChieuSanPham PRIMARY KEY (MaKhoaSanPham)
);
GO

-- ============================================================
-- BANG: ChieuNCC
-- ============================================================
CREATE TABLE ChieuNCC (
    MaKhoaNCC           UNIQUEIDENTIFIER  NOT NULL,
    MaSoNCC             NVARCHAR(50)      NOT NULL,
    TenNCC              NVARCHAR(255)     NOT NULL,
    TenVietTat          NVARCHAR(50)      NULL,
    LoaiNCC             NVARCHAR(30)      NOT NULL,
    TrangThai           NVARCHAR(20)      NOT NULL,
    NgayCapNhat         DATETIME2         NULL,
    CONSTRAINT PK_ChieuNCC PRIMARY KEY (MaKhoaNCC)
);
GO

-- ============================================================
-- BANG: ChieuKhachHang
-- ============================================================
CREATE TABLE ChieuKhachHang (
    MaKhoaKhachHang     UNIQUEIDENTIFIER  NOT NULL,
    MaSoKhachHang       NVARCHAR(50)      NOT NULL,
    HoTen               NVARCHAR(255)     NOT NULL,
    LoaiKhachHang       NVARCHAR(20)      NOT NULL,
    PhanKhuc            NVARCHAR(30)      NULL,
    TinhThanh           NVARCHAR(100)     NULL,
    NguonKhachHang      NVARCHAR(50)      NULL,
    MaChiNhanh          UNIQUEIDENTIFIER  NOT NULL,
    NgayTao             DATETIME2         NOT NULL,
    NgayCapNhat         DATETIME2         NULL,
    CONSTRAINT PK_ChieuKhachHang PRIMARY KEY (MaKhoaKhachHang)
);
GO
