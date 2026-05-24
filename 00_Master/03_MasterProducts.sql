-- ============================================================
-- TWL PORTAL 360LIFE - MASTER DATABASE
-- FILE: 03_MasterProducts.sql
-- DESC: DanhMucSanPham, SanPhamGoc, GoiSanPham, BangPhiBaoHiem, LichSuPhienBanSanPham
-- ============================================================
USE TWL_MASTER;
GO

CREATE TABLE DanhMucSanPham (
    Id                UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaDanhMuc         NVARCHAR(50)      NOT NULL,
    TenDanhMuc        NVARCHAR(255)     NOT NULL,
    TenDanhMucEn      NVARCHAR(255)     NULL,
    DanhMucChaId      UNIQUEIDENTIFIER  NULL REFERENCES DanhMucSanPham(Id),
    CapDo             INT               NOT NULL DEFAULT 1,
    DuongDanPhanCap   NVARCHAR(500)     NULL,
    LopBieuTuong      NVARCHAR(100)     NULL,
    UrlBieuTuong      NVARCHAR(500)     NULL,
    UrlBanner         NVARCHAR(500)     NULL,
    MoTa              NVARCHAR(MAX)     NULL,
    ThuTu             INT               NOT NULL DEFAULT 0,
    ConHoatDong       BIT               NOT NULL DEFAULT 1,
    NgayTao           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_DanhMucSanPham PRIMARY KEY (Id),
    CONSTRAINT UQ_DanhMucSanPham_MaDanhMuc UNIQUE (MaDanhMuc)
);
GO

CREATE TABLE SanPhamGoc (
    Id                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaSanPham               NVARCHAR(100)     NOT NULL,
    TenSanPham              NVARCHAR(255)     NOT NULL,
    TenSanPhamEn            NVARCHAR(255)     NULL,
    DanhMucId               UNIQUEIDENTIFIER  NOT NULL REFERENCES DanhMucSanPham(Id),
    NhaCungCapId            UNIQUEIDENTIFIER  NOT NULL REFERENCES NhaCungCapBaoHiem(Id),
    LoaiBaoHiem             NVARCHAR(50)      NOT NULL,
    -- AUTO_MANDATORY | AUTO_VOLUNTARY | MOTO_MANDATORY | HEALTH_CARD
    -- TRAVEL | PERSONAL_ACCIDENT | FIRE_EXPLOSION | APARTMENT
    -- PROPERTY | STUDY_ABROAD | IMMIGRATION | WILL_PLANNING | ENTERPRISE
    MoTaNgan                NVARCHAR(500)     NULL,
    MoTaChiTiet             NVARCHAR(MAX)     NULL,
    QuyenLoiChinh           NVARCHAR(MAX)     NULL,  -- JSON array
    DiemLoaiTru             NVARCHAR(MAX)     NULL,  -- JSON array
    -- Dynamic Form Schema JSON:
    -- {"sections":[{"name":"vehicle_info","label":"Thong tin xe",
    --   "fields":[{"key":"plate_number","label":"Bien so xe",
    --   "type":"text","required":true,"validation":"regex"}]}]}
    CauTrucBieuMau          NVARCHAR(MAX)     NOT NULL,
    PhuongThucTinhGia       NVARCHAR(20)      NOT NULL DEFAULT 'LOOKUP_TABLE',
    -- LOOKUP_TABLE | FORMULA | API_REALTIME
    CauHinhTinhGia          NVARCHAR(MAX)     NULL,  -- JSON
    PhiToiThieu             DECIMAL(18,2)     NULL,
    PhiToiDa                DECIMAL(18,2)     NULL,
    DonViPhi                NVARCHAR(20)      NOT NULL DEFAULT 'VND',
    BangTraCuuPhi           NVARCHAR(MAX)     NULL,  -- JSON lookup table
    SoNgayToiThieu          INT               NULL,
    SoNgayToiDa             INT               NULL,
    SoNgayMacDinh           INT               NULL DEFAULT 365,
    ChoPhepTuyChinhThoiHan  BIT               NOT NULL DEFAULT 0,
    SoTienBHToiThieu        DECIMAL(18,2)     NULL,
    SoTienBHToiDa           DECIMAL(18,2)     NULL,
    ChoPhepTraGop           BIT               NOT NULL DEFAULT 0,
    -- JSON: {"options":[{"periods":1,"label":"1 lan"},
    --   {"periods":4,"label":"4 ky/nam","surcharge_rate":0.02}]}
    CauHinhTraGop           NVARCHAR(MAX)     NULL,
    -- JSON: [{"code":"CCCD","name":"CCCD/CMND","required":true},
    --        {"code":"CAVET","name":"Cavet xe","required":true}]
    TaiLieuYeuCau           NVARCHAR(MAX)     NULL,
    UrlMauHopDong           NVARCHAR(500)     NULL,
    UrlMauChungNhan         NVARCHAR(500)     NULL,
    TruongGhepMau           NVARCHAR(MAX)     NULL,  -- JSON field mapping
    UrlAnhDaiDien           NVARCHAR(500)     NULL,
    UrlBanner               NVARCHAR(500)     NULL,
    NhanDan                 NVARCHAR(500)     NULL,
    ThuTu                   INT               NOT NULL DEFAULT 0,
    LaNoiBat                BIT               NOT NULL DEFAULT 0,
    TrangThai               NVARCHAR(20)      NOT NULL DEFAULT 'DRAFT',
    -- DRAFT | PENDING_APPROVAL | APPROVED | ACTIVE | SUSPENDED | EXPIRED
    NguoiDuyet              UNIQUEIDENTIFIER  NULL,
    NgayDuyet               DATETIME2         NULL,
    HieuLucTu               DATE              NULL,
    HieuLucDen              DATE              NULL,
    MaSanPhamNCC            NVARCHAR(100)     NULL,
    TenSanPhamNCC           NVARCHAR(255)     NULL,
    NgayTao                 DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao                UNIQUEIDENTIFIER  NULL,
    NgayCapNhat             DATETIME2         NULL,
    NguoiCapNhat            UNIQUEIDENTIFIER  NULL,
    DaXoa                   BIT               NOT NULL DEFAULT 0,
    CONSTRAINT PK_SanPhamGoc PRIMARY KEY (Id),
    CONSTRAINT UQ_SanPhamGoc_MaSanPham UNIQUE (MaSanPham)
);
GO

