-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHI NHANH (TENANT)
-- FILE: 02_DaiLy.sql
-- MO TA: DaiLy, LichSuCapBacDaiLy
-- ============================================================
GO

-- ============================================================
-- BANG: DaiLy
-- Thong tin day du cua dai ly bao hiem
-- ============================================================
CREATE TABLE DaiLy (
    Ma                          UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh                  UNIQUEIDENTIFIER  NOT NULL,
    MaNguoiDung                 UNIQUEIDENTIFIER  NOT NULL,
    MaDaiLy                     NVARCHAR(50)      NOT NULL,
    HoTen                       NVARCHAR(255)     NOT NULL,
    NgaySinh                    DATE              NULL,
    GioiTinh                    NVARCHAR(10)      NULL,
    -- NAM | NU | KHAC
    UrlAnhDaiDien               NVARCHAR(500)     NULL,
    SoDienThoai                 NVARCHAR(20)      NOT NULL,
    SdtPhu                      NVARCHAR(20)      NULL,
    Email                       NVARCHAR(255)     NOT NULL,
    MaZalo                      NVARCHAR(100)     NULL,
    SoCMND                      NVARCHAR(20)      NOT NULL,
    NgayCapCMND                 DATE              NULL,
    NoiCapCMND                  NVARCHAR(255)     NULL,
    UrlMatTruocCMND             NVARCHAR(500)     NULL,
    UrlMatSauCMND               NVARCHAR(500)     NULL,
    DiaChiThuongTru             NVARCHAR(500)     NULL,
    DiaChiHienTai               NVARCHAR(500)     NULL,
    TinhThanh                   NVARCHAR(100)     NULL,
    QuanHuyen                   NVARCHAR(100)     NULL,
    MaDonViToChuc               UNIQUEIDENTIFIER  NULL REFERENCES DonViToChuc(Ma),
    MaCapBac                    UNIQUEIDENTIFIER  NULL REFERENCES CapBacDaiLy(Ma),
    MaDaiLyCha                  UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Ma),
    MaDaiLyCapTren2             UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Ma),
    MaDaiLyCapTren3             UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Ma),
    DuongDanPhanCap             NVARCHAR(500)     NULL,
    SoGiayPhepHanhNghe          NVARCHAR(100)     NULL,
    LoaiGiayPhep                NVARCHAR(50)      NULL,
    NgayCapGP                   DATE              NULL,
    NgayHetHanGP                DATE              NULL,
    UrlFileGiayPhep             NVARCHAR(500)     NULL,
    TenNganHang                 NVARCHAR(100)     NULL,
    MaNganHang                  NVARCHAR(20)      NULL,
    SoTaiKhoanNH                NVARCHAR(50)      NULL,
    TenTaiKhoanNH               NVARCHAR(255)     NULL,
    ChiNhanhNH                  NVARCHAR(200)     NULL,
    KinhNghiemTruocDo           NVARCHAR(MAX)     NULL,
    TrinhDoHocVan               NVARCHAR(50)      NULL,
    ChuyenMon                   NVARCHAR(255)     NULL,
    TenMienCaNhan               NVARCHAR(100)     NULL,
    MaTrangCaNhan               UNIQUEIDENTIFIER  NULL,
    MaDaiLyGioiThieu            UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Ma),
    NgayGioiThieu               DATE              NULL,
    NgayThamGia                 DATE              NULL,
    MucTieuDoanhThuThang        DECIMAL(18,2)     NULL,
    MucTieuDoanhThuNam          DECIMAL(18,2)     NULL,
    MucTieuHopDongThang         INT               NULL,
    TongDoanhThuTuDau           DECIMAL(18,2)     NOT NULL DEFAULT 0,
    DoanhThuThangHienTai        DECIMAL(18,2)     NOT NULL DEFAULT 0,
    DoanhThuNamHienTai          DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongHopDongTuDau            INT               NOT NULL DEFAULT 0,
    HopDongThangHienTai         INT               NOT NULL DEFAULT 0,
    TongKhachHang               INT               NOT NULL DEFAULT 0,
    TongDaiLyCapDuoi            INT               NOT NULL DEFAULT 0,
    LanCapNhatThongKe           DATETIME2         NULL,
    TrangThai                   NVARCHAR(20)      NOT NULL DEFAULT 'HOATDONG',
    -- HOATDONG | TAM_NGUNG | DA_NGHI | CHO_DUYET
    TrangThaiOnboarding         NVARCHAR(30)      NOT NULL DEFAULT 'CHUA_HOAN_TAT',
    -- CHUA_HOAN_TAT | DA_HOAN_TAT | DANG_XU_LY
    NgayNghiViec                DATE              NULL,
    LyDoNghiViec                NVARCHAR(500)     NULL,
    GhiChu                      NVARCHAR(MAX)     NULL,
    GhiChuNoiBo                 NVARCHAR(MAX)     NULL,
    NgayTao                     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao                    UNIQUEIDENTIFIER  NULL,
    NgayCapNhat                 DATETIME2         NULL,
    NguoiCapNhat                UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_DaiLy PRIMARY KEY (Ma),
    CONSTRAINT UQ_DaiLy_MaDL UNIQUE (MaChiNhanh, MaDaiLy),
    CONSTRAINT UQ_DaiLy_NguoiDung UNIQUE (MaNguoiDung)
);
GO

-- ============================================================
-- BANG: LichSuCapBacDaiLy
-- Ghi nhan moi thay doi cap bac cua dai ly
-- ============================================================
CREATE TABLE LichSuCapBacDaiLy (
    Ma              BIGINT            NOT NULL IDENTITY(1,1),
    MaDaiLy         UNIQUEIDENTIFIER  NOT NULL REFERENCES DaiLy(Ma),
    MaCapBacCu      UNIQUEIDENTIFIER  NULL REFERENCES CapBacDaiLy(Ma),
    MaCapBacMoi     UNIQUEIDENTIFIER  NOT NULL REFERENCES CapBacDaiLy(Ma),
    LoaiThayDoi     NVARCHAR(20)      NOT NULL,
    -- THANG_CAP | HA_CAP | GAN_LAN_DAU | DIEU_CHINH
    LyDoThayDoi     NVARCHAR(500)     NULL,
    MinhChung       NVARCHAR(MAX)     NULL,
    NguoiThayDoi    UNIQUEIDENTIFIER  NULL,
    NgayThayDoi     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    HieuLucTu       DATE              NOT NULL,
    CONSTRAINT PK_LichSuCapBacDaiLy PRIMARY KEY (Ma)
);
GO
