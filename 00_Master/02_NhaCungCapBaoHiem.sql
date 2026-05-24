-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHINH (MASTER)
-- FILE: 02_NhaCungCapBaoHiem.sql
-- MO TA: NhaCungCapBaoHiem, TaiKhoanNganHangNCC, TyLeHoaHongNCC
-- ============================================================
USE TWL_MASTER;
GO

-- ============================================================
-- BANG: NhaCungCapBaoHiem
-- Luu thong tin cac cong ty bao hiem doi tac
-- ============================================================
CREATE TABLE NhaCungCapBaoHiem (
    Ma                          UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaNCC                       NVARCHAR(50)      NOT NULL,
    -- BAOVIET | LIBERTY | BSH | PTI | MIC | BIC | PVI | ABIC
    TenNCC                      NVARCHAR(255)     NOT NULL,
    TenNCCTiengAnh              NVARCHAR(255)     NULL,
    TenVietTat                  NVARCHAR(50)      NULL,
    LoaiNCC                     NVARCHAR(30)      NOT NULL DEFAULT 'CONGTY_BAOHIEM',
    MaSoThue                    NVARCHAR(20)      NULL,
    SoGiayPhep                  NVARCHAR(100)     NULL,
    NgayHetHanGP                DATE              NULL,
    DiaChiTruSo                 NVARCHAR(500)     NULL,
    Website                     NVARCHAR(255)     NULL,
    SdtTongDai                  NVARCHAR(20)      NULL,
    SdtBoiThuong                NVARCHAR(20)      NULL,
    EmailChung                  NVARCHAR(255)     NULL,
    EmailDoiSoat                NVARCHAR(255)     NULL,
    TenNguoiLienHe              NVARCHAR(255)     NULL,
    SdtNguoiLienHe              NVARCHAR(20)      NULL,
    EmailNguoiLienHe            NVARCHAR(255)     NULL,
    -- Tich hop API
    UrlGocAPI                   NVARCHAR(500)     NULL,
    LoaiXacThucAPI              NVARCHAR(20)      NULL,
    -- BASIC | BEARER | APIKEY | OAUTH2
    ThongTinXacThucMaHoa        NVARCHAR(MAX)     NULL,
    PhienBanAPI                 NVARCHAR(20)      NULL,
    CoBaoGiaThucTe              BIT               NOT NULL DEFAULT 0,
    CoPhatHanhTuDong            BIT               NOT NULL DEFAULT 0,
    ThoiGianCho_Giay            INT               NOT NULL DEFAULT 30,
    SoLanThuLai                 INT               NOT NULL DEFAULT 3,
    -- Hop dong dai ly
    SoHopDongDaiLy              NVARCHAR(100)     NULL,
    NgayHopDong                 DATE              NULL,
    NgayHetHanHD                DATE              NULL,
    UrlFileHopDong              NVARCHAR(500)     NULL,
    TyLeHoaHongMacDinh          DECIMAL(5,4)      NULL,
    UrlLogo                     NVARCHAR(500)     NULL,
    MauThuongHieu               NVARCHAR(20)      NULL,
    DangHoatDong                BIT               NOT NULL DEFAULT 1,
    ThuTuHienThi                INT               NOT NULL DEFAULT 0,
    GhiChu                      NVARCHAR(MAX)     NULL,
    NgayTao                     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat                 DATETIME2         NULL,
    CONSTRAINT PK_NhaCungCapBaoHiem PRIMARY KEY (Ma),
    CONSTRAINT UQ_NhaCungCapBaoHiem_MaNCC UNIQUE (MaNCC)
);
GO

-- ============================================================
-- BANG: TaiKhoanNganHangNCC
-- Tai khoan ngan hang cua NCC de nhan phi / tra hoa hong
-- ============================================================
CREATE TABLE TaiKhoanNganHangNCC (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaNCC           UNIQUEIDENTIFIER  NOT NULL REFERENCES NhaCungCapBaoHiem(Ma),
    LoaiTaiKhoan    NVARCHAR(20)      NOT NULL,
    -- NHAN_PHI | TRA_HOAHONG
    TenNganHang     NVARCHAR(100)     NOT NULL,
    MaNganHang      NVARCHAR(20)      NULL,
    ChiNhanhNH      NVARCHAR(200)     NULL,
    SoTaiKhoan      NVARCHAR(50)      NOT NULL,
    TenTaiKhoan     NVARCHAR(255)     NOT NULL,
    LaMacDinh       BIT               NOT NULL DEFAULT 0,
    DangHoatDong    BIT               NOT NULL DEFAULT 1,
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_TaiKhoanNganHangNCC PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: TyLeHoaHongNCC
-- Ty le hoa hong ma NCC tra cho TWL theo tung san pham
-- ============================================================
CREATE TABLE TyLeHoaHongNCC (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaNCC           UNIQUEIDENTIFIER  NOT NULL REFERENCES NhaCungCapBaoHiem(Ma),
    MaSanPhamGoc    UNIQUEIDENTIFIER  NOT NULL,
    TyLeHoaHong     DECIMAL(5,4)      NOT NULL,
    TyLeThuong      DECIMAL(5,4)      NULL,
    DieuKienThuong  NVARCHAR(MAX)     NULL,
    HieuLucTu       DATE              NOT NULL,
    HieuLucDen      DATE              NULL,
    SoHopDong       NVARCHAR(100)     NULL,
    GhiChu          NVARCHAR(500)     NULL,
    DangHoatDong    BIT               NOT NULL DEFAULT 1,
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao        UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_TyLeHoaHongNCC PRIMARY KEY (Ma)
);
GO
