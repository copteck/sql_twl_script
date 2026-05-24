-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - DU LIEU MAU
-- FILE: DuLieu_CapBacDaiLy.sql
-- MO TA: Du lieu mau cap bac dai ly (dung cho moi chi nhanh)
-- ============================================================
GO

-- ========================
-- DU LIEU MAU: CapBacDaiLy (chay tren tung Tenant DB)
-- Thay @MaChiNhanh bang GUID thuc te cua chi nhanh
-- ========================
DECLARE @MaChiNhanh UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000001'; -- THAY BANG GUID THAT

INSERT INTO CapBacDaiLy (Ma, MaChiNhanh, MaCapBac, TenCapBac, SoThuTuCap,
    DoanhThuToiThieuThang, SoHDToiThieuThang, SoTuyenDuoiToiThieu,
    TyLeTrucTiepMacDinh, TyLeGianTiepMacDinh, MauHuyHieu, ThuTuHienThi) VALUES
(NEWID(), @MaChiNhanh, 'THUC_TAP',     N'Đại lý Thực tập',    1,
    0,              0,      0,      0.0600, 0.0000, '#94A3B8', 1),
(NEWID(), @MaChiNhanh, 'DAI_LY',       N'Đại lý',             2,
    10000000,       3,      0,      0.0800, 0.0000, '#60A5FA', 2),
(NEWID(), @MaChiNhanh, 'DAILY_CAOCAP', N'Đại lý Cao cấp',    3,
    30000000,       8,      2,      0.0950, 0.0000, '#34D399', 3),
(NEWID(), @MaChiNhanh, 'TRUONG_NHOM',  N'Trưởng nhóm',        4,
    50000000,       12,     5,      0.1000, 0.0150, '#FBBF24', 4),
(NEWID(), @MaChiNhanh, 'QUAN_LY',      N'Quản lý',            5,
    100000000,      20,     10,     0.1100, 0.0050, '#F97316', 5),
(NEWID(), @MaChiNhanh, 'GIAM_DOC',     N'Giám đốc kinh doanh', 6,
    200000000,      30,     20,     0.1200, 0.0030, '#EF4444', 6);
GO
