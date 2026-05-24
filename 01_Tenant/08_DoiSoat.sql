-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHI NHANH (TENANT)
-- FILE: 08_DoiSoat.sql
-- MO TA: KyDoiSoat, ChiTietDoiSoat
-- ============================================================
GO

-- ============================================================
-- BANG: KyDoiSoat
-- Quan ly tung ky doi soat voi NCC
-- ============================================================
CREATE TABLE KyDoiSoat (
    Ma                          UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh                  UNIQUEIDENTIFIER  NOT NULL,
    MaKyDoiSoat                 NVARCHAR(20)      NOT NULL,
    NamKy                       INT               NOT NULL,
    ThangKy                     INT               NOT NULL,
    NgayBatDauKy                DATE              NOT NULL,
    NgayKetThucKy               DATE              NOT NULL,
    MaNCC                       UNIQUEIDENTIFIER  NOT NULL,
    TrangThai                   NVARCHAR(20)      NOT NULL DEFAULT 'DANG_MO',
    -- DANG_MO | DANG_DOISOAT | DA_GUI_NCC | NCC_DA_XAC_NHAN | DA_CHOT
    TongHDPortal                INT               NOT NULL DEFAULT 0,
    TongHDNCC                   INT               NOT NULL DEFAULT 0,
    TongPhiPortal               DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongPhiNCC                  DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongHHPortal                DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongHHNCC                   DECIMAL(18,2)     NOT NULL DEFAULT 0,
    ChenhLechHD                 INT               NOT NULL DEFAULT 0,
    ChenhLechPhi                DECIMAL(18,2)     NOT NULL DEFAULT 0,
    ChenhLechHH                 DECIMAL(18,2)     NOT NULL DEFAULT 0,
    NgayGuiNCC                  DATETIME2         NULL,
    NguoiGuiNCC                 UNIQUEIDENTIFIER  NULL,
    NgayNCCPhanHoi              DATETIME2         NULL,
    GhiChuNCCPhanHoi            NVARCHAR(500)     NULL,
    NgayChot                    DATETIME2         NULL,
    NguoiChot                   UNIQUEIDENTIFIER  NULL,
    UrlFileXuat                 NVARCHAR(500)     NULL,
    UrlFileNCCNhap              NVARCHAR(500)     NULL,
    GhiChu                      NVARCHAR(MAX)     NULL,
    NgayTao                     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat                 DATETIME2         NULL,
    CONSTRAINT PK_KyDoiSoat PRIMARY KEY (Ma),
    CONSTRAINT UQ_KyDoiSoat UNIQUE (MaChiNhanh, MaKyDoiSoat, MaNCC)
);
GO

-- ============================================================
-- BANG: ChiTietDoiSoat
-- Doi chieu tung hop dong giua Portal va NCC
-- ============================================================
CREATE TABLE ChiTietDoiSoat (
    Ma                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaKyDoiSoat             UNIQUEIDENTIFIER  NOT NULL REFERENCES KyDoiSoat(Ma),
    MaChiNhanh              UNIQUEIDENTIFIER  NOT NULL,
    MaHopDong               UNIQUEIDENTIFIER  NULL REFERENCES HopDong(Ma),
    SoHopDongPortal         NVARCHAR(100)     NULL,
    SoHopDongNCC            NVARCHAR(100)     NULL,
    TrangThaiPortal         NVARCHAR(30)      NULL,
    TrangThaiNCC            NVARCHAR(30)      NULL,
    PhiPortal               DECIMAL(18,2)     NULL,
    PhiNCC                  DECIMAL(18,2)     NULL,
    HoaHongPortal           DECIMAL(18,2)     NULL,
    HoaHongNCC              DECIMAL(18,2)     NULL,
    TrangThaiKhop           NVARCHAR(20)      NOT NULL DEFAULT 'CHUA_KHOP',
    -- CHUA_KHOP | DA_KHOP | LECH | CHI_CO_PORTAL | CHI_CO_NCC
    LoaiLech                NVARCHAR(30)      NULL,
    -- LECH_PHI | LECH_TRANGTHAI | THIEU_HD | THUA_HD | KHAC
    GhiChuLech              NVARCHAR(500)     NULL,
    NgayXuLy                DATETIME2         NULL,
    NguoiXuLy               UNIQUEIDENTIFIER  NULL,
    CachXuLy                NVARCHAR(30)      NULL,
    -- BO_QUA | DIEU_CHINH | YEU_CAU_NCC | THEO_NCC
    GhiChuXuLy              NVARCHAR(500)     NULL,
    DuLieuGocNCC            NVARCHAR(MAX)     NULL,  -- JSON raw data
    NgayTao                 DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_ChiTietDoiSoat PRIMARY KEY (Ma)
);
GO
