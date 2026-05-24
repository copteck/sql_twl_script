-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - THU TUC LUU TRU
-- FILE: TT_ChupNhanhThongKeNgay.sql
-- MO TA: Chup nhanh thong ke tong hop cuoi moi ngay
-- ============================================================
GO

CREATE OR ALTER PROCEDURE TT_ChupNhanhThongKeNgay
    @MaChiNhanh     UNIQUEIDENTIFIER,
    @NgayChupNhanh  DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @NgayChupNhanh IS NULL
        SET @NgayChupNhanh = CAST(GETUTCDATE() AS DATE);

    DECLARE @MaKhoaThoiGian INT = CAST(FORMAT(@NgayChupNhanh, 'yyyyMMdd') AS INT);

    -- Xoa du lieu cu neu co
    DELETE FROM TWL_BAO_CAO.dbo.SKChupNhanhHangNgay
    WHERE MaKhoaThoiGian = @MaKhoaThoiGian
        AND MaKhoaChiNhanh = @MaChiNhanh;

    -- Tinh toan va chen moi
    INSERT INTO TWL_BAO_CAO.dbo.SKChupNhanhHangNgay (
        MaKhoaThoiGian, MaKhoaChiNhanh,
        TongDaiLyHoatDong, TongKhachHang, TongHopDongHieuLuc,
        TongDoanhThuLuyKe, TongHoaHongChuaTra,
        TongLeadChuaXuLy, TongHDSapHetHan30Ngay
    )
    SELECT
        @MaKhoaThoiGian,
        @MaChiNhanh,
        -- Dai ly hoat dong
        (SELECT COUNT(*) FROM DaiLy WHERE MaChiNhanh = @MaChiNhanh AND TrangThai = 'HOATDONG'),
        -- Tong khach hang
        (SELECT COUNT(*) FROM KhachHang WHERE MaChiNhanh = @MaChiNhanh AND DangHoatDong = 1),
        -- Hop dong hieu luc
        (SELECT COUNT(*) FROM HopDong WHERE MaChiNhanh = @MaChiNhanh AND TrangThaiHopDong = 'HIEU_LUC'),
        -- Doanh thu luy ke
        (SELECT ISNULL(SUM(PhiSauCung), 0) FROM HopDong
         WHERE MaChiNhanh = @MaChiNhanh
         AND TrangThaiHopDong IN ('DA_THANH_TOAN', 'NCC_DA_DUYET', 'HIEU_LUC')
         AND YEAR(NgayTao) = YEAR(@NgayChupNhanh)),
        -- Hoa hong chua tra
        (SELECT ISNULL(SUM(HoaHongRong), 0) FROM SoHoaHong
         WHERE MaChiNhanh = @MaChiNhanh
         AND TrangThai IN ('DA_TINH', 'DA_DUYET')),
        -- Lead chua xu ly
        (SELECT COUNT(*) FROM KeHoachBanHang
         WHERE MaChiNhanh = @MaChiNhanh
         AND GiaiDoan IN ('MOI', 'DA_LIEN_HE')),
        -- Hop dong sap het han 30 ngay
        (SELECT COUNT(*) FROM HopDong
         WHERE MaChiNhanh = @MaChiNhanh
         AND TrangThaiHopDong = 'HIEU_LUC'
         AND NgayKetThuc BETWEEN @NgayChupNhanh AND DATEADD(DAY, 30, @NgayChupNhanh));
END;
GO
