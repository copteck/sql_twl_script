-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHI NHANH (TENANT)
-- FILE: 11_NhatKyHeThong.sql
-- MO TA: NhatKyHoatDong, NhatKyThayDoiDuLieu
-- ============================================================
GO

-- ============================================================
-- BANG: NhatKyHoatDong
-- Audit log - ghi nhan moi hanh dong cua nguoi dung
-- ============================================================
CREATE TABLE NhatKyHoatDong (
    Ma                  BIGINT            NOT NULL IDENTITY(1,1),
    MaChiNhanh          UNIQUEIDENTIFIER  NOT NULL,
    MaNguoiDung         UNIQUEIDENTIFIER  NULL,
    TenDangNhap         NVARCHAR(100)     NULL,
    HoTenNguoiDung      NVARCHAR(255)     NULL,
    LoaiHanhDong        NVARCHAR(30)      NOT NULL,
    -- DANG_NHAP | DANG_XUAT | TAO | CAP_NHAT | XOA | DUYET | TU_CHOI
    -- XUAT_DU_LIEU | NHAP_DU_LIEU | IN | TAI_XUONG | XEM | KHAC
    PhanHe              NVARCHAR(50)      NOT NULL,
    -- DAILY | KHACHHANG | HOPDONG | HOAHONG | DOISOAT | TRANGDICH
    -- SANPHAM | NGUOIDUNG | CAUHINH | BAOCAO | THANHTOAN
    DoiTuong            NVARCHAR(100)     NULL,
    MaDoiTuong          NVARCHAR(100)     NULL,
    MoTaHanhDong        NVARCHAR(500)     NULL,
    DuLieuTruoc         NVARCHAR(MAX)     NULL,  -- JSON
    DuLieuSau           NVARCHAR(MAX)     NULL,  -- JSON
    DiaChiIP            NVARCHAR(50)      NULL,
    ThongTinTrinhDuyet  NVARCHAR(500)     NULL,
    ThietBi             NVARCHAR(100)     NULL,
    UrlTrang            NVARCHAR(500)     NULL,
    ThanhCong           BIT               NOT NULL DEFAULT 1,
    LoiNeuCo            NVARCHAR(500)     NULL,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_NhatKyHoatDong PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: NhatKyThayDoiDuLieu
-- CDC (Change Data Capture) - ghi lai moi thay doi du lieu quan trong
-- ============================================================
CREATE TABLE NhatKyThayDoiDuLieu (
    Ma                  BIGINT            NOT NULL IDENTITY(1,1),
    MaChiNhanh          UNIQUEIDENTIFIER  NOT NULL,
    TenBang             NVARCHAR(100)     NOT NULL,
    MaBanGhi            NVARCHAR(100)     NOT NULL,
    LoaiThayDoi         NVARCHAR(10)      NOT NULL,
    -- THEM | SUA | XOA
    TenCot              NVARCHAR(100)     NULL,
    GiaTriCu            NVARCHAR(MAX)     NULL,
    GiaTriMoi           NVARCHAR(MAX)     NULL,
    NguoiThayDoi        UNIQUEIDENTIFIER  NULL,
    NgayThayDoi         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    MaPhien             NVARCHAR(100)     NULL,
    CONSTRAINT PK_NhatKyThayDoiDuLieu PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- INDEX cho NhatKyHoatDong
-- ============================================================
CREATE NONCLUSTERED INDEX IX_NhatKyHoatDong_NgayTao
ON NhatKyHoatDong (NgayTao DESC)
INCLUDE (MaNguoiDung, LoaiHanhDong, PhanHe);
GO

CREATE NONCLUSTERED INDEX IX_NhatKyHoatDong_NguoiDung
ON NhatKyHoatDong (MaNguoiDung, NgayTao DESC)
INCLUDE (LoaiHanhDong, PhanHe, DoiTuong);
GO

CREATE NONCLUSTERED INDEX IX_NhatKyThayDoiDuLieu_Bang
ON NhatKyThayDoiDuLieu (TenBang, MaBanGhi, NgayThayDoi DESC);
GO
