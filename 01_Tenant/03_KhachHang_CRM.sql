-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHI NHANH (TENANT)
-- FILE: 03_KhachHang_CRM.sql
-- MO TA: KhachHang, LichSuLienHe, TaiLieuKhachHang
-- ============================================================
GO

-- ============================================================
-- BANG: KhachHang
-- Quan ly thong tin khach hang toan dien (CRM)
-- ============================================================
CREATE TABLE KhachHang (
    Ma                          UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh                  UNIQUEIDENTIFIER  NOT NULL,
    MaKhachHang                 NVARCHAR(50)      NOT NULL,
    LoaiKhachHang               NVARCHAR(20)      NOT NULL DEFAULT 'KHACH_VANGLAI',
    -- KHACH_VANGLAI | THANH_VIEN | VIP | DOANH_NGHIEP
    MaNguoiDung                 UNIQUEIDENTIFIER  NULL,
    HoTen                       NVARCHAR(255)     NOT NULL,
    NgaySinh                    DATE              NULL,
    GioiTinh                    NVARCHAR(10)      NULL,
    LoaiGiayTo                  NVARCHAR(20)      NULL,
    -- CCCD | CMND | HOCHIEU | GPKD
    SoGiayTo                    NVARCHAR(20)      NULL,
    NgayCapGiayTo               DATE              NULL,
    NoiCapGiayTo                NVARCHAR(255)     NULL,
    SoDienThoai                 NVARCHAR(20)      NOT NULL,
    SdtPhu                      NVARCHAR(20)      NULL,
    Email                       NVARCHAR(255)     NULL,
    MaZalo                      NVARCHAR(100)     NULL,
    DiaChi                      NVARCHAR(500)     NULL,
    PhuongXa                    NVARCHAR(100)     NULL,
    QuanHuyen                   NVARCHAR(100)     NULL,
    TinhThanh                   NVARCHAR(100)     NULL,
    NgheNghiep                  NVARCHAR(100)     NULL,
    MaNgheNghiep                NVARCHAR(20)      NULL,
    TenCongTy                   NVARCHAR(255)     NULL,
    ThongTinTaiSan              NVARCHAR(MAX)     NULL,
    TokenTraCuu                 NVARCHAR(100)     NULL,
    HanTokenTraCuu              DATETIME2         NULL,
    PhanKhucKhachHang           NVARCHAR(30)      NULL,
    -- MOI | TIEM_NANG | TRUNG_THANH | VIP | KHONG_HOATDONG
    DiemTiemNang                INT               NOT NULL DEFAULT 0,
    NhanGan                     NVARCHAR(MAX)     NULL,  -- JSON mang
    NguonKhachHang              NVARCHAR(50)      NULL,
    -- WEBSITE | ZALO | FACEBOOK | GIOI_THIEU | TRUC_TIEP | LANDING_PAGE
    ChiTietNguon                NVARCHAR(255)     NULL,
    MaDaiLyGioiThieu            UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Ma),
    MaKhachHangGioiThieu        UNIQUEIDENTIFIER  NULL REFERENCES KhachHang(Ma),
    MaTrangDich                 UNIQUEIDENTIFIER  NULL,
    NguonUtm                    NVARCHAR(100)     NULL,
    KenhUtm                     NVARCHAR(100)     NULL,
    ChienDichUtm                NVARCHAR(100)     NULL,
    NoiDungUtm                  NVARCHAR(100)     NULL,
    MaDaiLyPhuTrach             UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Ma),
    NgayGanDaiLy                DATETIME2         NULL,
    NhuCauBaoHiem               NVARCHAR(MAX)     NULL,
    NganSachDuKien              NVARCHAR(50)      NULL,
    ThoiGianLienHeTot           NVARCHAR(100)     NULL,
    KenhLienHeTot               NVARCHAR(50)      NULL,
    TongSoHopDong               INT               NOT NULL DEFAULT 0,
    HopDongConHieuLuc           INT               NOT NULL DEFAULT 0,
    TongPhiDaDong               DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongPhiHangNam              DECIMAL(18,2)     NOT NULL DEFAULT 0,
    DiemTichLuy                 INT               NOT NULL DEFAULT 0,
    LanMuaCuoi                  DATETIME2         NULL,
    LanLienHeCuoi               DATETIME2         NULL,
    NgayLenThanhVien            DATETIME2         NULL,
    GhiChu                      NVARCHAR(MAX)     NULL,
    GhiChuNoiBo                 NVARCHAR(MAX)     NULL,
    DangHoatDong                BIT               NOT NULL DEFAULT 1,
    BiChanDen                   BIT               NOT NULL DEFAULT 0,
    LyDoChanDen                 NVARCHAR(500)     NULL,
    NgayTao                     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat                 DATETIME2         NULL,
    CONSTRAINT PK_KhachHang PRIMARY KEY (Ma),
    CONSTRAINT UQ_KhachHang_MaKH UNIQUE (MaChiNhanh, MaKhachHang)
);
GO

