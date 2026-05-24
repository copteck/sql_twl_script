-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHI NHANH (TENANT)
-- FILE: 09_TrangDich.sql
-- MO TA: MauTrangDich, TrangDich, LeadTrangDich, LuotXemTrangDich
-- ============================================================
GO

-- ============================================================
-- BANG: MauTrangDich
-- Mau giao dien cho cac landing page
-- ============================================================
CREATE TABLE MauTrangDich (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaMau           NVARCHAR(50)      NOT NULL,
    TenMau          NVARCHAR(255)     NOT NULL,
    DanhMuc         NVARCHAR(50)      NULL,
    UrlAnhXemTruoc  NVARCHAR(500)     NULL,
    UrlTrangXemTruoc NVARCHAR(500)    NULL,
    CauHinhBoCuc    NVARCHAR(MAX)     NOT NULL,  -- JSON
    DangHoatDong    BIT               NOT NULL DEFAULT 1,
    LaMauCaoCap     BIT               NOT NULL DEFAULT 0,
    SoLanSuDung     INT               NOT NULL DEFAULT 0,
    ThuTuHienThi    INT               NOT NULL DEFAULT 0,
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_MauTrangDich PRIMARY KEY (Ma),
    CONSTRAINT UQ_MauTrangDich_MaMau UNIQUE (MaMau)
);
GO

-- ============================================================
-- BANG: TrangDich
-- Landing page cua dai ly hoac chi nhanh
-- ============================================================
CREATE TABLE TrangDich (
    Ma                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh              UNIQUEIDENTIFIER  NOT NULL,
    MaDaiLy                 UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Ma),
    MaTrang                 NVARCHAR(50)      NOT NULL,
    TieuDeTrang             NVARCHAR(255)     NOT NULL,
    LoaiTrang               NVARCHAR(30)      NOT NULL,
    -- BAN_HANG | TUYEN_DUNG | GIOI_THIEU | KET_HOP | CHIEN_DICH
    TenMienPhu              NVARCHAR(100)     NULL,
    DuongDanTuyChinh        NVARCHAR(100)     NULL,
    UrlDayDu                NVARCHAR(500)     NULL,
    MaMau                   UNIQUEIDENTIFIER  NULL REFERENCES MauTrangDich(Ma),
    -- JSON: {"giaoDien":{...},"khoi":[{"ma":"k1","loai":"BannerChinh","thuTu":1,"thuocTinh":{...}},...]}
    CauHinhBoCuc            NVARCHAR(MAX)     NOT NULL,
    MaSanPhamNoiBat         NVARCHAR(MAX)     NULL,  -- JSON mang MaSanPhamGoc
    -- JSON: {"truong":["hoTen","sdt","email","nhuCau"],"tuDongGanDaiLy":true}
    CauHinhFormLead         NVARCHAR(MAX)     NULL,
    TieuDeSEO              NVARCHAR(255)     NULL,
    MoTaSEO                NVARCHAR(500)     NULL,
    TuKhoaSEO              NVARCHAR(500)     NULL,
    UrlAnhOG                NVARCHAR(500)     NULL,
    MaFacebookPixel         NVARCHAR(100)     NULL,
    MaGoogleAnalytics       NVARCHAR(50)      NULL,
    MaZaloOA                NVARCHAR(100)     NULL,
    TongLuotXem             BIGINT            NOT NULL DEFAULT 0,
    LuotXemDuyNhat          BIGINT            NOT NULL DEFAULT 0,
    TongLead                INT               NOT NULL DEFAULT 0,
    TongHopDong             INT               NOT NULL DEFAULT 0,
    TyLeChuyenDoi           DECIMAL(5,4)      NULL,
    TrangThai               NVARCHAR(20)      NOT NULL DEFAULT 'NHAP',
    -- NHAP | DA_XUAT_BAN | TAM_NGUNG | DA_GO
    NgayXuatBan             DATETIME2         NULL,
    NgayGoXuong             DATETIME2         NULL,
    NgayTao                 DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat             DATETIME2         NULL,
    CONSTRAINT PK_TrangDich PRIMARY KEY (Ma),
    CONSTRAINT UQ_TrangDich_MaTrang UNIQUE (MaChiNhanh, MaTrang)
);
GO

-- ============================================================
-- BANG: LeadTrangDich
-- Khach hang tiem nang den tu trang dich
-- ============================================================
CREATE TABLE LeadTrangDich (
    Ma                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh              UNIQUEIDENTIFIER  NOT NULL,
    MaTrangDich             UNIQUEIDENTIFIER  NOT NULL REFERENCES TrangDich(Ma),
    MaDaiLy                 UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Ma),
    HoTen                   NVARCHAR(255)     NOT NULL,
    SoDienThoai             NVARCHAR(20)      NOT NULL,
    Email                   NVARCHAR(255)     NULL,
    LoiNhan                 NVARCHAR(1000)    NULL,
    SanPhamQuanTam          NVARCHAR(255)     NULL,
    DuLieuForm              NVARCHAR(MAX)     NULL,  -- JSON
    DiaChiIP                NVARCHAR(50)      NULL,
    ThongTinTrinhDuyet      NVARCHAR(500)     NULL,
    UrlGioiThieu            NVARCHAR(500)     NULL,
    NguonUtm                NVARCHAR(100)     NULL,
    ChienDichUtm            NVARCHAR(100)     NULL,
    MaKhachHangChuyenDoi    UNIQUEIDENTIFIER  NULL REFERENCES KhachHang(Ma),
    MaKeHoachChuyenDoi      UNIQUEIDENTIFIER  NULL,
    NgayChuyenDoi           DATETIME2         NULL,
    TrangThai               NVARCHAR(20)      NOT NULL DEFAULT 'MOI',
    -- MOI | DA_LIEN_HE | DA_CHUYEN_DOI | KHONG_HOP_LE | TRUNG_LAP
    NgayTao                 DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_LeadTrangDich PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: LuotXemTrangDich
-- Thong ke luot xem chi tiet
-- ============================================================
CREATE TABLE LuotXemTrangDich (
    Ma              BIGINT            NOT NULL IDENTITY(1,1),
    MaTrangDich     UNIQUEIDENTIFIER  NOT NULL REFERENCES TrangDich(Ma),
    MaChiNhanh      UNIQUEIDENTIFIER  NOT NULL,
    MaPhien         NVARCHAR(100)     NULL,
    DiaChiIP        NVARCHAR(50)      NULL,
    ThongTinTrinhDuyet NVARCHAR(500)  NULL,
    UrlGioiThieu    NVARCHAR(500)     NULL,
    NguonUtm        NVARCHAR(100)     NULL,
    KenhUtm         NVARCHAR(100)     NULL,
    ChienDichUtm    NVARCHAR(100)     NULL,
    QuocGia         NVARCHAR(50)      NULL,
    ThanhPho        NVARCHAR(100)     NULL,
    LoaiThietBi     NVARCHAR(20)      NULL,
    -- MAY_TINH | DIEN_THOAI | MAYBANG
    ThoiGianXem     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    ThoiLuongXem_Giay INT             NULL,
    CONSTRAINT PK_LuotXemTrangDich PRIMARY KEY (Ma)
);
GO
