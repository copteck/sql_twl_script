-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHI NHANH (TENANT)
-- FILE: 07_HoaHong.sql
-- MO TA: SoHoaHong, LoHoaHong, DuBaoHoaHong
-- ============================================================
GO

-- ============================================================
-- BANG: SoHoaHong
-- Ghi nhan chi tiet tung dong hoa hong (so cai hoa hong)
-- ============================================================
CREATE TABLE SoHoaHong (
    Ma                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh              UNIQUEIDENTIFIER  NOT NULL,
    MaHopDong               UNIQUEIDENTIFIER  NOT NULL REFERENCES HopDong(Ma),
    MaDaiLyBan              UNIQUEIDENTIFIER  NOT NULL REFERENCES DaiLy(Ma),
    MaDaiLyHuongHH          UNIQUEIDENTIFIER  NOT NULL REFERENCES DaiLy(Ma),
    LoaiHoaHong             NVARCHAR(20)      NOT NULL,
    -- TRUC_TIEP | GIAN_TIEP_CAP1 | GIAN_TIEP_CAP2 | GIAN_TIEP_CAP3 | THUONG_KY
    CapGianTiep             INT               NULL,
    PhiGocHopDong           DECIMAL(18,2)     NOT NULL,
    TyLeHoaHong             DECIMAL(6,5)      NOT NULL,
    HoaHongGop              DECIMAL(18,2)     NOT NULL,
    TyLeThue                DECIMAL(5,4)      NOT NULL DEFAULT 0.10,
    SoTienThue              DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongRong             DECIMAL(18,2)     NOT NULL,
    NamKy                   INT               NOT NULL,
    ThangKy                 INT               NOT NULL,
    TrangThai               NVARCHAR(20)      NOT NULL DEFAULT 'CHO_XU_LY',
    -- CHO_XU_LY | DA_TINH | DA_DUYET | DA_CHI_TRA | DA_HUY
    NgayDoiTrangThai        DATETIME2         NULL,
    NguoiDoiTrangThai       UNIQUEIDENTIFIER  NULL,
    NgayDuyet               DATETIME2         NULL,
    NguoiDuyet              UNIQUEIDENTIFIER  NULL,
    MaLo                    UNIQUEIDENTIFIER  NULL,
    MaSoLo                  NVARCHAR(50)      NULL,
    NgayChiTra              DATETIME2         NULL,
    SoChungTuChiTra         NVARCHAR(100)     NULL,
    NgayHuy                 DATETIME2         NULL,
    LyDoHuy                 NVARCHAR(500)     NULL,
    GhiChu                  NVARCHAR(500)     NULL,
    NgayTao                 DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat             DATETIME2         NULL,
    CONSTRAINT PK_SoHoaHong PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: LoHoaHong
-- Quan ly tung lo chi tra hoa hong theo ky
-- ============================================================
CREATE TABLE LoHoaHong (
    Ma                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh          UNIQUEIDENTIFIER  NOT NULL,
    MaSoLo              NVARCHAR(50)      NOT NULL,
    NamKy               INT               NOT NULL,
    ThangKy             INT               NOT NULL,
    TongSoDaiLy         INT               NOT NULL DEFAULT 0,
    TongSoHopDong       INT               NOT NULL DEFAULT 0,
    TongHoaHongGop      DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongThue            DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TongHoaHongRong     DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TrangThai           NVARCHAR(20)      NOT NULL DEFAULT 'NHAP',
    -- NHAP | DANG_TINH | DA_TINH | CHO_DUYET | DA_DUYET | DANG_CHI_TRA | DA_CHI_TRA
    NguoiLap            UNIQUEIDENTIFIER  NULL,
    NgayLap             DATETIME2         NULL,
    NguoiKiemTra        UNIQUEIDENTIFIER  NULL,
    NgayKiemTra         DATETIME2         NULL,
    NguoiDuyet          UNIQUEIDENTIFIER  NULL,
    NgayDuyet           DATETIME2         NULL,
    NguoiChiTra         UNIQUEIDENTIFIER  NULL,
    NgayChiTra          DATETIME2         NULL,
    GhiChu              NVARCHAR(MAX)     NULL,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat         DATETIME2         NULL,
    CONSTRAINT PK_LoHoaHong PRIMARY KEY (Ma),
    CONSTRAINT UQ_LoHoaHong UNIQUE (MaChiNhanh, MaSoLo)
);
GO

-- ============================================================
-- BANG: DuBaoHoaHong
-- Du bao hoa hong hang thang cho tung dai ly
-- ============================================================
CREATE TABLE DuBaoHoaHong (
    Ma                          UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh                  UNIQUEIDENTIFIER  NOT NULL,
    MaDaiLy                     UNIQUEIDENTIFIER  NOT NULL REFERENCES DaiLy(Ma),
    NamKy                       INT               NOT NULL,
    ThangKy                     INT               NOT NULL,
    SoHDDuBao                   INT               NOT NULL DEFAULT 0,
    DoanhThuDuBao               DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongDuBao                DECIMAL(18,2)     NOT NULL DEFAULT 0,
    SoHDXacNhan                 INT               NOT NULL DEFAULT 0,
    DoanhThuXacNhan             DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongXacNhan              DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongThucTe               DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongBiHuy                DECIMAL(18,2)     NOT NULL DEFAULT 0,
    HoaHongChoNCCXacNhan        DECIMAL(18,2)     NOT NULL DEFAULT 0,
    LanTinhGanNhat              DATETIME2         NULL,
    CONSTRAINT PK_DuBaoHoaHong PRIMARY KEY (Ma),
    CONSTRAINT UQ_DuBaoHoaHong UNIQUE (MaChiNhanh, MaDaiLy, NamKy, ThangKy)
);
GO
