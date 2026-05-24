-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHI NHANH (TENANT)
-- FILE: 06_ThanhToan.sql
-- MO TA: GiaoDichThanhToan, NhatKyWebhook, LichTraGop
-- ============================================================
GO

-- ============================================================
-- BANG: GiaoDichThanhToan
-- Moi giao dich thanh toan cua khach hang
-- ============================================================
CREATE TABLE GiaoDichThanhToan (
    Ma                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh              UNIQUEIDENTIFIER  NOT NULL,
    MaGiaoDich              NVARCHAR(100)     NOT NULL,
    MaHopDong               UNIQUEIDENTIFIER  NOT NULL REFERENCES HopDong(Ma),
    MaKhachHang             UNIQUEIDENTIFIER  NOT NULL REFERENCES KhachHang(Ma),
    MaDaiLy                 UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Ma),
    SoTien                  DECIMAL(18,2)     NOT NULL,
    DonViTien               NVARCHAR(10)      NOT NULL DEFAULT 'VND',
    LoaiThanhToan           NVARCHAR(20)      NOT NULL,
    -- LAN_DAU | TRA_GOP_KY | TAI_TUC | PHI_PHAT_SINH
    SoKyTraGop              INT               NULL,
    PhuongThucThanhToan     NVARCHAR(30)      NOT NULL,
    -- CHUYEN_KHOAN | THE_QUOC_TE | VI_DIEN_TU | TIEN_MAT | QR_CODE
    CongThanhToan           NVARCHAR(30)      NULL,
    -- VNPAY | MOMO | ZALOPAY | VIETQR | ONEPAY | KHAC
    MaGDCongThanhToan       NVARCHAR(200)     NULL,
    MaDonHangCong           NVARCHAR(200)     NULL,
    UrlThanhToan            NVARCHAR(500)     NULL,
    TrangThaiCong           NVARCHAR(50)      NULL,
    PhanHoiCong             NVARCHAR(MAX)     NULL,
    MaNganHang              NVARCHAR(50)      NULL,
    LoaiThe                 NVARCHAR(30)      NULL,
    SoTaiKhoan              NVARCHAR(50)      NULL,
    TrangThai               NVARCHAR(20)      NOT NULL DEFAULT 'CHO_XU_LY',
    -- CHO_XU_LY | DANG_XU_LY | THANH_CONG | THAT_BAI | HET_HAN | DA_HOAN
    NgayKhoiTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayHoanTat             DATETIME2         NULL,
    NgayHetHan              DATETIME2         NULL,
    NgayThatBai             DATETIME2         NULL,
    LyDoThatBai             NVARCHAR(500)     NULL,
    SoBienLai               NVARCHAR(100)     NULL,
    UrlBienLai              NVARCHAR(500)     NULL,
    SoHoaDon                NVARCHAR(100)     NULL,
    LaHoanTien              BIT               NOT NULL DEFAULT 0,
    MaGDHoanTienGoc         UNIQUEIDENTIFIER  NULL,
    LyDoHoanTien            NVARCHAR(500)     NULL,
    NgayHoanTien            DATETIME2         NULL,
    GhiChu                  NVARCHAR(500)     NULL,
    NgayTao                 DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat             DATETIME2         NULL,
    CONSTRAINT PK_GiaoDichThanhToan PRIMARY KEY (Ma),
    CONSTRAINT UQ_GiaoDich_MaGD UNIQUE (MaChiNhanh, MaGiaoDich)
);
GO

-- ============================================================
-- BANG: NhatKyWebhookThanhToan
-- Ghi nhan tat ca webhook tu cong thanh toan gui ve
-- ============================================================
CREATE TABLE NhatKyWebhookThanhToan (
    Ma              BIGINT            NOT NULL IDENTITY(1,1),
    MaChiNhanh      UNIQUEIDENTIFIER  NULL,
    CongThanhToan   NVARCHAR(30)      NOT NULL,
    LoaiSuKien      NVARCHAR(100)     NULL,
    NoiDungGoc      NVARCHAR(MAX)     NOT NULL,
    MaGDPhanTich    UNIQUEIDENTIFIER  NULL,
    DaXacThuc       BIT               NOT NULL DEFAULT 0,
    DaXuLy          BIT               NOT NULL DEFAULT 0,
    NgayXuLy        DATETIME2         NULL,
    LoiXuLy         NVARCHAR(500)     NULL,
    DiaChiIP        NVARCHAR(50)      NULL,
    NgayNhan        DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_NhatKyWebhookThanhToan PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: LichTraGop
-- Lich tra gop phi bao hiem theo ky
-- ============================================================
CREATE TABLE LichTraGop (
    Ma                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaHopDong           UNIQUEIDENTIFIER  NOT NULL REFERENCES HopDong(Ma),
    MaChiNhanh          UNIQUEIDENTIFIER  NOT NULL,
    SoKy               INT               NOT NULL,
    NgayDenHan          DATE              NOT NULL,
    SoTien              DECIMAL(18,2)     NOT NULL,
    TrangThai           NVARCHAR(20)      NOT NULL DEFAULT 'CHO_DONG',
    -- CHO_DONG | DA_DONG | QUA_HAN | DA_HUY
    SoTienDaDong        DECIMAL(18,2)     NOT NULL DEFAULT 0,
    NgayDong            DATETIME2         NULL,
    MaGiaoDich          UNIQUEIDENTIFIER  NULL REFERENCES GiaoDichThanhToan(Ma),
    NgayGuiNhacNho      DATETIME2         NULL,
    SoLanNhac           INT               NOT NULL DEFAULT 0,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_LichTraGop PRIMARY KEY (Ma)
);
GO
