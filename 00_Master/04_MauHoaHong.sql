-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - CO SO DU LIEU CHINH (MASTER)
-- FILE: 04_MauHoaHong.sql
-- MO TA: MauHoaHongGoc - Mau cau hinh hoa hong goc theo san pham
-- ============================================================
USE TWL_MASTER;
GO

-- ============================================================
-- BANG: MauHoaHongGoc
-- Mau cau hinh hoa hong ap dung cho tung san pham/NCC
-- ============================================================
CREATE TABLE MauHoaHongGoc (
    Ma                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenMau              NVARCHAR(255)     NOT NULL,
    MaMau               NVARCHAR(50)      NOT NULL,
    MaSanPhamGoc        UNIQUEIDENTIFIER  NOT NULL REFERENCES SanPhamGoc(Ma),
    MaNCC               UNIQUEIDENTIFIER  NOT NULL REFERENCES NhaCungCapBaoHiem(Ma),
    -- JSON cau hinh HH theo chuc vu:
    -- {"capBac":[
    --   {"maCapBac":"DAILY","tenCapBac":"Dai Ly","tyLeTrucTiep":0.085,"tyLeGianTiep":0},
    --   {"maCapBac":"DAILY_CC","tenCapBac":"Dai Ly Cao Cap","tyLeTrucTiep":0.095,"tyLeGianTiep":0},
    --   {"maCapBac":"TRUONG_NHOM","tyLeTrucTiep":0.100,"tyLeGianTiep":0.015},
    --   {"maCapBac":"QUAN_LY","tyLeTrucTiep":0.110,"tyLeGianTiep":0.005},
    --   {"maCapBac":"GIAM_DOC","tyLeTrucTiep":0,"tyLeGianTiep":0.003}
    -- ]}
    CauHinhTyLe         NVARCHAR(MAX)     NOT NULL,
    -- JSON bac thang theo doanh thu:
    -- {"bacThang":[
    --   {"doanhThuToiThieu":0,"doanhThuToiDa":20000000,"tyLeThuong":0},
    --   {"doanhThuToiThieu":20000001,"doanhThuToiDa":50000000,"tyLeThuong":0.005},
    --   {"doanhThuToiThieu":50000001,"doanhThuToiDa":100000000,"tyLeThuong":0.010},
    --   {"doanhThuToiThieu":100000001,"doanhThuToiDa":null,"tyLeThuong":0.020}
    -- ]}
    CauHinhBacThang     NVARCHAR(MAX)     NULL,
    TyLeToiDaTongCong   DECIMAL(5,4)      NOT NULL,
    HieuLucTu           DATE              NOT NULL,
    HieuLucDen          DATE              NULL,
    DangHoatDong        BIT               NOT NULL DEFAULT 1,
    NgayTao             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao            UNIQUEIDENTIFIER  NULL,
    NgayCapNhat         DATETIME2         NULL,
    CONSTRAINT PK_MauHoaHongGoc PRIMARY KEY (Ma),
    CONSTRAINT UQ_MauHoaHongGoc_MaMau UNIQUE (MaMau)
);
GO
