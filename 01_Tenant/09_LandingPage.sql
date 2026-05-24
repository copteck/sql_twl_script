-- ============================================================
-- TWL PORTAL 360LIFE - TENANT DATABASE
-- FILE: 09_LandingPage.sql
-- ============================================================
GO

CREATE TABLE MauTrangDich (
    Id                UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaMau             NVARCHAR(50)      NOT NULL,
    TenMau            NVARCHAR(255)     NOT NULL,
    DanhMuc           NVARCHAR(50)      NULL,
    UrlAnhDaiDien     NVARCHAR(500)     NULL,
    UrlXemTruoc       NVARCHAR(500)     NULL,
    CauHinhBoCuc      NVARCHAR(MAX)     NOT NULL,
    ConHoatDong       BIT               NOT NULL DEFAULT 1,
    LaCaoCap          BIT               NOT NULL DEFAULT 0,
    SoLanSuDung       INT               NOT NULL DEFAULT 0,
    ThuTu             INT               NOT NULL DEFAULT 0,
    NgayTao           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_MauTrangDich PRIMARY KEY (Id),
    CONSTRAINT UQ_MauTrangDich_Ma UNIQUE (MaMau)
);
GO

CREATE TABLE TrangDich (
    Id                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId            UNIQUEIDENTIFIER  NOT NULL,
    DaiLyId             UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Id),
    MaTrang             NVARCHAR(50)      NOT NULL,
    TieuDeTrang         NVARCHAR(255)     NOT NULL,
    LoaiTrang           NVARCHAR(30)      NOT NULL,
    -- SALE|RECRUITMENT|PROFILE|COMBINED|CAMPAIGN
    TenMienPhu          NVARCHAR(100)     NULL,
    SlugTuyBien         NVARCHAR(100)     NULL,
    UrlDayDu            NVARCHAR(500)     NULL,
    MauTrangDichId      UNIQUEIDENTIFIER  NULL REFERENCES MauTrangDich(Id),
    -- JSON: {"theme":{...},"blocks":[{"id":"b1","type":"HeroBanner","order":1,"props":{...}},...]}
    CauHinhBoCuc        NVARCHAR(MAX)     NOT NULL,
    DsSanPhamNoiBat     NVARCHAR(MAX)     NULL,  -- JSON array of MasterProductIds
    -- JSON: {"fields":["name","phone","email","need"],"auto_assign_agent":true}
    CauHinhFormKTN      NVARCHAR(MAX)     NULL,
    MetaTieuDe          NVARCHAR(255)     NULL,
    MetaMoTa            NVARCHAR(500)     NULL,
    MetaTuKhoa          NVARCHAR(500)     NULL,
    UrlAnhOg            NVARCHAR(500)     NULL,
    FacebookPixelId     NVARCHAR(100)     NULL,
    GoogleAnalyticsId   NVARCHAR(50)      NULL,
    ZaloOAId            NVARCHAR(100)     NULL,
    TongLuotXem         BIGINT            NOT NULL DEFAULT 0,
    LuotXemDuyNhat      BIGINT            NOT NULL DEFAULT 0,
    TongKhachTiemNang   INT               NOT NULL DEFAULT 0,
    TongHopDong         INT               NOT NULL DEFAULT 0,
    TyLeChuyenDoi       DECIMAL(5,4)      NULL,
    TrangThai           NVARCHAR(20)      NOT NULL DEFAULT 'DRAFT',
    NgayXuatBan         DATETIME2         NULL,
    NgayGoXuatBan       DATETIME2         NULL,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat         DATETIME2         NULL,
    CONSTRAINT PK_TrangDich PRIMARY KEY (Id),
    CONSTRAINT UQ_TrangDich_Ma UNIQUE (DoiTacId, MaTrang)
);
GO

CREATE TABLE KhachTiemNangTrangDich (
    Id                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId                UNIQUEIDENTIFIER  NOT NULL,
    TrangDichId             UNIQUEIDENTIFIER  NOT NULL REFERENCES TrangDich(Id),
    DaiLyId                 UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Id),
    HoTen                   NVARCHAR(255)     NOT NULL,
    SoDienThoai             NVARCHAR(20)      NOT NULL,
    Email                   NVARCHAR(255)     NULL,
    LoiNhan                 NVARCHAR(1000)    NULL,
    SanPhamQuanTam          NVARCHAR(255)     NULL,
    DuLieuForm              NVARCHAR(MAX)     NULL,
    DiaChiIp                NVARCHAR(50)      NULL,
    UserAgent               NVARCHAR(500)     NULL,
    UrlGioiThieu            NVARCHAR(500)     NULL,
    UtmSource               NVARCHAR(100)     NULL,
    UtmCampaign             NVARCHAR(100)     NULL,
    KhachHangChuyenDoiId    UNIQUEIDENTIFIER  NULL REFERENCES KhachHang(Id),
    QuyTrinhChuyenDoiId     UNIQUEIDENTIFIER  NULL,
    NgayChuyenDoi           DATETIME2         NULL,
    TrangThai               NVARCHAR(20)      NOT NULL DEFAULT 'NEW',
    -- NEW|CONTACTED|CONVERTED|INVALID|DUPLICATE
    NgayTao                 DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_KhachTiemNangTrangDich PRIMARY KEY (Id)
);
GO

CREATE TABLE LuotXemTrangDich (
    Id              BIGINT            NOT NULL IDENTITY(1,1),
    TrangDichId     UNIQUEIDENTIFIER  NOT NULL REFERENCES TrangDich(Id),
    DoiTacId        UNIQUEIDENTIFIER  NOT NULL,
    MaPhien         NVARCHAR(100)     NULL,
    DiaChiIp        NVARCHAR(50)      NULL,
    UserAgent       NVARCHAR(500)     NULL,
    UrlGioiThieu    NVARCHAR(500)     NULL,
    UtmSource       NVARCHAR(100)     NULL,
    UtmMedium       NVARCHAR(100)     NULL,
    UtmCampaign     NVARCHAR(100)     NULL,
    QuocGia         NVARCHAR(50)      NULL,
    ThanhPho        NVARCHAR(100)     NULL,
    LoaiThietBi     NVARCHAR(20)      NULL,  -- DESKTOP|MOBILE|TABLET
    NgayXem         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    ThoiGianTrenTrang INT             NULL,  -- seconds
    CONSTRAINT PK_LuotXemTrangDich PRIMARY KEY (Id)
);
GO
