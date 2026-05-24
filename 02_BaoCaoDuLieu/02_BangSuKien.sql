-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - KHO DU LIEU BAO CAO
-- FILE: 02_BangSuKien.sql
-- MO TA: Cac bang su kien (Fact) cho bao cao
-- ============================================================
USE TWL_BAO_CAO;
GO

-- ============================================================
-- BANG: SKDoanhThuNgay
-- Su kien doanh thu tong hop hang ngay
-- ============================================================
CREATE TABLE SKDoanhThuNgay (
    Ma                      BIGINT            NOT NULL IDENTITY(1,1),
    MaKhoaThoiGian          INT               NOT NULL REFERENCES ChieuThoiGian(MaKhoaThoiGian),
    MaKhoaChiNhanh          UNIQUEIDENTIFIER  NOT NULL REFERENCES ChieuChiNhanh(MaKhoaChiNhanh),
    MaKhoaDaiLy             UNIQUEIDENTIFIER  NOT NULL REFERENCES ChieuDaiLy(MaKhoaDaiLy),
    MaKhoaSanPham           UNIQUEIDENTIFIER  NOT NULL REFERENCES ChieuSanPham(MaKhoaSanPham),
    MaKhoaNCC               UNIQUEIDENTIFIER  NOT NULL REFERENCES ChieuNCC(MaKhoaNCC),
    SoHopDongMoi            INT               NOT NULL DEFAULT 0,
    TongPhiBaoHiem          DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongGiamGia             DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongPhiThucThu          DECIMAL(18,2)     NOT NULL DEFAULT 0,
    SoTienBaoHiem           DECIMAL(18,2)     NOT NULL DEFAULT 0,
    SoHopDongHuy            INT               NOT NULL DEFAULT 0,
    TongHoanTien            DECIMAL(18,2)     NOT NULL DEFAULT 0,
    NgayCapNhat             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_SKDoanhThuNgay PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: SKHoaHongThang
-- Su kien hoa hong tong hop hang thang
-- ============================================================
CREATE TABLE SKHoaHongThang (
    Ma                      BIGINT            NOT NULL IDENTITY(1,1),
    Nam                     INT               NOT NULL,
    Thang                   INT               NOT NULL,
    MaKhoaChiNhanh          UNIQUEIDENTIFIER  NOT NULL REFERENCES ChieuChiNhanh(MaKhoaChiNhanh),
    MaKhoaDaiLy             UNIQUEIDENTIFIER  NOT NULL REFERENCES ChieuDaiLy(MaKhoaDaiLy),
    MaKhoaSanPham           UNIQUEIDENTIFIER  NULL REFERENCES ChieuSanPham(MaKhoaSanPham),
    MaKhoaNCC               UNIQUEIDENTIFIER  NULL REFERENCES ChieuNCC(MaKhoaNCC),
    SoHopDong               INT               NOT NULL DEFAULT 0,
    TongPhiGoc              DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongTrucTiep         DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongGianTiep         DECIMAL(18,2)     NOT NULL DEFAULT 0,
    ThuongKy                DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongHoaHongGop          DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongThue                DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongHoaHongRong         DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TrangThaiChiTra         NVARCHAR(20)      NULL,
    NgayCapNhat             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_SKHoaHongThang PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: SKLeadNgay
-- Su kien lead/pipeline hang ngay
-- ============================================================
CREATE TABLE SKLeadNgay (
    Ma                      BIGINT            NOT NULL IDENTITY(1,1),
    MaKhoaThoiGian          INT               NOT NULL REFERENCES ChieuThoiGian(MaKhoaThoiGian),
    MaKhoaChiNhanh          UNIQUEIDENTIFIER  NOT NULL REFERENCES ChieuChiNhanh(MaKhoaChiNhanh),
    MaKhoaDaiLy             UNIQUEIDENTIFIER  NULL REFERENCES ChieuDaiLy(MaKhoaDaiLy),
    NguonLead               NVARCHAR(50)      NULL,
    SoLeadMoi               INT               NOT NULL DEFAULT 0,
    SoLeadDaLienHe          INT               NOT NULL DEFAULT 0,
    SoLeadDangTuVan         INT               NOT NULL DEFAULT 0,
    SoLeadDaBaoGia          INT               NOT NULL DEFAULT 0,
    SoLeadDaChot            INT               NOT NULL DEFAULT 0,
    SoLeadThatBai           INT               NOT NULL DEFAULT 0,
    TyLeChuyenDoi           DECIMAL(5,4)      NULL,
    NgayCapNhat             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_SKLeadNgay PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: SKDoiSoatThang
-- Su kien doi soat voi NCC hang thang
-- ============================================================
CREATE TABLE SKDoiSoatThang (
    Ma                      BIGINT            NOT NULL IDENTITY(1,1),
    Nam                     INT               NOT NULL,
    Thang                   INT               NOT NULL,
    MaKhoaChiNhanh          UNIQUEIDENTIFIER  NOT NULL REFERENCES ChieuChiNhanh(MaKhoaChiNhanh),
    MaKhoaNCC               UNIQUEIDENTIFIER  NOT NULL REFERENCES ChieuNCC(MaKhoaNCC),
    TongHDPortal            INT               NOT NULL DEFAULT 0,
    TongHDNCC               INT               NOT NULL DEFAULT 0,
    TongPhiPortal           DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongPhiNCC              DECIMAL(18,2)     NOT NULL DEFAULT 0,
    SoHDKhop                INT               NOT NULL DEFAULT 0,
    SoHDLech                INT               NOT NULL DEFAULT 0,
    SoTienLech              DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TrangThaiDoiSoat        NVARCHAR(20)      NULL,
    NgayCapNhat             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_SKDoiSoatThang PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: SKChupNhanhHangNgay
-- Snapshot thong ke tong hop cuoi ngay
-- ============================================================
CREATE TABLE SKChupNhanhHangNgay (
    Ma                      BIGINT            NOT NULL IDENTITY(1,1),
    MaKhoaThoiGian          INT               NOT NULL REFERENCES ChieuThoiGian(MaKhoaThoiGian),
    MaKhoaChiNhanh          UNIQUEIDENTIFIER  NOT NULL REFERENCES ChieuChiNhanh(MaKhoaChiNhanh),
    TongDaiLyHoatDong       INT               NOT NULL DEFAULT 0,
    TongKhachHang           INT               NOT NULL DEFAULT 0,
    TongHopDongHieuLuc      INT               NOT NULL DEFAULT 0,
    TongDoanhThuLuyKe       DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongHoaHongChuaTra      DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongLeadChuaXuLy        INT               NOT NULL DEFAULT 0,
    TongHDSapHetHan30Ngay   INT               NOT NULL DEFAULT 0,
    NgayCapNhat             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_SKChupNhanhHangNgay PRIMARY KEY (Ma)
);
GO
