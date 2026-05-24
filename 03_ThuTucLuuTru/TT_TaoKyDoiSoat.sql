-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - THU TUC LUU TRU
-- FILE: TT_TaoKyDoiSoat.sql
-- MO TA: Tao ky doi soat moi va tong hop du lieu
-- ============================================================
GO

CREATE OR ALTER PROCEDURE TT_TaoKyDoiSoat
    @MaChiNhanh     UNIQUEIDENTIFIER,
    @MaNCC          UNIQUEIDENTIFIER,
    @Nam            INT,
    @Thang          INT,
    @NguoiThucHien  UNIQUEIDENTIFIER = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @NgayBatDau DATE = DATEFROMPARTS(@Nam, @Thang, 1);
        DECLARE @NgayKetThuc DATE = EOMONTH(@NgayBatDau);
        DECLARE @MaKyDoiSoat NVARCHAR(20) = 'DS-' + CAST(@Nam AS NVARCHAR(4)) + RIGHT('0' + CAST(@Thang AS NVARCHAR(2)), 2);
        DECLARE @MaKy UNIQUEIDENTIFIER = NEWID();

        -- Kiem tra da ton tai chua
        IF EXISTS (SELECT 1 FROM KyDoiSoat WHERE MaChiNhanh = @MaChiNhanh AND MaKyDoiSoat = @MaKyDoiSoat AND MaNCC = @MaNCC)
        BEGIN
            RAISERROR(N'Kỳ đối soát đã tồn tại', 16, 1);
            RETURN;
        END

        -- Dem so hop dong va tong phi cua Portal
        DECLARE @TongHDPortal INT = 0;
        DECLARE @TongPhiPortal DECIMAL(18,2) = 0;

        SELECT
            @TongHDPortal = COUNT(*),
            @TongPhiPortal = ISNULL(SUM(PhiSauCung), 0)
        FROM HopDong
        WHERE MaChiNhanh = @MaChiNhanh
            AND MaNCC = @MaNCC
            AND TrangThaiHopDong IN ('DA_THANH_TOAN', 'NCC_DA_DUYET', 'HIEU_LUC')
            AND NgayTao >= @NgayBatDau AND NgayTao <= @NgayKetThuc;

        -- Tao ky doi soat
        INSERT INTO KyDoiSoat (
            Ma, MaChiNhanh, MaKyDoiSoat, NamKy, ThangKy,
            NgayBatDauKy, NgayKetThucKy, MaNCC,
            TrangThai, TongHDPortal, TongPhiPortal
        ) VALUES (
            @MaKy, @MaChiNhanh, @MaKyDoiSoat, @Nam, @Thang,
            @NgayBatDau, @NgayKetThuc, @MaNCC,
            'DANG_MO', @TongHDPortal, @TongPhiPortal
        );

        -- Tao chi tiet doi soat cho tung hop dong
        INSERT INTO ChiTietDoiSoat (
            MaKyDoiSoat, MaChiNhanh, MaHopDong,
            SoHopDongPortal, TrangThaiPortal, PhiPortal,
            TrangThaiKhop
        )
        SELECT
            @MaKy, @MaChiNhanh, Ma,
            SoHopDong, TrangThaiHopDong, PhiSauCung,
            'CHUA_KHOP'
        FROM HopDong
        WHERE MaChiNhanh = @MaChiNhanh
            AND MaNCC = @MaNCC
            AND TrangThaiHopDong IN ('DA_THANH_TOAN', 'NCC_DA_DUYET', 'HIEU_LUC')
            AND NgayTao >= @NgayBatDau AND NgayTao <= @NgayKetThuc;

        COMMIT TRANSACTION;

        -- Tra ve ky vua tao
        SELECT * FROM KyDoiSoat WHERE Ma = @MaKy;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
