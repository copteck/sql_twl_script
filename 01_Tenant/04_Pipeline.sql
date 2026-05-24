-- ============================================================
-- TWL PORTAL 360LIFE - TENANT DATABASE
-- FILE: 04_Pipeline.sql
-- ============================================================
GO

CREATE TABLE QuyTrinhBanHang (
    Id                   UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId             UNIQUEIDENTIFIER  NOT NULL,
    MaQuyTrinh           NVARCHAR(50)      NOT NULL,
    KhachHangId          UNIQUEIDENTIFIER  NOT NULL REFERENCES KhachHang(Id),
    DaiLyId              UNIQUEIDENTIFIER  NOT NULL REFERENCES DaiLy(Id),
    SanPhamGocId         UNIQUEIDENTIFIER  NULL,
    GoiSanPhamId         UNIQUEIDENTIFIER  NULL,
    SanPhamQuanTam       NVARCHAR(MAX)     NULL,
    GiaiDoan             NVARCHAR(30)      NOT NULL DEFAULT 'NEW',
    NgayDoiGiaiDoan      DATETIME2         NULL,
    NguoiDoiGiaiDoan     UNIQUEIDENTIFIER  NULL,
    GiaiDoanTruoc        NVARCHAR(30)      NULL,
    LyDoMat              NVARCHAR(50)      NULL,
    GhiChuMat            NVARCHAR(500)     NULL,
    PhiDuKien            DECIMAL(18,2)     NULL,
    NgayChotDuKien       DATE              NULL,
    XacSuatChot          INT               NULL,
    HopDongKetQuaId      UNIQUEIDENTIFIER  NULL,
    HanLienHeDauTien     DATETIME2         NULL,
    NgayLienHeDauTien    DATETIME2         NULL,
    TrangThaiSLA         NVARCHAR(20)      NULL,
    NguonKhachTiemNang   NVARCHAR(50)      NULL,
    ChiTietNguonKTN      NVARCHAR(255)     NULL,
    MucDoUuTien          NVARCHAR(10)      NOT NULL DEFAULT 'NORMAL',
    GhiChu               NVARCHAR(MAX)     NULL,
    NgayTao              DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat          DATETIME2         NULL,
    NgayDongHoSo         DATETIME2         NULL,
    CONSTRAINT PK_QuyTrinhBanHang PRIMARY KEY (Id)
);
GO

CREATE TABLE HoatDongBanHang (
    Id                BIGINT            NOT NULL IDENTITY(1,1),
    QuyTrinhBanHangId UNIQUEIDENTIFIER  NOT NULL REFERENCES QuyTrinhBanHang(Id),
    DoiTacId          UNIQUEIDENTIFIER  NOT NULL,
    DaiLyId           UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Id),
    LoaiHoatDong      NVARCHAR(30)      NOT NULL,
    GiaiDoanCu        NVARCHAR(30)      NULL,
    GiaiDoanMoi       NVARCHAR(30)      NULL,
    MoTa              NVARCHAR(MAX)     NULL,
    KetQua            NVARCHAR(100)     NULL,
    NgayHenLich       DATETIME2         NULL,
    NgayHoanThanh     DATETIME2         NULL,
    DoHeThongTao      BIT               NOT NULL DEFAULT 0,
    NgayTao           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_HoatDongBanHang PRIMARY KEY (Id)
);
GO

CREATE TABLE BaoGia (
    Id                   UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId             UNIQUEIDENTIFIER  NOT NULL,
    MaBaoGia             NVARCHAR(50)      NOT NULL,
    QuyTrinhBanHangId    UNIQUEIDENTIFIER  NULL REFERENCES QuyTrinhBanHang(Id),
    KhachHangId          UNIQUEIDENTIFIER  NOT NULL REFERENCES KhachHang(Id),
    DaiLyId              UNIQUEIDENTIFIER  NOT NULL REFERENCES DaiLy(Id),
    SanPhamGocId         UNIQUEIDENTIFIER  NOT NULL,
    GoiSanPhamId         UNIQUEIDENTIFIER  NULL,
    DuLieuDauVao         NVARCHAR(MAX)     NOT NULL,
    PhiCoSo              DECIMAL(18,2)     NOT NULL,
    SoTienGiam           DECIMAL(18,2)     NOT NULL DEFAULT 0,
    LyDoGiam             NVARCHAR(255)     NULL,
    SoTienPhuThu         DECIMAL(18,2)     NOT NULL DEFAULT 0,
    PhiCuoiCung          DECIMAL(18,2)     NOT NULL,
    SoTienBaoHiem        DECIMAL(18,2)     NULL,
    NgayBatDau           DATE              NULL,
    NgayKetThuc          DATE              NULL,
    TrangThai            NVARCHAR(20)      NOT NULL DEFAULT 'DRAFT',
    NgayGui              DATETIME2         NULL,
    NgayXem              DATETIME2         NULL,
    NgayHetHan           DATETIME2         NULL,
    NgayChapNhan         DATETIME2         NULL,
    UrlPdfBaoGia         NVARCHAR(500)     NULL,
    GhiChu               NVARCHAR(MAX)     NULL,
    GhiChuDaiLy          NVARCHAR(MAX)     NULL,
    HopDongChuyenDoiId   UNIQUEIDENTIFIER  NULL,
    NgayChuyenDoi        DATETIME2         NULL,
    NgayTao              DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat          DATETIME2         NULL,
    CONSTRAINT PK_BaoGia PRIMARY KEY (Id),
    CONSTRAINT UQ_BaoGia_Ma UNIQUE (DoiTacId, MaBaoGia)
);
GO
