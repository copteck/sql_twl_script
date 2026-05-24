-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - KHO DU LIEU BAO CAO
-- FILE: 03_LuotXemBaoCao.sql
-- MO TA: Cac view bao cao tong hop
-- ============================================================
USE TWL_BAO_CAO;
GO

-- ============================================================
-- VIEW: V_BaoCaoDoanhThuTheoThang
-- ============================================================
CREATE OR ALTER VIEW V_BaoCaoDoanhThuTheoThang
AS
SELECT
    tg.Nam,
    tg.Thang,
    cn.TenChiNhanh,
    cn.TinhThanh,
    sp.TenSanPham,
    sp.LoaiBaoHiem,
    ncc.TenNCC,
    SUM(sk.SoHopDongMoi) AS TongHopDongMoi,
    SUM(sk.TongPhiBaoHiem) AS TongPhiBaoHiem,
    SUM(sk.TongPhiThucThu) AS TongPhiThucThu,
    SUM(sk.SoHopDongHuy) AS TongHopDongHuy,
    SUM(sk.TongHoanTien) AS TongHoanTien
FROM SKDoanhThuNgay sk
JOIN ChieuThoiGian tg ON sk.MaKhoaThoiGian = tg.MaKhoaThoiGian
JOIN ChieuChiNhanh cn ON sk.MaKhoaChiNhanh = cn.MaKhoaChiNhanh
JOIN ChieuSanPham sp ON sk.MaKhoaSanPham = sp.MaKhoaSanPham
JOIN ChieuNCC ncc ON sk.MaKhoaNCC = ncc.MaKhoaNCC
GROUP BY tg.Nam, tg.Thang, cn.TenChiNhanh, cn.TinhThanh,
         sp.TenSanPham, sp.LoaiBaoHiem, ncc.TenNCC;
GO

-- ============================================================
-- VIEW: V_BaoCaoHoaHongDaiLy
-- ============================================================
CREATE OR ALTER VIEW V_BaoCaoHoaHongDaiLy
AS
SELECT
    sk.Nam,
    sk.Thang,
    cn.TenChiNhanh,
    dl.MaSoDaiLy,
    dl.HoTen AS TenDaiLy,
    dl.CapBac,
    sk.SoHopDong,
    sk.TongPhiGoc,
    sk.HoaHongTrucTiep,
    sk.HoaHongGianTiep,
    sk.ThuongKy,
    sk.TongHoaHongGop,
    sk.TongThue,
    sk.TongHoaHongRong,
    sk.TrangThaiChiTra
FROM SKHoaHongThang sk
JOIN ChieuChiNhanh cn ON sk.MaKhoaChiNhanh = cn.MaKhoaChiNhanh
JOIN ChieuDaiLy dl ON sk.MaKhoaDaiLy = dl.MaKhoaDaiLy;
GO

-- ============================================================
-- VIEW: V_BaoCaoLeadChuyenDoi
-- ============================================================
CREATE OR ALTER VIEW V_BaoCaoLeadChuyenDoi
AS
SELECT
    tg.Nam,
    tg.Thang,
    tg.Tuan,
    cn.TenChiNhanh,
    dl.HoTen AS TenDaiLy,
    sk.NguonLead,
    SUM(sk.SoLeadMoi) AS TongLeadMoi,
    SUM(sk.SoLeadDaChot) AS TongLeadDaChot,
    SUM(sk.SoLeadThatBai) AS TongLeadThatBai,
    AVG(sk.TyLeChuyenDoi) AS TyLeChuyenDoiTB
FROM SKLeadNgay sk
JOIN ChieuThoiGian tg ON sk.MaKhoaThoiGian = tg.MaKhoaThoiGian
JOIN ChieuChiNhanh cn ON sk.MaKhoaChiNhanh = cn.MaKhoaChiNhanh
LEFT JOIN ChieuDaiLy dl ON sk.MaKhoaDaiLy = dl.MaKhoaDaiLy
GROUP BY tg.Nam, tg.Thang, tg.Tuan, cn.TenChiNhanh, dl.HoTen, sk.NguonLead;
GO

-- ============================================================
-- VIEW: V_BaoCaoTongQuanHeThong
-- ============================================================
CREATE OR ALTER VIEW V_BaoCaoTongQuanHeThong
AS
SELECT
    tg.NgayDayDu,
    cn.TenChiNhanh,
    cn.VungMien,
    sk.TongDaiLyHoatDong,
    sk.TongKhachHang,
    sk.TongHopDongHieuLuc,
    sk.TongDoanhThuLuyKe,
    sk.TongHoaHongChuaTra,
    sk.TongLeadChuaXuLy,
    sk.TongHDSapHetHan30Ngay
FROM SKChupNhanhHangNgay sk
JOIN ChieuThoiGian tg ON sk.MaKhoaThoiGian = tg.MaKhoaThoiGian
JOIN ChieuChiNhanh cn ON sk.MaKhoaChiNhanh = cn.MaKhoaChiNhanh;
GO
