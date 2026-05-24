-- ============================================================
-- TWL PORTAL 360LIFE - MASTER DATABASE
-- FILE: 04_CommissionMaster.sql
-- ============================================================
USE TWL_MASTER;
GO

CREATE TABLE MauHoaHongGoc (
    Id                UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenMau            NVARCHAR(255)     NOT NULL,
    MaMau             NVARCHAR(50)      NOT NULL,
    SanPhamGocId      UNIQUEIDENTIFIER  NOT NULL REFERENCES SanPhamGoc(Id),
    NhaCungCapId      UNIQUEIDENTIFIER  NOT NULL REFERENCES NhaCungCapBaoHiem(Id),
    -- JSON cau hinh HH theo chuc vu:
    -- {"levels":[
    --   {"rankCode":"AGENT","rankName":"Agent","directRate":0.085,"overrideRate":0},
    --   {"rankCode":"SENIOR","rankName":"Senior Agent","directRate":0.095,"overrideRate":0},
    --   {"rankCode":"TEAM_LEADER","directRate":0.100,"overrideRate":0.015},
    --   {"rankCode":"MANAGER","directRate":0.110,"overrideRate":0.005},
    --   {"rankCode":"DIRECTOR","directRate":0,"overrideRate":0.003}
    -- ]}
    CauHinhTyLe       NVARCHAR(MAX)     NOT NULL,
    -- JSON tier theo doanh thu:
    -- {"tiers":[
    --   {"minRevenue":0,"maxRevenue":20000000,"bonusRate":0},
    --   {"minRevenue":20000001,"maxRevenue":50000000,"bonusRate":0.005},
    --   {"minRevenue":50000001,"maxRevenue":100000000,"bonusRate":0.010},
    --   {"minRevenue":100000001,"maxRevenue":null,"bonusRate":0.020}
    -- ]}
    CauHinhBacThang   NVARCHAR(MAX)     NULL,
    TyLeToiDaTong     DECIMAL(5,4)      NOT NULL,
    HieuLucTu         DATE              NOT NULL,
    HieuLucDen        DATE              NULL,
    ConHoatDong       BIT               NOT NULL DEFAULT 1,
    NgayTao           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    NguoiTao          UNIQUEIDENTIFIER  NULL,
    NgayCapNhat       DATETIME2         NULL,
    CONSTRAINT PK_MauHoaHongGoc PRIMARY KEY (Id),
    CONSTRAINT UQ_MauHoaHongGoc_Ma UNIQUE (MaMau)
);
GO
