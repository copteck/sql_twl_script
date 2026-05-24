-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHI NHANH (TENANT)
-- FILE: 01_ToChucChiNhanh.sql
-- MO TA: ThongTinChiNhanh, DonViToChuc, CapBacDaiLy, CauHinhHoaHong
-- ============================================================
GO

-- ============================================================
-- BANG: ThongTinChiNhanh
-- Thong tin tong quat cua chi nhanh trong DB rieng
-- ============================================================
CREATE TABLE ThongTinChiNhanh (
    Ma                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh              UNIQUEIDENTIFIER  NOT NULL,
    MaSoChiNhanh            NVARCHAR(50)      NOT NULL,
    TenChiNhanh             NVARCHAR(255)     NOT NULL,
    LoaiChiNhanh            NVARCHAR(30)      NOT NULL,
    MucTieuDoanhThuThang    DECIMAL(18,2)     NULL,
    MucTieuDoanhThuNam      DECIMAL(18,2)     NULL,
    MucTieuHopDongThang     INT               NULL,
    MucTieuDaiLyThang       INT               NULL,
    TongSoDaiLy             INT               NOT NULL DEFAULT 0,
    DaiLyDangHoatDong       INT               NOT NULL DEFAULT 0,
    TongSoKhachHang         INT               NOT NULL DEFAULT 0,
    DoanhThuThangHienTai    DECIMAL(18,2)     NOT NULL DEFAULT 0,
    DoanhThuNamHienTai      DECIMAL(18,2)     NOT NULL DEFAULT 0,
    LanCapNhatThongKe       DATETIME2         NULL,
    NgayTao                 DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat             DATETIME2         NULL,
    CONSTRAINT PK_ThongTinChiNhanh PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: DonViToChuc
-- Cay to chuc (phong/ban/nhom/doi) trong chi nhanh
-- ============================================================
CREATE TABLE DonViToChuc (
    Ma                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh          UNIQUEIDENTIFIER  NOT NULL,
    MaDonVi             NVARCHAR(50)      NOT NULL,
    TenDonVi            NVARCHAR(255)     NOT NULL,
    LoaiDonVi           NVARCHAR(30)      NOT NULL,
    -- PHONG | BAN | NHOM | DOI | VUNG
    MaDonViCha          UNIQUEIDENTIFIER  NULL REFERENCES DonViToChuc(Ma),
    DuongDanPhanCap     NVARCHAR(500)     NULL,
    CapPhanCap          INT               NOT NULL DEFAULT 1,
    MaDaiLyTruongNhom   UNIQUEIDENTIFIER  NULL,
    MoTa                NVARCHAR(500)     NULL,
    MucTieuThang        DECIMAL(18,2)     NULL,
    MucTieuNam          DECIMAL(18,2)     NULL,
    DangHoatDong        BIT               NOT NULL DEFAULT 1,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat         DATETIME2         NULL,
    CONSTRAINT PK_DonViToChuc PRIMARY KEY (Ma),
    CONSTRAINT UQ_DonViToChuc_MaDV UNIQUE (MaChiNhanh, MaDonVi)
);
GO

-- ============================================================
-- BANG: CapBacDaiLy
-- Cau hinh cac cap bac dai ly trong chi nhanh
-- ============================================================
CREATE TABLE CapBacDaiLy (
    Ma                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh              UNIQUEIDENTIFIER  NOT NULL,
    MaCapBac                NVARCHAR(50)      NOT NULL,
    TenCapBac               NVARCHAR(100)     NOT NULL,
    SoThuTuCap              INT               NOT NULL,
    DoanhThuToiThieuThang   DECIMAL(18,2)     NULL,
    SoHDToiThieuThang       INT               NULL,
    SoTuyenDuoiToiThieu     INT               NULL,
    SoThangHoatDongToiThieu INT               NULL,
    TyLeTrucTiepMacDinh     DECIMAL(5,4)      NULL,
    TyLeGianTiepMacDinh     DECIMAL(5,4)      NULL,
    UrlBieuTuongHuyHieu     NVARCHAR(500)     NULL,
    MauHuyHieu              NVARCHAR(20)      NULL,
    MoTa                    NVARCHAR(500)     NULL,
    ThuTuHienThi            INT               NOT NULL DEFAULT 0,
    DangHoatDong            BIT               NOT NULL DEFAULT 1,
    NgayTao                 DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_CapBacDaiLy PRIMARY KEY (Ma),
    CONSTRAINT UQ_CapBacDaiLy UNIQUE (MaChiNhanh, MaCapBac)
);
GO

-- ============================================================
-- BANG: CauHinhHoaHong
-- Cau hinh hoa hong theo san pham/NCC/cap bac tai chi nhanh
-- ============================================================
CREATE TABLE CauHinhHoaHong (
    Ma                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh              UNIQUEIDENTIFIER  NOT NULL,
    MaSanPhamGoc            UNIQUEIDENTIFIER  NOT NULL,
    MaNCC                   UNIQUEIDENTIFIER  NOT NULL,
    MaCapBac                UNIQUEIDENTIFIER  NULL REFERENCES CapBacDaiLy(Ma),
    LoaiHoaHong             NVARCHAR(20)      NOT NULL,
    -- TRUC_TIEP | GIAN_TIEP | THUONG_KY
    TyLeGoc                 DECIMAL(6,5)      NOT NULL,
    BacThangBatDau          BIT               NOT NULL DEFAULT 0,
    CauHinhBacThang         NVARCHAR(MAX)     NULL,
    ChienDichBatDau         BIT               NOT NULL DEFAULT 0,
    CauHinhChienDich        NVARCHAR(MAX)     NULL,
    TyLeGianTiepCap1        DECIMAL(6,5)      NULL,
    TyLeGianTiepCap2        DECIMAL(6,5)      NULL,
    TyLeGianTiepCap3        DECIMAL(6,5)      NULL,
    TyLeToiDa               DECIMAL(6,5)      NULL,
    TyLeToiThieu            DECIMAL(6,5)      NULL,
    HieuLucTu               DATE              NOT NULL,
    HieuLucDen              DATE              NULL,
    DangHoatDong            BIT               NOT NULL DEFAULT 1,
    NguoiDuyet              UNIQUEIDENTIFIER  NULL,
    NgayDuyet               DATETIME2         NULL,
    GhiChu                  NVARCHAR(500)     NULL,
    NgayTao                 DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao                UNIQUEIDENTIFIER  NULL,
    NgayCapNhat             DATETIME2         NULL,
    CONSTRAINT PK_CauHinhHoaHong PRIMARY KEY (Ma)
);
GO
