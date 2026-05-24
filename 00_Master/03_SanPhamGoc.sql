-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHINH (MASTER)
-- FILE: 03_SanPhamGoc.sql
-- MO TA: DanhMucSanPham, SanPhamGoc, GoiSanPham, BangGiaPhi, LichSuPhienBan
-- ============================================================
USE TWL_MASTER;
GO

-- ============================================================
-- BANG: DanhMucSanPham
-- Phan loai san pham theo danh muc cap bac
-- ============================================================
CREATE TABLE DanhMucSanPham (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaDanhMuc       NVARCHAR(50)      NOT NULL,
    TenDanhMuc      NVARCHAR(255)     NOT NULL,
    TenDanhMucEN    NVARCHAR(255)     NULL,
    MaDanhMucCha    UNIQUEIDENTIFIER  NULL REFERENCES DanhMucSanPham(Ma),
    Cap             INT               NOT NULL DEFAULT 1,
    DuongDanPhanCap NVARCHAR(500)     NULL,
    LopBieuTuong    NVARCHAR(100)     NULL,
    UrlBieuTuong    NVARCHAR(500)     NULL,
    UrlBanner       NVARCHAR(500)     NULL,
    MoTa            NVARCHAR(MAX)     NULL,
    ThuTuHienThi    INT               NOT NULL DEFAULT 0,
    DangHoatDong    BIT               NOT NULL DEFAULT 1,
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_DanhMucSanPham PRIMARY KEY (Ma),
    CONSTRAINT UQ_DanhMucSanPham_MaDM UNIQUE (MaDanhMuc)
);
GO

-- ============================================================
-- BANG: SanPhamGoc
-- San pham bao hiem goc duoc quan ly tai Master
-- ============================================================
CREATE TABLE SanPhamGoc (
    Ma                          UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaSanPham                   NVARCHAR(100)     NOT NULL,
    TenSanPham                  NVARCHAR(255)     NOT NULL,
    TenSanPhamEN                NVARCHAR(255)     NULL,
    MaDanhMuc                   UNIQUEIDENTIFIER  NOT NULL REFERENCES DanhMucSanPham(Ma),
    MaNCC                       UNIQUEIDENTIFIER  NOT NULL REFERENCES NhaCungCapBaoHiem(Ma),
    LoaiBaoHiem                 NVARCHAR(50)      NOT NULL,
    -- XE_BATBUOC | XE_TUNGUYEN | XEMAY_BATBUOC | SUCKHOE_THE
    -- DULICH | TAINAN_CANHAN | CHAYNOS | CANHO
    -- TAISAN | DUHOC | DINUCU | DIENCHUC | DOANHNGHIEP
    MoTaNgan                    NVARCHAR(500)     NULL,
    MoTaChiTiet                 NVARCHAR(MAX)     NULL,
    QuyenLoiChinh               NVARCHAR(MAX)     NULL,  -- Mang JSON
    DieuKhoanLoaiTru            NVARCHAR(MAX)     NULL,  -- Mang JSON
    -- JSON Schema form dong:
    -- {"mucLuc":[{"ten":"thong_tin_xe","nhan":"Thong tin xe",
    --   "truong":[{"khoa":"bien_so","nhan":"Bien so xe",
    --   "loai":"text","batbuoc":true,"kiemtra":"regex"}]}]}
    SoDoFormDong                NVARCHAR(MAX)     NOT NULL,
    PhuongPhapTinhPhi           NVARCHAR(20)      NOT NULL DEFAULT 'BANG_TRA',
    -- BANG_TRA | CONG_THUC | API_TRUCTUYEN
    CauHinhTinhPhi              NVARCHAR(MAX)     NULL,  -- JSON
    PhiToiThieu                 DECIMAL(18,2)     NULL,
    PhiToiDa                    DECIMAL(18,2)     NULL,
    DonViPhi                    NVARCHAR(20)      NOT NULL DEFAULT 'VND',
    BangTraPhi                  NVARCHAR(MAX)     NULL,  -- JSON bang tra phi
    SoNgayToiThieu              INT               NULL,
    SoNgayToiDa                 INT               NULL,
    SoNgayMacDinh               INT               NULL DEFAULT 365,
    ChoPhepTuyChinhThoiHan      BIT               NOT NULL DEFAULT 0,
    SoTienBHToiThieu            DECIMAL(18,2)     NULL,
    SoTienBHToiDa               DECIMAL(18,2)     NULL,
    ChoPhepTraGop               BIT               NOT NULL DEFAULT 0,
    -- JSON: {"tuyChon":[{"soKy":1,"nhan":"1 lan"},
    --   {"soKy":4,"nhan":"4 ky/nam","tyLePhuPhi":0.02}]}
    CauHinhTraGop               NVARCHAR(MAX)     NULL,
    -- JSON: [{"ma":"CCCD","ten":"CCCD/CMND","batBuoc":true},
    --        {"ma":"CAVET","ten":"Cavet xe","batBuoc":true}]
    GiayToYeuCau                NVARCHAR(MAX)     NULL,
    UrlMauHopDong               NVARCHAR(500)     NULL,
    UrlMauGiayChungNhan         NVARCHAR(500)     NULL,
    CacTruongGhep               NVARCHAR(MAX)     NULL,  -- JSON mapping
    UrlAnhDaiDien               NVARCHAR(500)     NULL,
    UrlBanner                   NVARCHAR(500)     NULL,
    NhanGan                     NVARCHAR(500)     NULL,
    ThuTuHienThi                INT               NOT NULL DEFAULT 0,
    LaSanPhamNoiBat             BIT               NOT NULL DEFAULT 0,
    TrangThai                   NVARCHAR(20)      NOT NULL DEFAULT 'NHAP',
    -- NHAP | CHO_DUYET | DA_DUYET | HOATDONG | TAM_NGUNG | HET_HAN
    NguoiDuyet                  UNIQUEIDENTIFIER  NULL,
    NgayDuyet                   DATETIME2         NULL,
    HieuLucTu                   DATE              NULL,
    HieuLucDen                  DATE              NULL,
    MaSanPhamNCC                NVARCHAR(100)     NULL,
    TenSanPhamNCC               NVARCHAR(255)     NULL,
    NgayTao                     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao                    UNIQUEIDENTIFIER  NULL,
    NgayCapNhat                 DATETIME2         NULL,
    NguoiCapNhat                UNIQUEIDENTIFIER  NULL,
    DaXoa                       BIT               NOT NULL DEFAULT 0,
    CONSTRAINT PK_SanPhamGoc PRIMARY KEY (Ma),
    CONSTRAINT UQ_SanPhamGoc_MaSP UNIQUE (MaSanPham)
);
GO

