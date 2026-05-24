-- ============================================================
-- TWL PORTAL 360LIFE - TENANT DATABASE
-- FILE: 01_BranchOrg.sql
-- ============================================================
GO

CREATE TABLE ThongTinChiNhanh (
    Id                       UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId                 UNIQUEIDENTIFIER  NOT NULL,
    MaChiNhanh               NVARCHAR(50)      NOT NULL,
    TenChiNhanh              NVARCHAR(255)     NOT NULL,
    LoaiChiNhanh             NVARCHAR(30)      NOT NULL,
    MucTieuDoanhThuThang     DECIMAL(18,2)     NULL,
    MucTieuDoanhThuNam       DECIMAL(18,2)     NULL,
    MucTieuHopDongThang      INT               NULL,
    MucTieuDaiLyThang        INT               NULL,
    TongDaiLy                INT               NOT NULL DEFAULT 0,
    DaiLyHoatDong            INT               NOT NULL DEFAULT 0,
    TongKhachHang            INT               NOT NULL DEFAULT 0,
    DoanhThuThangHienTai     DECIMAL(18,2)     NOT NULL DEFAULT 0,
    DoanhThuNamHienTai       DECIMAL(18,2)     NOT NULL DEFAULT 0,
    LanCapNhatThongKeCuoi    DATETIME2         NULL,
    NgayTao                  DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat              DATETIME2         NULL,
    CONSTRAINT PK_ThongTinChiNhanh PRIMARY KEY (Id)
);
GO

CREATE TABLE DonViToChuc (
    Id                   UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId             UNIQUEIDENTIFIER  NOT NULL,
    MaDonVi              NVARCHAR(50)      NOT NULL,
    TenDonVi             NVARCHAR(255)     NOT NULL,
    LoaiDonVi            NVARCHAR(30)      NOT NULL,
    DonViChaId           UNIQUEIDENTIFIER  NULL REFERENCES DonViToChuc(Id),
    DuongDanPhanCap      NVARCHAR(500)     NULL,
    CapPhanCap           INT               NOT NULL DEFAULT 1,
    TruongDonViId        UNIQUEIDENTIFIER  NULL,
    MoTa                 NVARCHAR(500)     NULL,
    MucTieuThang         DECIMAL(18,2)     NULL,
    MucTieuNam           DECIMAL(18,2)     NULL,
    ConHoatDong          BIT               NOT NULL DEFAULT 1,
    NgayTao              DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat          DATETIME2         NULL,
    CONSTRAINT PK_DonViToChuc PRIMARY KEY (Id),
    CONSTRAINT UQ_DonViToChuc_MaDonVi UNIQUE (DoiTacId, MaDonVi)
);
GO

CREATE TABLE CapBacDaiLy (
    Id                       UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId                 UNIQUEIDENTIFIER  NOT NULL,
    MaCapBac                 NVARCHAR(50)      NOT NULL,
    TenCapBac                NVARCHAR(100)     NOT NULL,
    CapDo                    INT               NOT NULL,
    DoanhThuThangToiThieu    DECIMAL(18,2)     NULL,
    SoHopDongThangToiThieu   INT               NULL,
    SoTuyenDuoiToiThieu      INT               NULL,
    SoThangHoatDongToiThieu  INT               NULL,
    TyLeTrucTiepMacDinh      DECIMAL(5,4)      NULL,
    TyLeGianTiepMacDinh      DECIMAL(5,4)      NULL,
    UrlBieuTuongHuy          NVARCHAR(500)     NULL,
    MauHuy                   NVARCHAR(20)      NULL,
    MoTa                     NVARCHAR(500)     NULL,
    ThuTu                    INT               NOT NULL DEFAULT 0,
    ConHoatDong              BIT               NOT NULL DEFAULT 1,
    NgayTao                  DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_CapBacDaiLy PRIMARY KEY (Id),
    CONSTRAINT UQ_CapBacDaiLy_MaCapBac UNIQUE (DoiTacId, MaCapBac)
);
GO

CREATE TABLE CauHinhHoaHong (
    Id                    UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId              UNIQUEIDENTIFIER  NOT NULL,
    SanPhamGocId          UNIQUEIDENTIFIER  NOT NULL,
    NhaCungCapId          UNIQUEIDENTIFIER  NOT NULL,
    CapBacId              UNIQUEIDENTIFIER  NULL REFERENCES CapBacDaiLy(Id),
    LoaiHoaHong           NVARCHAR(20)      NOT NULL,
    TyLeCoSo              DECIMAL(6,5)      NOT NULL,
    BatBacThang           BIT               NOT NULL DEFAULT 0,
    CauHinhBacThang       NVARCHAR(MAX)     NULL,
    BatChienDich          BIT               NOT NULL DEFAULT 0,
    CauHinhChienDich      NVARCHAR(MAX)     NULL,
    TyLeGianTiepCap1      DECIMAL(6,5)      NULL,
    TyLeGianTiepCap2      DECIMAL(6,5)      NULL,
    TyLeGianTiepCap3      DECIMAL(6,5)      NULL,
    TyLeToiDa             DECIMAL(6,5)      NULL,
    TyLeToiThieu          DECIMAL(6,5)      NULL,
    HieuLucTu             DATE              NOT NULL,
    HieuLucDen            DATE              NULL,
    ConHoatDong           BIT               NOT NULL DEFAULT 1,
    NguoiDuyet            UNIQUEIDENTIFIER  NULL,
    NgayDuyet             DATETIME2         NULL,
    GhiChu                NVARCHAR(500)     NULL,
    NgayTao               DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao              UNIQUEIDENTIFIER  NULL,
    NgayCapNhat           DATETIME2         NULL,
    CONSTRAINT PK_CauHinhHoaHong PRIMARY KEY (Id)
);
GO
