-- ============================================================
-- TWL PORTAL 360LIFE - TENANT DATABASE
-- FILE: 08_Reconciliation.sql
-- ============================================================
GO

CREATE TABLE KyDoiSoat (
    Id                UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId          UNIQUEIDENTIFIER  NOT NULL,
    MaKy              NVARCHAR(20)      NOT NULL,
    NamKy             INT               NOT NULL,
    ThangKy           INT               NOT NULL,
    NgayBatDauKy      DATE              NOT NULL,
    NgayKetThucKy     DATE              NOT NULL,
    NhaCungCapId      UNIQUEIDENTIFIER  NOT NULL,
    TrangThai         NVARCHAR(20)      NOT NULL DEFAULT 'OPEN',
    TongHDPortal      INT               NOT NULL DEFAULT 0,
    TongHDNCC         INT               NOT NULL DEFAULT 0,
    TongPhiPortal     DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongPhiNCC        DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongHHPortal      DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongHHNCC         DECIMAL(18,2)     NOT NULL DEFAULT 0,
    ChenhLechHD       INT               NOT NULL DEFAULT 0,
    ChenhLechPhi      DECIMAL(18,2)     NOT NULL DEFAULT 0,
    ChenhLechHH       DECIMAL(18,2)     NOT NULL DEFAULT 0,
    NgayGui           DATETIME2         NULL,
    NguoiGui          UNIQUEIDENTIFIER  NULL,
    NgayNCCKiemTra    DATETIME2         NULL,
    GhiChuNCCKiemTra  NVARCHAR(500)     NULL,
    NgayChot          DATETIME2         NULL,
    NguoiChot         UNIQUEIDENTIFIER  NULL,
    UrlFileXuat       NVARCHAR(500)     NULL,
    UrlFileNhapNCC    NVARCHAR(500)     NULL,
    GhiChu            NVARCHAR(MAX)     NULL,
    NgayTao           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat       DATETIME2         NULL,
    CONSTRAINT PK_KyDoiSoat PRIMARY KEY (Id),
    CONSTRAINT UQ_KyDoiSoat UNIQUE (DoiTacId, MaKy, NhaCungCapId)
);
GO

CREATE TABLE ChiTietDoiSoat (
    Id                 UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    KyDoiSoatId        UNIQUEIDENTIFIER  NOT NULL REFERENCES KyDoiSoat(Id),
    DoiTacId           UNIQUEIDENTIFIER  NOT NULL,
    HopDongId          UNIQUEIDENTIFIER  NULL REFERENCES HopDong(Id),
    SoHopDong          NVARCHAR(100)     NULL,
    SoHopDongNCC       NVARCHAR(100)     NULL,
    TrangThaiPortal    NVARCHAR(30)      NULL,
    TrangThaiNCC       NVARCHAR(30)      NULL,
    PhiPortal          DECIMAL(18,2)     NULL,
    PhiNCC             DECIMAL(18,2)     NULL,
    HoaHongPortal      DECIMAL(18,2)     NULL,
    HoaHongNCC         DECIMAL(18,2)     NULL,
    TrangThaiKhopLenh  NVARCHAR(20)      NOT NULL DEFAULT 'UNMATCHED',
    LoaiChenhLech      NVARCHAR(30)      NULL,
    GhiChuChenhLech    NVARCHAR(500)     NULL,
    NgayXuLy           DATETIME2         NULL,
    NguoiXuLy          UNIQUEIDENTIFIER  NULL,
    CachXuLy           NVARCHAR(30)      NULL,
    GhiChuXuLy         NVARCHAR(500)     NULL,
    DuLieuThoNCC       NVARCHAR(MAX)     NULL,
    NgayTao            DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_ChiTietDoiSoat PRIMARY KEY (Id)
);
GO