CREATE TABLE GoiSanPham (
    Id                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    SanPhamGocId        UNIQUEIDENTIFIER  NOT NULL REFERENCES SanPhamGoc(Id),
    MaGoi               NVARCHAR(50)      NOT NULL,  -- BRONZE|SILVER|GOLD|BASIC|PREMIUM
    TenGoi              NVARCHAR(255)     NOT NULL,
    TenGoiEn            NVARCHAR(255)     NULL,
    MoTa                NVARCHAR(MAX)     NULL,
    TomTatQuyenLoi      NVARCHAR(MAX)     NULL,  -- JSON
    ChiTietQuyenLoi     NVARCHAR(MAX)     NULL,  -- JSON
    TyLeBaoPhu          DECIMAL(5,2)      NULL,
    SoTienBaoHiem       DECIMAL(18,2)     NULL,
    PhiBoSung           NVARCHAR(MAX)     NULL,  -- JSON
    HeSoNhanPhi         DECIMAL(5,3)      NULL DEFAULT 1.0,
    MoRong              NVARCHAR(MAX)     NULL,  -- JSON
    DuocDeXuat          BIT               NOT NULL DEFAULT 0,
    ThuTu               INT               NOT NULL DEFAULT 0,
    ConHoatDong         BIT               NOT NULL DEFAULT 1,
    MaGoiNCC            NVARCHAR(50)      NULL,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat         DATETIME2         NULL,
    CONSTRAINT PK_GoiSanPham PRIMARY KEY (Id),
    CONSTRAINT UQ_GoiSanPham_MaGoi UNIQUE (SanPhamGocId, MaGoi)
);
GO

CREATE TABLE BangPhiBaoHiem (
    Id                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    SanPhamGocId        UNIQUEIDENTIFIER  NOT NULL REFERENCES SanPhamGoc(Id),
    GoiSanPhamId        UNIQUEIDENTIFIER  NULL REFERENCES GoiSanPham(Id),
    DieuKien1Khoa       NVARCHAR(100)     NULL,
    DieuKien1GiaTri     NVARCHAR(100)     NULL,
    DieuKien2Khoa       NVARCHAR(100)     NULL,
    DieuKien2GiaTri     NVARCHAR(100)     NULL,
    DieuKien3Khoa       NVARCHAR(100)     NULL,
    DieuKien3GiaTri     NVARCHAR(100)     NULL,
    DieuKien4Khoa       NVARCHAR(100)     NULL,
    DieuKien4GiaTri     NVARCHAR(100)     NULL,
    LoaiPhi             NVARCHAR(20)      NOT NULL DEFAULT 'FIXED',  -- FIXED|RATE_PERCENT
    PhiCoDinh           DECIMAL(18,2)     NULL,
    TyLePhi             DECIMAL(8,6)      NULL,
    PhiToiThieu         DECIMAL(18,2)     NULL,
    PhiToiDa            DECIMAL(18,2)     NULL,
    HieuLucTu           DATE              NOT NULL,
    HieuLucDen          DATE              NULL,
    ConHoatDong         BIT               NOT NULL DEFAULT 1,
    MaDotNhap           NVARCHAR(50)      NULL,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_BangPhiBaoHiem PRIMARY KEY (Id)
);
GO

CREATE TABLE LichSuPhienBanSanPham (
    Id                  BIGINT            NOT NULL IDENTITY(1,1),
    SanPhamGocId        UNIQUEIDENTIFIER  NOT NULL REFERENCES SanPhamGoc(Id),
    SoPhienBan          INT               NOT NULL,
    LoaiThayDoi         NVARCHAR(30)      NOT NULL,
    TomTatThayDoi       NVARCHAR(500)     NULL,
    DuLieuCu            NVARCHAR(MAX)     NULL,
    DuLieuMoi           NVARCHAR(MAX)     NULL,
    HieuLucTu           DATE              NOT NULL,
    NguoiThayDoi        UNIQUEIDENTIFIER  NULL,
    NgayThayDoi         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiDuyet          UNIQUEIDENTIFIER  NULL,
    GhiChu              NVARCHAR(MAX)     NULL,
    CONSTRAINT PK_LichSuPhienBanSanPham PRIMARY KEY (Id)
);
GO
