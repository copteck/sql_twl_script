-- ============================================================
-- TWL PORTAL 360LIFE - TENANT DATABASE
-- FILE: 06_Payments.sql
-- ============================================================
GO

CREATE TABLE GiaoDichThanhToan (
    Id                   UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId             UNIQUEIDENTIFIER  NOT NULL,
    MaGiaoDich           NVARCHAR(100)     NOT NULL,
    HopDongId            UNIQUEIDENTIFIER  NOT NULL REFERENCES HopDong(Id),
    KhachHangId          UNIQUEIDENTIFIER  NOT NULL REFERENCES KhachHang(Id),
    DaiLyId              UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Id),
    SoTien               DECIMAL(18,2)     NOT NULL,
    LoaiTien             NVARCHAR(10)      NOT NULL DEFAULT 'VND',
    LoaiThanhToan        NVARCHAR(20)      NOT NULL,
    KyThanhToan          INT               NULL,
    PhuongThucThanhToan  NVARCHAR(30)      NOT NULL,
    CongThanhToan        NVARCHAR(30)      NULL,
    MaGiaoDichCong       NVARCHAR(200)     NULL,
    MaDonHangCong        NVARCHAR(200)     NULL,
    UrlThanhToanCong     NVARCHAR(500)     NULL,
    TrangThaiCong        NVARCHAR(50)      NULL,
    PhanHoiCong          NVARCHAR(MAX)     NULL,
    MaNganHang           NVARCHAR(50)      NULL,
    LoaiThe              NVARCHAR(30)      NULL,
    SoTaiKhoan           NVARCHAR(50)      NULL,
    TrangThai            NVARCHAR(20)      NOT NULL DEFAULT 'PENDING',
    NgayKhoiTao          DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayHoanThanh        DATETIME2         NULL,
    NgayHetHan           DATETIME2         NULL,
    NgayThatBai          DATETIME2         NULL,
    LyDoThatBai          NVARCHAR(500)     NULL,
    SoBienLai            NVARCHAR(100)     NULL,
    UrlBienLai           NVARCHAR(500)     NULL,
    SoHoaDon             NVARCHAR(100)     NULL,
    LaHoanTien           BIT               NOT NULL DEFAULT 0,
    GiaoDichHoanTienId   UNIQUEIDENTIFIER  NULL,
    LyDoHoanTien         NVARCHAR(500)     NULL,
    NgayHoanTien         DATETIME2         NULL,
    GhiChu               NVARCHAR(500)     NULL,
    NgayTao              DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat          DATETIME2         NULL,
    CONSTRAINT PK_GiaoDichThanhToan PRIMARY KEY (Id),
    CONSTRAINT UQ_GiaoDichThanhToan_Ma UNIQUE (DoiTacId, MaGiaoDich)
);
GO

CREATE TABLE NhatKyWebhook (
    Id               BIGINT            NOT NULL IDENTITY(1,1),
    DoiTacId         UNIQUEIDENTIFIER  NULL,
    CongThanhToan    NVARCHAR(30)      NOT NULL,
    LoaiSuKien       NVARCHAR(100)     NULL,
    DuLieuTho        NVARCHAR(MAX)     NOT NULL,
    GiaoDichPhanTichId UNIQUEIDENTIFIER  NULL,
    DaXacMinh        BIT               NOT NULL DEFAULT 0,
    DaXuLy           BIT               NOT NULL DEFAULT 0,
    NgayXuLy         DATETIME2         NULL,
    ThongBaoLoi      NVARCHAR(500)     NULL,
    DiaChiIp         NVARCHAR(50)      NULL,
    NgayNhan         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_NhatKyWebhook PRIMARY KEY (Id)
);
GO

CREATE TABLE LichTraGop (
    Id               UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    HopDongId        UNIQUEIDENTIFIER  NOT NULL REFERENCES HopDong(Id),
    DoiTacId         UNIQUEIDENTIFIER  NOT NULL,
    KyThanhToan      INT               NOT NULL,
    NgayDenHan       DATE              NOT NULL,
    SoTien           DECIMAL(18,2)     NOT NULL,
    TrangThai        NVARCHAR(20)      NOT NULL DEFAULT 'PENDING',
    SoTienDaTra      DECIMAL(18,2)     NOT NULL DEFAULT 0,
    NgayTra          DATETIME2         NULL,
    GiaoDichId       UNIQUEIDENTIFIER  NULL REFERENCES GiaoDichThanhToan(Id),
    NgayGuiNhac      DATETIME2         NULL,
    SoLanNhac        INT               NOT NULL DEFAULT 0,
    NgayTao          DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_LichTraGop PRIMARY KEY (Id)
);
GO
