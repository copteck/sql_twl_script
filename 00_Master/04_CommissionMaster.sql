-- ============================================================
-- TWL PORTAL 360LIFE - MASTER DATABASE
-- FILE: 04_CommissionMaster.sql
-- ============================================================
USE TWL_MASTER;
GO

CREATE TABLE CommissionMasterTemplate (
    Id                UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TemplateName      NVARCHAR(255)     NOT NULL,
    TemplateCode      NVARCHAR(50)      NOT NULL,
    MasterProductId   UNIQUEIDENTIFIER  NOT NULL REFERENCES MasterProducts(Id),
    ProviderId        UNIQUEIDENTIFIER  NOT NULL REFERENCES InsuranceProviders(Id),
    -- JSON cau hinh HH theo chuc vu:
    -- {"levels":[
    --   {"rankCode":"AGENT","rankName":"Agent","directRate":0.085,"overrideRate":0},
    --   {"rankCode":"SENIOR","rankName":"Senior Agent","directRate":0.095,"overrideRate":0},
    --   {"rankCode":"TEAM_LEADER","directRate":0.100,"overrideRate":0.015},
    --   {"rankCode":"MANAGER","directRate":0.110,"overrideRate":0.005},
    --   {"rankCode":"DIRECTOR","directRate":0,"overrideRate":0.003}
    -- ]}
    RateConfig        NVARCHAR(MAX)     NOT NULL,
    -- JSON tier theo doanh thu:
    -- {"tiers":[
    --   {"minRevenue":0,"maxRevenue":20000000,"bonusRate":0},
    --   {"minRevenue":20000001,"maxRevenue":50000000,"bonusRate":0.005},
    --   {"minRevenue":50000001,"maxRevenue":100000000,"bonusRate":0.010},
    --   {"minRevenue":100000001,"maxRevenue":null,"bonusRate":0.020}
    -- ]}
    TierConfig        NVARCHAR(MAX)     NULL,
    MaxTotalRate      DECIMAL(5,4)      NOT NULL,
    EffectiveFrom     DATE              NOT NULL,
    EffectiveTo       DATE              NULL,
    IsActive          BIT               NOT NULL DEFAULT 1,
    CreatedAt         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CreatedBy         UNIQUEIDENTIFIER  NULL,
    UpdatedAt         DATETIME2         NULL,
    CONSTRAINT PK_CommissionMasterTemplate PRIMARY KEY (Id),
    CONSTRAINT UQ_CommissionTemplate_Code UNIQUE (TemplateCode)
);
GO
