-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CHI MUC (INDEXES)
-- FILE: TatCaChiMuc.sql
-- MO TA: Tat ca chi muc (index) cho cac bang trong he thong
-- ============================================================
GO

-- ================================================================
-- CHI MUC CHO BANG: DaiLy
-- ================================================================
CREATE NONCLUSTERED INDEX IX_DaiLy_ChiNhanh_TrangThai
ON DaiLy (MaChiNhanh, TrangThai)
INCLUDE (MaDaiLy, HoTen, MaCapBac, MaDonViToChuc);
GO

CREATE NONCLUSTERED INDEX IX_DaiLy_DaiLyCha
ON DaiLy (MaDaiLyCha)
INCLUDE (MaDaiLy, HoTen, MaCapBac);
GO

CREATE NONCLUSTERED INDEX IX_DaiLy_DonVi
ON DaiLy (MaDonViToChuc)
INCLUDE (MaDaiLy, HoTen, TrangThai);
GO

-- ================================================================
-- CHI MUC CHO BANG: KhachHang
-- ================================================================
CREATE NONCLUSTERED INDEX IX_KhachHang_ChiNhanh
ON KhachHang (MaChiNhanh, DangHoatDong)
INCLUDE (MaKhachHang, HoTen, SoDienThoai, LoaiKhachHang);
GO

CREATE NONCLUSTERED INDEX IX_KhachHang_DaiLyPhuTrach
ON KhachHang (MaDaiLyPhuTrach, DangHoatDong)
INCLUDE (MaKhachHang, HoTen, SoDienThoai);
GO

CREATE NONCLUSTERED INDEX IX_KhachHang_SDT
ON KhachHang (SoDienThoai)
INCLUDE (Ma, MaKhachHang, HoTen, MaChiNhanh);
GO

-- ================================================================
-- CHI MUC CHO BANG: HopDong
-- ================================================================
CREATE NONCLUSTERED INDEX IX_HopDong_ChiNhanh_TrangThai
ON HopDong (MaChiNhanh, TrangThaiHopDong)
INCLUDE (SoHopDong, MaKhachHang, MaDaiLy, PhiSauCung, NgayBatDau, NgayKetThuc);
GO

CREATE NONCLUSTERED INDEX IX_HopDong_DaiLy
ON HopDong (MaDaiLy, TrangThaiHopDong)
INCLUDE (SoHopDong, MaKhachHang, PhiSauCung, MaSanPhamGoc);
GO

CREATE NONCLUSTERED INDEX IX_HopDong_KhachHang
ON HopDong (MaKhachHang, TrangThaiHopDong)
INCLUDE (SoHopDong, MaDaiLy, PhiSauCung, NgayKetThuc);
GO

CREATE NONCLUSTERED INDEX IX_HopDong_NCC_NgayTao
ON HopDong (MaNCC, NgayTao)
INCLUDE (SoHopDong, TrangThaiHopDong, PhiSauCung, TrangThaiDoiSoat);
GO

CREATE NONCLUSTERED INDEX IX_HopDong_SapHetHan
ON HopDong (NgayKetThuc, TrangThaiHopDong)
WHERE TrangThaiHopDong = 'HIEU_LUC'
INCLUDE (SoHopDong, MaKhachHang, MaDaiLy, TrangThaiTaiTuc);
GO

CREATE NONCLUSTERED INDEX IX_HopDong_TrangThaiHH
ON HopDong (TrangThaiHoaHong, MaChiNhanh)
INCLUDE (Ma, PhiGoc, MaDaiLy, MaSanPhamGoc, MaNCC);
GO

-- ================================================================
-- CHI MUC CHO BANG: KeHoachBanHang
-- ================================================================
CREATE NONCLUSTERED INDEX IX_KeHoach_DaiLy_GiaiDoan
ON KeHoachBanHang (MaDaiLy, GiaiDoan)
INCLUDE (MaKhachHang, PhiDuKien, NgayChotDuKien, MucDoUuTien);
GO

CREATE NONCLUSTERED INDEX IX_KeHoach_GiaiDoan_ChiNhanh
ON KeHoachBanHang (MaChiNhanh, GiaiDoan, NgayTao DESC)
INCLUDE (MaKeHoach, MaKhachHang, MaDaiLy, PhiDuKien);
GO

-- ================================================================
-- CHI MUC CHO BANG: GiaoDichThanhToan
-- ================================================================
CREATE NONCLUSTERED INDEX IX_GiaoDich_HopDong
ON GiaoDichThanhToan (MaHopDong, TrangThai)
INCLUDE (SoTien, PhuongThucThanhToan, NgayHoanTat);
GO

CREATE NONCLUSTERED INDEX IX_GiaoDich_TrangThai
ON GiaoDichThanhToan (TrangThai, NgayKhoiTao DESC)
INCLUDE (MaGiaoDich, MaHopDong, SoTien, CongThanhToan);
GO

-- ================================================================
-- CHI MUC CHO BANG: SoHoaHong
-- ================================================================
CREATE NONCLUSTERED INDEX IX_SoHoaHong_DaiLy_Ky
ON SoHoaHong (MaDaiLyHuongHH, NamKy, ThangKy)
INCLUDE (LoaiHoaHong, HoaHongGop, HoaHongRong, TrangThai);
GO

CREATE NONCLUSTERED INDEX IX_SoHoaHong_HopDong
ON SoHoaHong (MaHopDong)
INCLUDE (MaDaiLyHuongHH, LoaiHoaHong, HoaHongRong, TrangThai);
GO

CREATE NONCLUSTERED INDEX IX_SoHoaHong_Lo
ON SoHoaHong (MaLo, TrangThai)
INCLUDE (MaDaiLyHuongHH, HoaHongGop, SoTienThue, HoaHongRong);
GO

-- ================================================================
-- CHI MUC CHO BANG: KyDoiSoat
-- ================================================================
CREATE NONCLUSTERED INDEX IX_KyDoiSoat_NCC_TrangThai
ON KyDoiSoat (MaNCC, TrangThai)
INCLUDE (MaKyDoiSoat, NamKy, ThangKy);
GO

-- ================================================================
-- CHI MUC CHO BANG: TrangDich
-- ================================================================
CREATE NONCLUSTERED INDEX IX_TrangDich_DaiLy
ON TrangDich (MaDaiLy, TrangThai)
INCLUDE (MaTrang, TieuDeTrang, TongLuotXem, TongLead);
GO

-- ================================================================
-- CHI MUC CHO BANG: LeadTrangDich
-- ================================================================
CREATE NONCLUSTERED INDEX IX_LeadTrangDich_TrangThai
ON LeadTrangDich (TrangThai, NgayTao DESC)
INCLUDE (MaTrangDich, MaDaiLy, HoTen, SoDienThoai);
GO

-- ================================================================
-- CHI MUC CHO BANG: ThongBao
-- ================================================================
CREATE NONCLUSTERED INDEX IX_ThongBao_NguoiNhan
ON ThongBao (MaNguoiNhan, DaDoc, DaXoa, NgayTao DESC)
INCLUDE (TieuDe, LoaiThongBao, MucDoUuTien);
GO

-- ================================================================
-- CHI MUC CHO BANG: LichTraGop
-- ================================================================
CREATE NONCLUSTERED INDEX IX_LichTraGop_DenHan
ON LichTraGop (NgayDenHan, TrangThai)
WHERE TrangThai = 'CHO_DONG'
INCLUDE (MaHopDong, SoTien, SoLanNhac);
GO
