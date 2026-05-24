-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHI NHANH (TENANT)
-- FILE: 04_KeHoachBanHang.sql
-- MO TA: KeHoachBanHang, HoatDongBanHang, BaoGia
-- ============================================================
GO

-- ============================================================
-- BANG: KeHoachBanHang
-- Quan ly pipeline ban hang tu lead den chot deal
-- ============================================================
CREATE TABLE KeHoachBanHang (
    Ma                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh              UNIQUEIDENTIFIER  NOT NULL,
    MaKeHoach               NVARCHAR(50)      NOT NULL,
    MaKhachHang             UNIQUEIDENTIFIER  NOT NULL REFERENCES KhachHang(Ma),
    MaDaiLy                 UNIQUEIDENTIFIER  NOT NULL REFERENCES DaiLy(Ma),
    MaSanPhamGoc            UNIQUEIDENTIFIER  NULL,
    MaGoiSanPham            UNIQUEIDENTIFIER  NULL,
    SanPhamQuanTam          NVARCHAR(MAX)     NULL,  -- JSON
    GiaiDoan                NVARCHAR(30)      NOT NULL DEFAULT 'MOI',
    -- MOI | DA_LIEN_HE | DANG_TU_VAN | DA_BAO_GIA | DANG_DAM_PHAN
    -- DA_DONG_Y | DANG_XU_LY | HOAN_TAT | THAT_BAI
    NgayDoiGiaiDoan         DATETIME2         NULL,
    NguoiDoiGiaiDoan        UNIQUEIDENTIFIER  NULL,
    GiaiDoanTruoc           NVARCHAR(30)      NULL,
    LyDoThatBai             NVARCHAR(50)      NULL,
    -- GIA_CAO | KHONG_CAN | CHON_NCC_KHAC | KHONG_LIEN_LAC_DUOC | KHAC
    GhiChuThatBai           NVARCHAR(500)     NULL,
    PhiDuKien               DECIMAL(18,2)     NULL,
    NgayChotDuKien          DATE              NULL,
    XacSuatChot             INT               NULL,  -- 0-100%
    MaHopDongKetQua         UNIQUEIDENTIFIER  NULL,
    HanLienHeDauTien        DATETIME2         NULL,
    NgayLienHeDauTien       DATETIME2         NULL,
    TrangThaiSLA            NVARCHAR(20)      NULL,
    -- DUNG_HAN | SAP_TRE | DA_TRE
    NguonLead               NVARCHAR(50)      NULL,
    ChiTietNguonLead        NVARCHAR(255)     NULL,
    MucDoUuTien             NVARCHAR(10)      NOT NULL DEFAULT 'BINH_THUONG',
    -- KHAN_CAP | CAO | BINH_THUONG | THAP
    GhiChu                  NVARCHAR(MAX)     NULL,
    NgayTao                 DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat             DATETIME2         NULL,
    NgayDongKeHoach         DATETIME2         NULL,
    CONSTRAINT PK_KeHoachBanHang PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: HoatDongBanHang
-- Lich su hoat dong trong pipeline ban hang
-- ============================================================
CREATE TABLE HoatDongBanHang (
    Ma                  BIGINT            NOT NULL IDENTITY(1,1),
    MaKeHoach           UNIQUEIDENTIFIER  NOT NULL REFERENCES KeHoachBanHang(Ma),
    MaChiNhanh          UNIQUEIDENTIFIER  NOT NULL,
    MaDaiLy             UNIQUEIDENTIFIER  NULL REFERENCES DaiLy(Ma),
    LoaiHoatDong        NVARCHAR(30)      NOT NULL,
    -- DOI_GIAI_DOAN | GOI_DIEN | GUI_TIN | GAP_MAT | GUI_BAOGIA | THEO_DOI | GHI_CHU | HE_THONG
    GiaiDoanCu          NVARCHAR(30)      NULL,
    GiaiDoanMoi         NVARCHAR(30)      NULL,
    MoTa                NVARCHAR(MAX)     NULL,
    KetQua              NVARCHAR(100)     NULL,
    ThoiGianDatLich     DATETIME2         NULL,
    ThoiGianHoanTat     DATETIME2         NULL,
    LaHeThongTuTao      BIT               NOT NULL DEFAULT 0,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_HoatDongBanHang PRIMARY KEY (Ma)
);
GO

-- ============================================================
-- BANG: BaoGia
-- Bao gia cho khach hang truoc khi chot hop dong
-- ============================================================
CREATE TABLE BaoGia (
    Ma                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MaChiNhanh          UNIQUEIDENTIFIER  NOT NULL,
    MaBaoGia            NVARCHAR(50)      NOT NULL,
    MaKeHoach           UNIQUEIDENTIFIER  NULL REFERENCES KeHoachBanHang(Ma),
    MaKhachHang         UNIQUEIDENTIFIER  NOT NULL REFERENCES KhachHang(Ma),
    MaDaiLy             UNIQUEIDENTIFIER  NOT NULL REFERENCES DaiLy(Ma),
    MaSanPhamGoc        UNIQUEIDENTIFIER  NOT NULL,
    MaGoiSanPham        UNIQUEIDENTIFIER  NULL,
    DuLieuNhap          NVARCHAR(MAX)     NOT NULL,  -- JSON form data
    PhiGoc              DECIMAL(18,2)     NOT NULL,
    SoTienGiamGia       DECIMAL(18,2)     NOT NULL DEFAULT 0,
    LyDoGiamGia         NVARCHAR(255)     NULL,
    SoTienPhuPhi        DECIMAL(18,2)     NOT NULL DEFAULT 0,
    PhiSauCung          DECIMAL(18,2)     NOT NULL,
    SoTienBaoHiem       DECIMAL(18,2)     NULL,
    NgayBatDau          DATE              NULL,
    NgayKetThuc         DATE              NULL,
    TrangThai           NVARCHAR(20)      NOT NULL DEFAULT 'NHAP',
    -- NHAP | DA_GUI | DA_XEM | HET_HAN | DA_CHAP_NHAN | DA_TU_CHOI
    NgayGui             DATETIME2         NULL,
    NgayXem             DATETIME2         NULL,
    NgayHetHan          DATETIME2         NULL,
    NgayChapNhan        DATETIME2         NULL,
    UrlFileBaoGia       NVARCHAR(500)     NULL,
    GhiChu              NVARCHAR(MAX)     NULL,
    GhiChuDaiLy         NVARCHAR(MAX)     NULL,
    MaHopDongChuyenDoi  UNIQUEIDENTIFIER  NULL,
    NgayChuyenDoi       DATETIME2         NULL,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NgayCapNhat         DATETIME2         NULL,
    CONSTRAINT PK_BaoGia PRIMARY KEY (Ma),
    CONSTRAINT UQ_BaoGia_MaBG UNIQUE (MaChiNhanh, MaBaoGia)
);
GO
