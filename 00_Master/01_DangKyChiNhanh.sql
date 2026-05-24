-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHINH (MASTER)
-- FILE: 01_DangKyChiNhanh.sql
-- MO TA: Bang DangKyChiNhanh, CauHinhHeThong, GanSanPhamChiNhanh
-- ============================================================
USE TWL_MASTER;
GO

-- ============================================================
-- BANG: DangKyChiNhanh
-- Luu tru thong tin cac chi nhanh/doi tac trong he thong
-- ============================================================
CREATE TABLE DangKyChiNhanh (
    Ma                          UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh                  NVARCHAR(50)      NOT NULL,
    TenChiNhanh                 NVARCHAR(255)     NOT NULL,
    TenChiNhanhTiengAnh         NVARCHAR(255)     NULL,
    CapChiNhanh                 TINYINT           NOT NULL,
    -- 0=TruSoChinh, 1=ChiNhanh, 2=Nhom, 3=Doi, 4=DaiLyCaNhan
    LoaiChiNhanh                NVARCHAR(30)      NOT NULL,
    -- TRUSOCHINH | CONGTY | CHINHANH | NHOM | DOI | CANHAN
    TenMienPhu                  NVARCHAR(100)     NOT NULL,
    TenMienRieng                NVARCHAR(255)     NULL,
    TenMienPhuDangHoatDong      BIT               NOT NULL DEFAULT 1,
    TenMayChuCSDL               NVARCHAR(255)     NOT NULL,
    CongMayChu                  INT               NOT NULL DEFAULT 1433,
    TenCSDL                     NVARCHAR(100)     NOT NULL,
    ChuoiKetNoiMaHoa            NVARCHAR(MAX)     NOT NULL,
    ChuoiDocDuPhongMaHoa        NVARCHAR(MAX)     NULL,
    MaChiNhanhCha               UNIQUEIDENTIFIER  NULL REFERENCES DangKyChiNhanh(Ma),
    MaChiNhanhGoc               UNIQUEIDENTIFIER  NOT NULL,
    DuongDanPhanCap             NVARCHAR(500)     NULL,
    CapPhanCap                  INT               NOT NULL DEFAULT 1,
    TenPhapLy                   NVARCHAR(255)     NULL,
    MaSoThue                    NVARCHAR(20)      NULL,
    GiayPhepKinhDoanh           NVARCHAR(100)     NULL,
    NgayHetHanGPKD              DATE              NULL,
    TenNguoiDaiDien             NVARCHAR(255)     NULL,
    SdtNguoiDaiDien             NVARCHAR(20)      NULL,
    EmailNguoiDaiDien           NVARCHAR(255)     NULL,
    DiaChi                      NVARCHAR(500)     NULL,
    PhuongXa                    NVARCHAR(100)     NULL,
    QuanHuyen                   NVARCHAR(100)     NULL,
    TinhThanh                   NVARCHAR(100)     NULL,
    ViDo                        DECIMAL(10,8)     NULL,
    KinhDo                      DECIMAL(11,8)     NULL,
    UrlLogo                     NVARCHAR(500)     NULL,
    UrlFavicon                  NVARCHAR(500)     NULL,
    MauChinh                    NVARCHAR(20)      NULL DEFAULT '#1D4ED8',
    MauPhu                      NVARCHAR(20)      NULL DEFAULT '#06B6D4',
    CauHinhGiaoDien             NVARCHAR(MAX)     NULL,
    SoDienThoai                 NVARCHAR(20)      NULL,
    Email                       NVARCHAR(255)     NULL,
    MaZaloOA                    NVARCHAR(100)     NULL,
    MaFacebookPage              NVARCHAR(100)     NULL,
    DonViTienMacDinh            NVARCHAR(10)      NOT NULL DEFAULT 'VND',
    MuiGio                      NVARCHAR(50)      NOT NULL DEFAULT 'SE Asia Standard Time',
    ChuKyTraHoaHong             NVARCHAR(20)      NOT NULL DEFAULT 'HANGTHANG',
    NgayTraHoaHong              INT               NOT NULL DEFAULT 15,
    CapDaiLyToiDa               INT               NOT NULL DEFAULT 5,
    ChoPhepMuaKhongDangNhap     BIT               NOT NULL DEFAULT 1,
    YeuCauQuanLyDuyet           BIT               NOT NULL DEFAULT 0,
    TrangThai                   NVARCHAR(20)      NOT NULL DEFAULT 'HOATDONG',
    -- HOATDONG | TAMNGUNG | DADONGLAI
    NgayKichHoat                DATETIME2         NULL,
    NgayTamNgung                DATETIME2         NULL,
    LyDoTamNgung                NVARCHAR(500)     NULL,
    NgayTao                     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao                    UNIQUEIDENTIFIER  NULL,
    NgayCapNhat                 DATETIME2         NULL,
    NguoiCapNhat                UNIQUEIDENTIFIER  NULL,
    DaXoa                       BIT               NOT NULL DEFAULT 0,
    NgayXoa                     DATETIME2         NULL,
    CONSTRAINT PK_DangKyChiNhanh PRIMARY KEY (Ma),
    CONSTRAINT UQ_DangKyChiNhanh_MaCN UNIQUE (MaChiNhanh),
    CONSTRAINT UQ_DangKyChiNhanh_TenMienPhu UNIQUE (TenMienPhu)
);
GO

-- ============================================================
-- BANG: CauHinhHeThong
-- Cau hinh toan he thong va cau hinh rieng tung chi nhanh
-- ============================================================
CREATE TABLE CauHinhHeThong (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    KhoaCauHinh     NVARCHAR(200)     NOT NULL,
    GiaTriCauHinh   NVARCHAR(MAX)     NULL,
    LoaiCauHinh     NVARCHAR(20)      NOT NULL DEFAULT 'CHUOI',
    -- CHUOI | SO | BOOLEAN | JSON | MAHOA
    MoTa            NVARCHAR(500)     NULL,
    MaChiNhanh      UNIQUEIDENTIFIER  NULL REFERENCES DangKyChiNhanh(Ma),
    DuocMaHoa       BIT               NOT NULL DEFAULT 0,
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat     DATETIME2         NULL,
    NguoiCapNhat    UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_CauHinhHeThong PRIMARY KEY (Ma),
    CONSTRAINT UQ_CauHinh_Khoa_ChiNhanh UNIQUE (KhoaCauHinh, MaChiNhanh)
);
GO

-- ============================================================
-- BANG: GanSanPhamChiNhanh
-- Anh xa san pham nao duoc ban tai chi nhanh nao
-- ============================================================
CREATE TABLE GanSanPhamChiNhanh (
    Ma                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh          UNIQUEIDENTIFIER  NOT NULL REFERENCES DangKyChiNhanh(Ma),
    MaSanPhamGoc        UNIQUEIDENTIFIER  NOT NULL,
    DangHoatDong        BIT               NOT NULL DEFAULT 1,
    NgayKichHoat        DATETIME2         NULL,
    NgayNgungHoatDong   DATETIME2         NULL,
    LyDoNgung           NVARCHAR(500)     NULL,
    ThuTuHienThi        INT               NOT NULL DEFAULT 0,
    MoTaRieng           NVARCHAR(MAX)     NULL,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao            UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_GanSanPhamChiNhanh PRIMARY KEY (Ma),
    CONSTRAINT UQ_ChiNhanh_SanPham UNIQUE (MaChiNhanh, MaSanPhamGoc)
);
GO
