-- ============================================================
-- TWL PORTAL 360LIFE - TENANT DATABASE
-- FILE: 07_Commission.sql
-- ============================================================
GO

CREATE TABLE SoHoaHong (
    Id                    UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId              UNIQUEIDENTIFIER  NOT NULL,
    HopDongId             UNIQUEIDENTIFIER  NOT NULL REFERENCES HopDong(Id),
    DaiLyId               UNIQUEIDENTIFIER  NOT NULL REFERENCES DaiLy(Id),
    DaiLyThuHuongId       UNIQUEIDENTIFIER  NOT NULL REFERENCES DaiLy(Id),
    LoaiHoaHong           NVARCHAR(20)      NOT NULL,
    CapGianTiep           INT               NULL,
    PhiCoSo               DECIMAL(18,2)     NOT NULL,
    TyLeHoaHong           DECIMAL(6,5)      NOT NULL,
    HoaHongGop            DECIMAL(18,2)     NOT NULL,
    TyLeThue              DECIMAL(5,4)      NOT NULL DEFAULT 0.10,
    SoTienThue            DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongRong           DECIMAL(18,2)     NOT NULL,
    NamKy                 INT               NOT NULL,
    ThangKy               INT               NOT NULL,
    TrangThai             NVARCHAR(20)      NOT NULL DEFAULT 'PENDING',
    NgayDoiTrangThai      DATETIME2         NULL,
    NguoiDoiTrangThai     UNIQUEIDENTIFIER  NULL,
    NgayDuyet             DATETIME2         NULL,
    NguoiDuyet            UNIQUEIDENTIFIER  NULL,
    DotChiId              UNIQUEIDENTIFIER  NULL,
    MaDotChi              NVARCHAR(50)      NULL,
    NgayTra               DATETIME2         NULL,
    SoThamChieuThanhToan  NVARCHAR(100)     NULL,
    NgayHuy               DATETIME2         NULL,
    LyDoHuy               NVARCHAR(500)     NULL,
    GhiChu                NVARCHAR(500)     NULL,
    NgayTao               DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat           DATETIME2         NULL,
    CONSTRAINT PK_SoHoaHong PRIMARY KEY (Id)
);
GO

CREATE TABLE DotChiHoaHong (
    Id               UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId         UNIQUEIDENTIFIER  NOT NULL,
    MaDotChi         NVARCHAR(50)      NOT NULL,
    NamKy            INT               NOT NULL,
    ThangKy          INT               NOT NULL,
    TongDaiLy        INT               NOT NULL DEFAULT 0,
    TongHopDong      INT               NOT NULL DEFAULT 0,
    TongGop          DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongThue         DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongRong         DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TrangThai        NVARCHAR(20)      NOT NULL DEFAULT 'DRAFT',
    NguoiChuanBi     UNIQUEIDENTIFIER  NULL,
    NgayChuanBi      DATETIME2         NULL,
    NguoiKiemTra     UNIQUEIDENTIFIER  NULL,
    NgayKiemTra      DATETIME2         NULL,
    NguoiDuyet       UNIQUEIDENTIFIER  NULL,
    NgayDuyet        DATETIME2         NULL,
    NguoiThanhToan   UNIQUEIDENTIFIER  NULL,
    NgayThanhToan    DATETIME2         NULL,
    GhiChu           NVARCHAR(MAX)     NULL,
    NgayTao          DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat      DATETIME2         NULL,
    CONSTRAINT PK_DotChiHoaHong PRIMARY KEY (Id),
    CONSTRAINT UQ_DotChiHoaHong_Ma UNIQUE (DoiTacId, MaDotChi)
);
GO

CREATE TABLE DuBaoHoaHong (
    Id                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId            UNIQUEIDENTIFIER  NOT NULL,
    DaiLyId             UNIQUEIDENTIFIER  NOT NULL REFERENCES DaiLy(Id),
    NamKy               INT               NOT NULL,
    ThangKy             INT               NOT NULL,
    SoHopDongDuBao      INT               NOT NULL DEFAULT 0,
    DoanhThuDuBao       DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongDuBao        DECIMAL(18,2)     NOT NULL DEFAULT 0,
    SoHopDongXacNhan    INT               NOT NULL DEFAULT 0,
    DoanhThuXacNhan     DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongXacNhan      DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongThucTe       DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongDaHuy        DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongChoNCC       DECIMAL(18,2)     NOT NULL DEFAULT 0,
    LanTinhCuoi         DATETIME2         NULL,
    CONSTRAINT PK_DuBaoHoaHong PRIMARY KEY (Id),
    CONSTRAINT UQ_DuBaoHoaHong UNIQUE (DoiTacId, DaiLyId, NamKy, ThangKy)
);
GO
