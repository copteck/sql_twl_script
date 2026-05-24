-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHI NHANH (TENANT)
-- FILE: 05_HopDong.sql
-- MO TA: HopDong, LichSuTrangThaiHD, TaiLieuHopDong
-- ============================================================
GO

-- ============================================================
-- BANG: HopDong
-- Hop dong bao hiem - bang chinh quan trong nhat
-- ============================================================
CREATE TABLE HopDong (
    Ma                          UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh                  UNIQUEIDENTIFIER  NOT NULL,
    SoHopDong                   NVARCHAR(100)     NOT NULL,
    SoHopDongNCC                NVARCHAR(100)     NULL,
    MaDoiSoat                   NVARCHAR(100)     NULL,
    MaBaoGia                    UNIQUEIDENTIFIER  NULL REFERENCES BaoGia(Ma),
    MaKeHoach                   UNIQUEIDENTIFIER  NULL REFERENCES KeHoachBanHang(Ma),
    MaSanPhamGoc                UNIQUEIDENTIFIER  NOT NULL,
    MaGoiSanPham                UNIQUEIDENTIFIER  NULL,
    MaNCC                       UNIQUEIDENTIFIER  NOT NULL,
    LoaiBaoHiem                 NVARCHAR(50)      NOT NULL,
    MaKhachHang                 UNIQUEIDENTIFIER  NOT NULL REFERENCES KhachHang(Ma),
    TenNguoiDuocBH              NVARCHAR(255)     NULL,
    CMNDNguoiDuocBH             NVARCHAR(20)      NULL,
    NgaySinhNguoiDuocBH         DATE              NULL,
    SdtNguoiDuocBH              NVARCHAR(20)      NULL,
    QuanHeNguoiDuocBH           NVARCHAR(50)      NULL,
    -- BAN_THAN | VO_CHONG | CON | CHA_ME | ANH_CHI_EM | KHAC
    DuLieuDoiTuongBH            NVARCHAR(MAX)     NOT NULL,  -- JSON
    NgayBatDau                  DATE              NOT NULL,
    NgayKetThuc                 DATE              NOT NULL,
    SoNgayHieuLuc               INT               NOT NULL,
    PhiGoc                      DECIMAL(18,2)     NOT NULL,
    SoTienGiamGia               DECIMAL(18,2)     NOT NULL DEFAULT 0,
    SoTienPhuPhi                DECIMAL(18,2)     NOT NULL DEFAULT 0,
    PhiSauCung                  DECIMAL(18,2)     NOT NULL,
    SoKyTraGop                  INT               NOT NULL DEFAULT 1,
    SoTienMoiKy                 DECIMAL(18,2)     NULL,
    SoTienBaoHiem               DECIMAL(18,2)     NULL,
    KenhBan                     NVARCHAR(30)      NOT NULL,
    -- TRUC_TIEP | WEBSITE | LANDING_PAGE | ZALO | FACEBOOK | GIOI_THIEU
    MaDaiLy                     UNIQUEIDENTIFIER  NOT NULL REFERENCES DaiLy(Ma),
    MaTrangDich                 UNIQUEIDENTIFIER  NULL,
    TrangThaiHopDong            NVARCHAR(30)      NOT NULL DEFAULT 'NHAP',
    -- NHAP | CHO_THANH_TOAN | DA_THANH_TOAN | CHO_NCC_DUYET
    -- NCC_DA_DUYET | NCC_TU_CHOI | HIEU_LUC | HET_HAN | DA_HUY
    NgayDoiTrangThaiHD          DATETIME2         NULL,
    NguoiDoiTrangThaiHD         UNIQUEIDENTIFIER  NULL,
    TrangThaiThanhToan          NVARCHAR(20)      NOT NULL DEFAULT 'CHUA_THANHTOAN',
    -- CHUA_THANHTOAN | THANHTOAN_MOTPHAN | DA_THANHTOAN | HOAN_TIEN
    TongDaThanhToan             DECIMAL(18,2)     NOT NULL DEFAULT 0,
    SoTienConLai                DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TrangThaiNCC                NVARCHAR(20)      NULL,
    -- CHUA_GUI | DA_GUI | NCC_XAC_NHAN | NCC_TU_CHOI
    NgayGuiNCC                  DATETIME2         NULL,
    NgayNCCXacNhan              DATETIME2         NULL,
    NgayNCCTuChoi               DATETIME2         NULL,
    LyDoNCCTuChoi               NVARCHAR(500)     NULL,
    PhanHoiNCC                  NVARCHAR(MAX)     NULL,
    TrangThaiDoiSoat            NVARCHAR(30)      NULL,
    -- CHUA_DOISOAT | DANG_DOISOAT | DA_KHOP | LECH
    KyDoiSoat                   NVARCHAR(10)      NULL,
    NgayDoiSoat                 DATETIME2         NULL,
    TrangThaiHoaHong            NVARCHAR(20)      NOT NULL DEFAULT 'CHO_XU_LY',
    -- CHO_XU_LY | DA_TINH | DA_DUYET | DA_CHI_TRA | DA_HUY
    NgayTraHoaHong              DATETIME2         NULL,
    MaLoHoaHong                 UNIQUEIDENTIFIER  NULL,
    TrangThaiTaiTuc             NVARCHAR(20)      NULL,
    -- CHUA_DEN_HAN | SAP_HET_HAN | DA_HET_HAN | DA_TAI_TUC | TU_CHOI_TAI_TUC
    MaHopDongCu                 UNIQUEIDENTIFIER  NULL REFERENCES HopDong(Ma),
    MaHopDongTaiTuc             UNIQUEIDENTIFIER  NULL REFERENCES HopDong(Ma),
    NgayGuiNhacTaiTuc           DATETIME2         NULL,
    SoLanNhacTaiTuc             INT               NOT NULL DEFAULT 0,
    UrlHopDongPDF               NVARCHAR(500)     NULL,
    UrlGiayChungNhan            NVARCHAR(500)     NULL,
    UrlHoaDon                   NVARCHAR(500)     NULL,
    NgayHuy                     DATETIME2         NULL,
    LyDoHuy                     NVARCHAR(50)      NULL,
    GhiChuHuy                   NVARCHAR(500)     NULL,
    NguoiHuy                    UNIQUEIDENTIFIER  NULL,
    SoTienHoanTra               DECIMAL(18,2)     NULL,
    GhiChu                      NVARCHAR(MAX)     NULL,
    GhiChuNoiBo                 NVARCHAR(MAX)     NULL,
    NhanGan                     NVARCHAR(500)     NULL,
    NgayTao                     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao                    UNIQUEIDENTIFIER  NULL,
    NgayCapNhat                 DATETIME2         NULL,
    NguoiCapNhat                UNIQUEIDENTIFIER  NULL,
    DaXoa                       BIT               NOT NULL DEFAULT 0,
    CONSTRAINT PK_HopDong PRIMARY KEY (Ma),
    CONSTRAINT UQ_HopDong_SoHD UNIQUE (MaChiNhanh, SoHopDong)
);
GO

