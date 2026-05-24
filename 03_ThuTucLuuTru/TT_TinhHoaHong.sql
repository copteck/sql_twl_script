-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - THU TUC LUU TRU
-- FILE: TT_TinhHoaHong.sql
-- MO TA: Tinh hoa hong cho tung hop dong theo cau hinh
-- ============================================================
GO

CREATE OR ALTER PROCEDURE TT_TinhHoaHong
    @MaChiNhanh     UNIQUEIDENTIFIER,
    @MaHopDong      UNIQUEIDENTIFIER,
    @NguoiThucHien  UNIQUEIDENTIFIER = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @MaDaiLy UNIQUEIDENTIFIER;
        DECLARE @MaSanPhamGoc UNIQUEIDENTIFIER;
        DECLARE @MaNCC UNIQUEIDENTIFIER;
        DECLARE @PhiGoc DECIMAL(18,2);
        DECLARE @NamKy INT = YEAR(GETUTCDATE());
        DECLARE @ThangKy INT = MONTH(GETUTCDATE());

        -- Lay thong tin hop dong
        SELECT
            @MaDaiLy = MaDaiLy,
            @MaSanPhamGoc = MaSanPhamGoc,
            @MaNCC = MaNCC,
            @PhiGoc = PhiGoc
        FROM HopDong
        WHERE Ma = @MaHopDong AND MaChiNhanh = @MaChiNhanh;

        IF @MaDaiLy IS NULL
        BEGIN
            RAISERROR(N'Không tìm thấy hợp đồng', 16, 1);
            RETURN;
        END

        -- Tinh hoa hong truc tiep cho dai ly ban
        DECLARE @TyLeTrucTiep DECIMAL(6,5);
        SELECT TOP 1 @TyLeTrucTiep = TyLeGoc
        FROM CauHinhHoaHong
        WHERE MaChiNhanh = @MaChiNhanh
            AND MaSanPhamGoc = @MaSanPhamGoc
            AND MaNCC = @MaNCC
            AND LoaiHoaHong = 'TRUC_TIEP'
            AND DangHoatDong = 1
            AND HieuLucTu <= GETUTCDATE()
            AND (HieuLucDen IS NULL OR HieuLucDen >= GETUTCDATE())
        ORDER BY HieuLucTu DESC;

        IF @TyLeTrucTiep IS NOT NULL
        BEGIN
            DECLARE @HoaHongGop DECIMAL(18,2) = @PhiGoc * @TyLeTrucTiep;
            DECLARE @TyLeThue DECIMAL(5,4) = 0.10;
            DECLARE @SoTienThue DECIMAL(18,2) = @HoaHongGop * @TyLeThue;
            DECLARE @HoaHongRong DECIMAL(18,2) = @HoaHongGop - @SoTienThue;

            INSERT INTO SoHoaHong (
                MaChiNhanh, MaHopDong, MaDaiLyBan, MaDaiLyHuongHH,
                LoaiHoaHong, PhiGocHopDong, TyLeHoaHong,
                HoaHongGop, TyLeThue, SoTienThue, HoaHongRong,
                NamKy, ThangKy, TrangThai
            ) VALUES (
                @MaChiNhanh, @MaHopDong, @MaDaiLy, @MaDaiLy,
                'TRUC_TIEP', @PhiGoc, @TyLeTrucTiep,
                @HoaHongGop, @TyLeThue, @SoTienThue, @HoaHongRong,
                @NamKy, @ThangKy, 'DA_TINH'
            );
        END

        -- Tinh hoa hong gian tiep cho cap tren
        DECLARE @MaDaiLyCha UNIQUEIDENTIFIER;
        DECLARE @CapGianTiep INT = 1;

        SELECT @MaDaiLyCha = MaDaiLyCha FROM DaiLy WHERE Ma = @MaDaiLy;

        WHILE @MaDaiLyCha IS NOT NULL AND @CapGianTiep <= 3
        BEGIN
            DECLARE @TyLeGianTiep DECIMAL(6,5) = NULL;

            IF @CapGianTiep = 1
                SELECT TOP 1 @TyLeGianTiep = TyLeGianTiepCap1
                FROM CauHinhHoaHong
                WHERE MaChiNhanh = @MaChiNhanh
                    AND MaSanPhamGoc = @MaSanPhamGoc
                    AND MaNCC = @MaNCC
                    AND DangHoatDong = 1
                    AND HieuLucTu <= GETUTCDATE()
                    AND (HieuLucDen IS NULL OR HieuLucDen >= GETUTCDATE());
            ELSE IF @CapGianTiep = 2
                SELECT TOP 1 @TyLeGianTiep = TyLeGianTiepCap2
                FROM CauHinhHoaHong
                WHERE MaChiNhanh = @MaChiNhanh
                    AND MaSanPhamGoc = @MaSanPhamGoc
                    AND MaNCC = @MaNCC
                    AND DangHoatDong = 1
                    AND HieuLucTu <= GETUTCDATE()
                    AND (HieuLucDen IS NULL OR HieuLucDen >= GETUTCDATE());
            ELSE IF @CapGianTiep = 3
                SELECT TOP 1 @TyLeGianTiep = TyLeGianTiepCap3
                FROM CauHinhHoaHong
                WHERE MaChiNhanh = @MaChiNhanh
                    AND MaSanPhamGoc = @MaSanPhamGoc
                    AND MaNCC = @MaNCC
                    AND DangHoatDong = 1
                    AND HieuLucTu <= GETUTCDATE()
                    AND (HieuLucDen IS NULL OR HieuLucDen >= GETUTCDATE());

            IF @TyLeGianTiep IS NOT NULL AND @TyLeGianTiep > 0
            BEGIN
                SET @HoaHongGop = @PhiGoc * @TyLeGianTiep;
                SET @SoTienThue = @HoaHongGop * @TyLeThue;
                SET @HoaHongRong = @HoaHongGop - @SoTienThue;

                INSERT INTO SoHoaHong (
                    MaChiNhanh, MaHopDong, MaDaiLyBan, MaDaiLyHuongHH,
                    LoaiHoaHong, CapGianTiep, PhiGocHopDong, TyLeHoaHong,
                    HoaHongGop, TyLeThue, SoTienThue, HoaHongRong,
                    NamKy, ThangKy, TrangThai
                ) VALUES (
                    @MaChiNhanh, @MaHopDong, @MaDaiLy, @MaDaiLyCha,
                    'GIAN_TIEP_CAP' + CAST(@CapGianTiep AS NVARCHAR(1)),
                    @CapGianTiep, @PhiGoc, @TyLeGianTiep,
                    @HoaHongGop, @TyLeThue, @SoTienThue, @HoaHongRong,
                    @NamKy, @ThangKy, 'DA_TINH'
                );
            END

            -- Tim cap tren tiep theo
            SELECT @MaDaiLyCha = MaDaiLyCha FROM DaiLy WHERE Ma = @MaDaiLyCha;
            SET @CapGianTiep = @CapGianTiep + 1;
        END

        -- Cap nhat trang thai hoa hong cua hop dong
        UPDATE HopDong
        SET TrangThaiHoaHong = 'DA_TINH', NgayCapNhat = GETUTCDATE()
        WHERE Ma = @MaHopDong;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