-- ============================================================
-- BANG: LichSuLienHeKhachHang
-- Ghi nhan tat ca hoat dong lien he voi khach hang
-- ============================================================
CREATE TABLE LichSuLienHeKhachHang (
    Ma                  BIGINT            NOT NULL IDENTITY(1,1),
    MaKhachHang         UNIQUEIDENTIFIER  NOT NULL REFERENCES KhachHang(Ma),
    MaChiNhanh          UNIQUEIDENTIFIER  NOT NULL,
    MaDaiLy             UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Ma),
    LoaiLienHe          NVARCHAR(20)      NOT NULL,
    -- DIEN_THOAI | TIN_NHAN | EMAIL | GAP_TRUC_TIEP | ZALO | KHAC
    HuongLienHe         NVARCHAR(10)      NULL,
    -- DEN | DI
    ThoiLuong_Giay      INT               NULL,
    ChuDe               NVARCHAR(500)     NULL,
    NoiDung             NVARCHAR(MAX)     NULL,
    KetQua              NVARCHAR(50)      NULL,
    -- THANH_CONG | KHONG_NGHE | HEN_LAI | TU_CHOI | KHAC
    NgayHenLai          DATETIME2         NULL,
    GhiChuHenLai        NVARCHAR(500)     NULL,
    MaKeHoachBanHang    UNIQUEIDENTIFIER  NULL,
    MaHopDong           UNIQUEIDENTIFIER  NULL,
    LaHeThongTuTao      BIT               NOT NULL DEFAULT 0,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao            UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_LichSuLienHeKhachHang PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: TaiLieuKhachHang
-- Luu tru giay to/tai lieu cua khach hang
-- ============================================================
CREATE TABLE TaiLieuKhachHang (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaKhachHang     UNIQUEIDENTIFIER  NOT NULL REFERENCES KhachHang(Ma),
    MaChiNhanh      UNIQUEIDENTIFIER  NOT NULL,
    LoaiTaiLieu     NVARCHAR(50)      NOT NULL,
    -- CCCD | CMND | HOCHIEU | CAVET | DANG_KIEM | BANG_LAI | GIAY_KHAM | KHAC
    TenTaiLieu      NVARCHAR(255)     NULL,
    UrlFile         NVARCHAR(500)     NOT NULL,
    KichThuocFile   BIGINT            NULL,
    LoaiFile        NVARCHAR(100)     NULL,
    MaHopDong       UNIQUEIDENTIFIER  NULL,
    NguoiTaiLen     UNIQUEIDENTIFIER  NULL,
    NgayTaiLen      DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    DaXacMinh       BIT               NOT NULL DEFAULT 0,
    NguoiXacMinh    UNIQUEIDENTIFIER  NULL,
    NgayXacMinh     DATETIME2         NULL,
    NgayHetHan      DATE              NULL,
    DangHoatDong    BIT               NOT NULL DEFAULT 1,
    CONSTRAINT PK_TaiLieuKhachHang PRIMARY KEY (Ma)
);
GO
