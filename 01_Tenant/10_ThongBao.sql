-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHI NHANH (TENANT)
-- FILE: 10_ThongBao.sql
-- MO TA: ThongBao, MauThongBao, LichSuGuiThongBao
-- ============================================================
GO

-- ============================================================
-- BANG: MauThongBao
-- Mau thong bao theo su kien he thong
-- ============================================================
CREATE TABLE MauThongBao (
    Ma              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh      UNIQUEIDENTIFIER  NOT NULL,
    MaMau           NVARCHAR(50)      NOT NULL,
    TenMau          NVARCHAR(255)     NOT NULL,
    LoaiSuKien      NVARCHAR(50)      NOT NULL,
    -- HOPDONG_MOI | THANHTOAN_THANH_CONG | HOAHONG_DA_TRA
    -- SAPHETHAN_HOPDONG | LEAD_MOI | THANGCAP_DAILY | HE_THONG
    KenhGui         NVARCHAR(20)      NOT NULL,
    -- TRONG_APP | EMAIL | SMS | ZALO | PUSH | TAT_CA
    TieuDeMau       NVARCHAR(500)     NOT NULL,
    NoiDungMau      NVARCHAR(MAX)     NOT NULL,
    CacBienDongMau  NVARCHAR(MAX)     NULL,  -- JSON danh sach bien
    DangHoatDong    BIT               NOT NULL DEFAULT 1,
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat     DATETIME2         NULL,
    CONSTRAINT PK_MauThongBao PRIMARY KEY (Ma),
    CONSTRAINT UQ_MauThongBao UNIQUE (MaChiNhanh, MaMau)
);
GO

-- ============================================================
-- BANG: ThongBao
-- Thong bao gui den nguoi dung
-- ============================================================
CREATE TABLE ThongBao (
    Ma                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh          UNIQUEIDENTIFIER  NOT NULL,
    MaNguoiNhan         UNIQUEIDENTIFIER  NOT NULL,
    LoaiNguoiNhan       NVARCHAR(20)      NOT NULL,
    -- DAI_LY | KHACH_HANG | QUAN_LY | TAT_CA
    TieuDe              NVARCHAR(500)     NOT NULL,
    NoiDung             NVARCHAR(MAX)     NOT NULL,
    NoiDungNgan         NVARCHAR(255)     NULL,
    LoaiThongBao        NVARCHAR(30)      NOT NULL,
    -- THONG_TIN | CANH_BAO | THANH_CONG | LOI | NHAC_NHO
    MucDoUuTien         NVARCHAR(10)      NOT NULL DEFAULT 'BINH_THUONG',
    -- CAO | BINH_THUONG | THAP
    UrlHanhDong         NVARCHAR(500)     NULL,
    TextHanhDong        NVARCHAR(100)     NULL,
    UrlAnhMinhHoa       NVARCHAR(500)     NULL,
    DuLieuThamChieu     NVARCHAR(MAX)     NULL,  -- JSON
    DaDoc               BIT               NOT NULL DEFAULT 0,
    NgayDoc             DATETIME2         NULL,
    DaXoa               BIT               NOT NULL DEFAULT 0,
    NgayXoa             DATETIME2         NULL,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayHetHan          DATETIME2         NULL,
    CONSTRAINT PK_ThongBao PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: LichSuGuiThongBao
-- Ghi nhan tung lan gui thong bao qua cac kenh
-- ============================================================
CREATE TABLE LichSuGuiThongBao (
    Ma              BIGINT            NOT NULL IDENTITY(1,1),
    MaThongBao      UNIQUEIDENTIFIER  NOT NULL REFERENCES ThongBao(Ma),
    MaChiNhanh      UNIQUEIDENTIFIER  NOT NULL,
    KenhGui         NVARCHAR(20)      NOT NULL,
    -- TRONG_APP | EMAIL | SMS | ZALO | PUSH
    DiaChiGui       NVARCHAR(255)     NULL,
    TrangThai       NVARCHAR(20)      NOT NULL DEFAULT 'CHO_GUI',
    -- CHO_GUI | DA_GUI | THAT_BAI | DA_DOC
    NgayGui         DATETIME2         NULL,
    NgayThatBai     DATETIME2         NULL,
    LyDoThatBai     NVARCHAR(500)     NULL,
    MaNhaCungCapGui NVARCHAR(50)      NULL,
    MaGDNCC         NVARCHAR(200)     NULL,
    SoLanThuLai     INT               NOT NULL DEFAULT 0,
    NgayTao         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_LichSuGuiThongBao PRIMARY KEY (Ma)
);
GO