-- ============================================================
-- BANG: LichSuTrangThaiHopDong
-- Ghi nhan moi thay doi trang thai cua hop dong
-- ============================================================
CREATE TABLE LichSuTrangThaiHopDong (
    Ma              BIGINT            NOT NULL IDENTITY(1,1),
    MaHopDong       UNIQUEIDENTIFIER  NOT NULL REFERENCES HopDong(Ma),
    MaChiNhanh      UNIQUEIDENTIFIER  NOT NULL,
    TrangThaiCu     NVARCHAR(30)      NULL,
    TrangThaiMoi    NVARCHAR(30)      NOT NULL,
    LyDoThayDoi     NVARCHAR(500)     NULL,
    NguoiThayDoi    UNIQUEIDENTIFIER  NULL,
    LoaiNguoiDoi    NVARCHAR(20)      NULL,
    -- NHAN_VIEN | HE_THONG | NCC | KHACH_HANG
    GhiChu          NVARCHAR(MAX)     NULL,
    NgayThayDoi     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_LichSuTrangThaiHopDong PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: TaiLieuHopDong
-- Cac tai lieu dinh kem theo hop dong
-- ============================================================
CREATE TABLE TaiLieuHopDong (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaHopDong       UNIQUEIDENTIFIER  NOT NULL REFERENCES HopDong(Ma),
    MaChiNhanh      UNIQUEIDENTIFIER  NOT NULL,
    LoaiTaiLieu     NVARCHAR(50)      NOT NULL,
    -- HOP_DONG | GIAY_CHUNG_NHAN | HOA_DON | CCCD | CAVET | KHAC
    TenTaiLieu      NVARCHAR(255)     NULL,
    UrlFile         NVARCHAR(500)     NOT NULL,
    KichThuocFile   BIGINT            NULL,
    LoaiFile        NVARCHAR(100)     NULL,
    NguonTaiLieu    NVARCHAR(20)      NULL,
    -- KHACH_HANG | DAI_LY | NCC | HE_THONG
    DaXacMinh       BIT               NOT NULL DEFAULT 0,
    NguoiTaiLen     UNIQUEIDENTIFIER  NULL,
    NgayTaiLen      DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    DangHoatDong    BIT               NOT NULL DEFAULT 1,
    CONSTRAINT PK_TaiLieuHopDong PRIMARY KEY (Ma)
);
GO
