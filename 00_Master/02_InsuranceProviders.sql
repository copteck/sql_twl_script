-- ============================================================
-- TWL PORTAL 360LIFE - MASTER DATABASE
-- FILE: 02_InsuranceProviders.sql
-- DESC: InsuranceProviders, ProviderBankAccounts, CommissionProviderRate
-- ============================================================
USE TWL_MASTER;
GO

CREATE TABLE NhaCungCapBaoHiem (
    Id                       UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaNCC                    NVARCHAR(50)      NOT NULL,  -- BAOVIET|LIBERTY|BSH|PTI|MIC|BIC
    TenNCC                   NVARCHAR(255)     NOT NULL,
    TenNCCEn                 NVARCHAR(255)     NULL,
    TenVietTat               NVARCHAR(50)      NULL,
    LoaiNCC                  NVARCHAR(30)      NOT NULL DEFAULT 'INSURANCE_COMPANY',
    MaSoThue                 NVARCHAR(20)      NULL,
    SoGiayPhep               NVARCHAR(100)     NULL,
    NgayHetHanGP             DATE              NULL,
    DiaChiTruSo              NVARCHAR(500)     NULL,
    Website                  NVARCHAR(255)     NULL,
    SdtHotline               NVARCHAR(20)      NULL,
    SdtBoiThuong             NVARCHAR(20)      NULL,
    EmailChung               NVARCHAR(255)     NULL,
    EmailDoiSoat             NVARCHAR(255)     NULL,
    TenNguoiLienHe           NVARCHAR(255)     NULL,
    SdtNguoiLienHe           NVARCHAR(20)      NULL,
    EmailNguoiLienHe         NVARCHAR(255)     NULL,
    -- API Integration
    UrlGocApi                NVARCHAR(500)     NULL,
    LoaiXacThucApi           NVARCHAR(20)      NULL,  -- BASIC|BEARER|APIKEY|OAUTH2
    ThongTinXacThucMaHoa     NVARCHAR(MAX)     NULL,
    PhienBanApi              NVARCHAR(20)      NULL,
    CoBaoGiaThucTe           BIT               NOT NULL DEFAULT 0,
    CoPhatHanhTuDong         BIT               NOT NULL DEFAULT 0,
    ThoiGianChoApi           INT               NOT NULL DEFAULT 30,
    SoLanThuLaiApi           INT               NOT NULL DEFAULT 3,
    -- Agency Contract
    SoHopDongDaiLy           NVARCHAR(100)     NULL,
    NgayHopDongDaiLy         DATE              NULL,
    NgayHetHanHDDL           DATE              NULL,
    UrlFileHopDongDL         NVARCHAR(500)     NULL,
    TyLeHoaHongMacDinh       DECIMAL(5,4)      NULL,
    UrlLogo                  NVARCHAR(500)     NULL,
    MauThuongHieu            NVARCHAR(20)      NULL,
    ConHoatDong              BIT               NOT NULL DEFAULT 1,
    ThuTu                    INT               NOT NULL DEFAULT 0,
    GhiChu                   NVARCHAR(MAX)     NULL,
    NgayTao                  DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat              DATETIME2         NULL,
    CONSTRAINT PK_NhaCungCapBaoHiem PRIMARY KEY (Id),
    CONSTRAINT UQ_NhaCungCapBaoHiem_MaNCC UNIQUE (MaNCC)
);
GO

CREATE TABLE TaiKhoanNganHangNCC (
    Id                UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    NhaCungCapId      UNIQUEIDENTIFIER  NOT NULL REFERENCES NhaCungCapBaoHiem(Id),
    LoaiTaiKhoan      NVARCHAR(20)      NOT NULL,  -- RECEIVE_PREMIUM|PAY_COMMISSION
    TenNganHang       NVARCHAR(100)     NOT NULL,
    MaNganHang        NVARCHAR(20)      NULL,
    ChiNhanhNganHang  NVARCHAR(200)     NULL,
    SoTaiKhoan        NVARCHAR(50)      NOT NULL,
    TenTaiKhoan       NVARCHAR(255)     NOT NULL,
    LaMacDinh         BIT               NOT NULL DEFAULT 0,
    ConHoatDong       BIT               NOT NULL DEFAULT 1,
    NgayTao           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_TaiKhoanNganHangNCC PRIMARY KEY (Id)
);
GO

CREATE TABLE TyLeHoaHongNCC (
    Id              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    NhaCungCapId    UNIQUEIDENTIFIER  NOT NULL REFERENCES NhaCungCapBaoHiem(Id),
    SanPhamGocId    UNIQUEIDENTIFIER  NOT NULL,
    TyLeHoaHong     DECIMAL(5,4)      NOT NULL,
    TyLeThuong      DECIMAL(5,4)      NULL,
    DieuKienThuong  NVARCHAR(MAX)     NULL,
    HieuLucTu       DATE              NOT NULL,
    HieuLucDen      DATE              NULL,
    SoThamChieuHD   NVARCHAR(100)     NULL,
    GhiChu          NVARCHAR(500)     NULL,
    ConHoatDong     BIT               NOT NULL DEFAULT 1,
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao        UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_TyLeHoaHongNCC PRIMARY KEY (Id)
);
GO