-- ============================================================
-- BANG: GoiSanPham
-- Cac goi (Bronze/Silver/Gold) cua mot san pham
-- ============================================================
CREATE TABLE GoiSanPham (
    Ma                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaSanPhamGoc        UNIQUEIDENTIFIER  NOT NULL REFERENCES SanPhamGoc(Ma),
    MaGoi               NVARCHAR(50)      NOT NULL,
    -- DONGCO | BACDO | VANG | COBANG | CAOCAP
    TenGoi              NVARCHAR(255)     NOT NULL,
    TenGoiEN            NVARCHAR(255)     NULL,
    MoTa                NVARCHAR(MAX)     NULL,
    TomTatQuyenLoi      NVARCHAR(MAX)     NULL,  -- JSON
    ChiTietQuyenLoi     NVARCHAR(MAX)     NULL,  -- JSON
    TyLeBaoPhi          DECIMAL(5,2)      NULL,
    SoTienBaoHiem       DECIMAL(18,2)     NULL,
    PhiPhuThem          NVARCHAR(MAX)     NULL,  -- JSON
    HeSoNhanPhi         DECIMAL(5,3)      NULL DEFAULT 1.0,
    QuyenLoiMoRong      NVARCHAR(MAX)     NULL,  -- JSON
    LaGoiDeXuat         BIT               NOT NULL DEFAULT 0,
    ThuTuHienThi        INT               NOT NULL DEFAULT 0,
    DangHoatDong        BIT               NOT NULL DEFAULT 1,
    MaGoiNCC            NVARCHAR(50)      NULL,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat         DATETIME2         NULL,
    CONSTRAINT PK_GoiSanPham PRIMARY KEY (Ma),
    CONSTRAINT UQ_GoiSanPham_Ma UNIQUE (MaSanPhamGoc, MaGoi)
);
GO

-- ============================================================
-- BANG: BangGiaPhi
-- Bang tra phi bao hiem theo dieu kien
-- ============================================================
CREATE TABLE BangGiaPhi (
    Ma                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaSanPhamGoc        UNIQUEIDENTIFIER  NOT NULL REFERENCES SanPhamGoc(Ma),
    MaGoi               UNIQUEIDENTIFIER  NULL REFERENCES GoiSanPham(Ma),
    KhoaDieuKien1       NVARCHAR(100)     NULL,
    GiaTriDieuKien1     NVARCHAR(100)     NULL,
    KhoaDieuKien2       NVARCHAR(100)     NULL,
    GiaTriDieuKien2     NVARCHAR(100)     NULL,
    KhoaDieuKien3       NVARCHAR(100)     NULL,
    GiaTriDieuKien3     NVARCHAR(100)     NULL,
    KhoaDieuKien4       NVARCHAR(100)     NULL,
    GiaTriDieuKien4     NVARCHAR(100)     NULL,
    LoaiPhi             NVARCHAR(20)      NOT NULL DEFAULT 'CO_DINH',
    -- CO_DINH | TY_LE_PHAN_TRAM
    PhiCoDinh           DECIMAL(18,2)     NULL,
    TyLePhi             DECIMAL(8,6)      NULL,
    PhiToiThieu         DECIMAL(18,2)     NULL,
    PhiToiDa            DECIMAL(18,2)     NULL,
    HieuLucTu           DATE              NOT NULL,
    HieuLucDen          DATE              NULL,
    DangHoatDong        BIT               NOT NULL DEFAULT 1,
    MaLoNhap            NVARCHAR(50)      NULL,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_BangGiaPhi PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: LichSuPhienBanSanPham
-- Theo doi moi thay doi cua san pham qua cac phien ban
-- ============================================================
CREATE TABLE LichSuPhienBanSanPham (
    Ma              BIGINT            NOT NULL IDENTITY(1,1),
    MaSanPhamGoc    UNIQUEIDENTIFIER  NOT NULL REFERENCES SanPhamGoc(Ma),
    SoPhienBan      INT               NOT NULL,
    LoaiThayDoi     NVARCHAR(30)      NOT NULL,
    TomTatThayDoi   NVARCHAR(500)     NULL,
    DuLieuCu        NVARCHAR(MAX)     NULL,
    DuLieuMoi       NVARCHAR(MAX)     NULL,
    HieuLucTu       DATE              NOT NULL,
    NguoiThayDoi    UNIQUEIDENTIFIER  NULL,
    NgayThayDoi     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiDuyet      UNIQUEIDENTIFIER  NULL,
    GhiChu          NVARCHAR(MAX)     NULL,
    CONSTRAINT PK_LichSuPhienBanSanPham PRIMARY KEY (Ma)
);
GO
