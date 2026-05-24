-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - THU TUC LUU TRU
-- FILE: TT_DuBaoHoaHong.sql
-- MO TA: Tinh toan du bao hoa hong cho dai ly theo thang
-- ============================================================
GO

CREATE OR ALTER PROCEDURE TT_DuBaoHoaHong
    @MaChiNhanh     UNIQUEIDENTIFIER,
    @Nam            INT,
    @Thang          INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY

        -- Tinh du bao cho tat ca dai ly trong chi nhanh
        MERGE DuBaoHoaHong AS dich
        USING (
            SELECT
                dl.Ma AS MaDaiLy,

                -- Du bao tu pipeline dang mo
                (SELECT COUNT(*) FROM KeHoachBanHang kh
                 WHERE kh.MaDaiLy = dl.Ma AND kh.MaChiNhanh = @MaChiNhanh
                 AND kh.GiaiDoan NOT IN ('HOAN_TAT', 'THAT_BAI')
                 AND MONTH(kh.NgayChotDuKien) = @Thang AND YEAR(kh.NgayChotDuKien) = @Nam
                ) AS SoHDDuBao,

                ISNULL((SELECT SUM(kh.PhiDuKien) FROM KeHoachBanHang kh
                 WHERE kh.MaDaiLy = dl.Ma AND kh.MaChiNhanh = @MaChiNhanh
                 AND kh.GiaiDoan NOT IN ('HOAN_TAT', 'THAT_BAI')
                 AND MONTH(kh.NgayChotDuKien) = @Thang AND YEAR(kh.NgayChotDuKien) = @Nam
                ), 0) AS DoanhThuDuBao,

                -- Xac nhan tu hop dong da co
                (SELECT COUNT(*) FROM HopDong hd
                 WHERE hd.MaDaiLy = dl.Ma AND hd.MaChiNhanh = @MaChiNhanh
                 AND hd.TrangThaiHopDong IN ('DA_THANH_TOAN', 'NCC_DA_DUYET', 'HIEU_LUC')
                 AND MONTH(hd.NgayTao) = @Thang AND YEAR(hd.NgayTao) = @Nam
                ) AS SoHDXacNhan,

                ISNULL((SELECT SUM(hd.PhiGoc) FROM HopDong hd
                 WHERE hd.MaDaiLy = dl.Ma AND hd.MaChiNhanh = @MaChiNhanh
                 AND hd.TrangThaiHopDong IN ('DA_THANH_TOAN', 'NCC_DA_DUYET', 'HIEU_LUC')
                 AND MONTH(hd.NgayTao) = @Thang AND YEAR(hd.NgayTao) = @Nam
                ), 0) AS DoanhThuXacNhan,

                -- Hoa hong thuc te
                ISNULL((SELECT SUM(sh.HoaHongRong) FROM SoHoaHong sh
                 WHERE sh.MaDaiLyHuongHH = dl.Ma AND sh.MaChiNhanh = @MaChiNhanh
                 AND sh.NamKy = @Nam AND sh.ThangKy = @Thang
                 AND sh.TrangThai IN ('DA_TINH', 'DA_DUYET', 'DA_CHI_TRA')
                ), 0) AS HoaHongThucTe,

                ISNULL((SELECT SUM(sh.HoaHongRong) FROM SoHoaHong sh
                 WHERE sh.MaDaiLyHuongHH = dl.Ma AND sh.MaChiNhanh = @MaChiNhanh
                 AND sh.NamKy = @Nam AND sh.ThangKy = @Thang
                 AND sh.TrangThai = 'DA_HUY'
                ), 0) AS HoaHongBiHuy

            FROM DaiLy dl
            WHERE dl.MaChiNhanh = @MaChiNhanh AND dl.TrangThai = 'HOATDONG'
        ) AS nguon
        ON dich.MaChiNhanh = @MaChiNhanh
            AND dich.MaDaiLy = nguon.MaDaiLy
            AND dich.NamKy = @Nam
            AND dich.ThangKy = @Thang
        WHEN MATCHED THEN
            UPDATE SET
                SoHDDuBao = nguon.SoHDDuBao,
                DoanhThuDuBao = nguon.DoanhThuDuBao,
                SoHDXacNhan = nguon.SoHDXacNhan,
                DoanhThuXacNhan = nguon.DoanhThuXacNhan,
                HoaHongThucTe = nguon.HoaHongThucTe,
                HoaHongBiHuy = nguon.HoaHongBiHuy,
                LanTinhGanNhat = GETUTCDATE()
        WHEN NOT MATCHED THEN
            INSERT (MaChiNhanh, MaDaiLy, NamKy, ThangKy,
                    SoHDDuBao, DoanhThuDuBao, SoHDXacNhan, DoanhThuXacNhan,
                    HoaHongThucTe, HoaHongBiHuy, LanTinhGanNhat)
            VALUES (@MaChiNhanh, nguon.MaDaiLy, @Nam, @Thang,
                    nguon.SoHDDuBao, nguon.DoanhThuDuBao,
                    nguon.SoHDXacNhan, nguon.DoanhThuXacNhan,
                    nguon.HoaHongThucTe, nguon.HoaHongBiHuy, GETUTCDATE());

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
