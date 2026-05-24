-- ============================================================
-- TWL PORTAL 360LIFE - MASTER DATABASE
-- FILE: 01_Tenants.sql
-- DESC: DangKyDoiTac, CauHinhHeThong, LienKetSanPhamDoiTac
-- ============================================================
USE TWL_MASTER;
GO

-- ============================================================
-- TABLE: DangKyDoiTac
-- ============================================================
CREATE TABLE DangKyDoiTac (
    Id                       UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaDoiTac                 NVARCHAR(50)      NOT NULL,
    TenDoiTac                NVARCHAR(255)     NOT NULL,
    TenDoiTacEn              NVARCHAR(255)     NULL,
    CapDoDoiTac              TINYINT           NOT NULL,  -- 0=HQ,1=Branch,2=Group,3=Team,4=Agent
    LoaiDoiTac               NVARCHAR(30)      NOT NULL,  -- HQ|COMPANY|BRANCH|GROUP|TEAM|INDIVIDUAL
    TenMienPhu               NVARCHAR(100)     NOT NULL,
    TenMienRieng             NVARCHAR(255)     NULL,
    TenMienPhuHoatDong       BIT               NOT NULL DEFAULT 1,
    TenMayChuDb              NVARCHAR(255)     NOT NULL,
    CongMayChuDb             INT               NOT NULL DEFAULT 1433,
    TenCsdl                  NVARCHAR(100)     NOT NULL,
    ChuoiKetNoiMaHoa         NVARCHAR(MAX)     NOT NULL,
    ChuoiDocPhuMaHoa         NVARCHAR(MAX)     NULL,
    DoiTacChaId              UNIQUEIDENTIFIER  NULL REFERENCES DangKyDoiTac(Id),
    DoiTacGocId              UNIQUEIDENTIFIER  NOT NULL,
    DuongDanPhanCap          NVARCHAR(500)     NULL,
    CapPhanCap               INT               NOT NULL DEFAULT 1,
    TenPhapLy                NVARCHAR(255)     NULL,
    MaSoThue                 NVARCHAR(20)      NULL,
    GiayPhepKinhDoanh        NVARCHAR(100)     NULL,
    NgayHetHanGPKD           DATE              NULL,
    TenNguoiDaiDien          NVARCHAR(255)     NULL,
    SdtNguoiDaiDien          NVARCHAR(20)      NULL,
    EmailNguoiDaiDien        NVARCHAR(255)     NULL,
    DiaChi                   NVARCHAR(500)     NULL,
    PhuongXa                 NVARCHAR(100)     NULL,
    QuanHuyen                NVARCHAR(100)     NULL,
    TinhThanh                NVARCHAR(100)     NULL,
    ViDo                     DECIMAL(10,8)     NULL,
    KinhDo                   DECIMAL(11,8)     NULL,
    UrlLogo                  NVARCHAR(500)     NULL,
    UrlFavicon               NVARCHAR(500)     NULL,
    MauChinh                 NVARCHAR(20)      NULL DEFAULT '#1D4ED8',
    MauPhu                   NVARCHAR(20)      NULL DEFAULT '#06B6D4',
    CauHinhGiaoDien          NVARCHAR(MAX)     NULL,
    SoDienThoai              NVARCHAR(20)      NULL,
    Email                    NVARCHAR(255)     NULL,
    ZaloOAId                 NVARCHAR(100)     NULL,
    FacebookPageId           NVARCHAR(100)     NULL,
    TienTeNgamDinh           NVARCHAR(10)      NOT NULL DEFAULT 'VND',
    MuiGio                   NVARCHAR(50)      NOT NULL DEFAULT 'SE Asia Standard Time',
    ChuKyTraHoaHong          NVARCHAR(20)      NOT NULL DEFAULT 'MONTHLY',
    NgayTraHoaHong           INT               NOT NULL DEFAULT 15,
    SoCapDaiLyToiDa          INT               NOT NULL DEFAULT 5,
    ChoPhepMuaVangLai        BIT               NOT NULL DEFAULT 1,
    YeuCauQuanLyDuyet        BIT               NOT NULL DEFAULT 0,
    TrangThai                NVARCHAR(20)      NOT NULL DEFAULT 'ACTIVE',
    NgayKichHoat             DATETIME2         NULL,
    NgayTamNgung             DATETIME2         NULL,
    LyDoTamNgung             NVARCHAR(500)     NULL,
    NgayTao                  DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao                 UNIQUEIDENTIFIER  NULL,
    NgayCapNhat              DATETIME2         NULL,
    NguoiCapNhat             UNIQUEIDENTIFIER  NULL,
    DaXoa                    BIT               NOT NULL DEFAULT 0,
    NgayXoa                  DATETIME2         NULL,
    CONSTRAINT PK_DangKyDoiTac PRIMARY KEY (Id),
    CONSTRAINT UQ_DangKyDoiTac_MaDoiTac UNIQUE (MaDoiTac),
    CONSTRAINT UQ_DangKyDoiTac_TenMienPhu UNIQUE (TenMienPhu)
);
GO

-- ============================================================
-- TABLE: CauHinhHeThong
-- ============================================================
CREATE TABLE CauHinhHeThong (
    Id            UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    KhoaCauHinh   NVARCHAR(200)     NOT NULL,
    GiaTriCauHinh NVARCHAR(MAX)     NULL,
    LoaiCauHinh   NVARCHAR(20)      NOT NULL DEFAULT 'STRING',
    MoTa          NVARCHAR(500)     NULL,
    DoiTacId      UNIQUEIDENTIFIER  NULL REFERENCES DangKyDoiTac(Id),
    DaMaHoa       BIT               NOT NULL DEFAULT 0,
    NgayTao       DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat   DATETIME2         NULL,
    NguoiCapNhat  UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_CauHinhHeThong PRIMARY KEY (Id),
    CONSTRAINT UQ_CauHinhHeThong_KhoaCauHinh_DoiTacId UNIQUE (KhoaCauHinh, DoiTacId)
);
GO

-- ============================================================
-- TABLE: LienKetSanPhamDoiTac
-- ============================================================
CREATE TABLE LienKetSanPhamDoiTac (
    Id                    UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    DoiTacId              UNIQUEIDENTIFIER  NOT NULL REFERENCES DangKyDoiTac(Id),
    SanPhamGocId          UNIQUEIDENTIFIER  NOT NULL,
    ConHoatDong           BIT               NOT NULL DEFAULT 1,
    NgayKichHoat          DATETIME2         NULL,
    NgayNgungKichHoat     DATETIME2         NULL,
    LyDoNgung             NVARCHAR(500)     NULL,
    ThuTu                 INT               NOT NULL DEFAULT 0,
    MoTaRieng             NVARCHAR(MAX)     NULL,
    NgayTao               DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao              UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_LienKetSanPhamDoiTac PRIMARY KEY (Id),
    CONSTRAINT UQ_LienKetSanPhamDoiTac_DoiTacId_SanPhamGocId UNIQUE (DoiTacId, SanPhamGocId)
);
GO
