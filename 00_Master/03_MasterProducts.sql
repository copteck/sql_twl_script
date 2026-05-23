-- ============================================================
-- TWL PORTAL 360LIFE - MASTER DATABASE
-- FILE: 03_MasterProducts.sql
-- DESC: ProductCategories, MasterProducts, ProductPlans, PremiumRateTable
-- ============================================================
USE TWL_MASTER;
GO

CREATE TABLE ProductCategories (
    Id              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    CategoryCode    NVARCHAR(50)      NOT NULL,
    CategoryName    NVARCHAR(255)     NOT NULL,
    CategoryNameEn  NVARCHAR(255)     NULL,
    ParentId        UNIQUEIDENTIFIER  NULL REFERENCES ProductCategories(Id),
    Level           INT               NOT NULL DEFAULT 1,
    HierarchyPath   NVARCHAR(500)     NULL,
    IconClass       NVARCHAR(100)     NULL,
    IconUrl         NVARCHAR(500)     NULL,
    BannerUrl       NVARCHAR(500)     NULL,
    Description     NVARCHAR(MAX)     NULL,
    SortOrder       INT               NOT NULL DEFAULT 0,
    IsActive        BIT               NOT NULL DEFAULT 1,
    CreatedAt       DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_ProductCategories PRIMARY KEY (Id),
    CONSTRAINT UQ_ProductCategories_Code UNIQUE (CategoryCode)
);
GO

CREATE TABLE MasterProducts (
    Id                     UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    ProductCode            NVARCHAR(100)     NOT NULL,
    ProductName            NVARCHAR(255)     NOT NULL,
    ProductNameEn          NVARCHAR(255)     NULL,
    CategoryId             UNIQUEIDENTIFIER  NOT NULL REFERENCES ProductCategories(Id),
    ProviderId             UNIQUEIDENTIFIER  NOT NULL REFERENCES InsuranceProviders(Id),
    InsuranceType          NVARCHAR(50)      NOT NULL,
    -- AUTO_MANDATORY | AUTO_VOLUNTARY | MOTO_MANDATORY | HEALTH_CARD
    -- TRAVEL | PERSONAL_ACCIDENT | FIRE_EXPLOSION | APARTMENT
    -- PROPERTY | STUDY_ABROAD | IMMIGRATION | WILL_PLANNING | ENTERPRISE
    ShortDescription       NVARCHAR(500)     NULL,
    FullDescription        NVARCHAR(MAX)     NULL,
    KeyBenefits            NVARCHAR(MAX)     NULL,  -- JSON array
    Exclusions             NVARCHAR(MAX)     NULL,  -- JSON array
    -- Dynamic Form Schema JSON:
    -- {"sections":[{"name":"vehicle_info","label":"Thong tin xe",
    --   "fields":[{"key":"plate_number","label":"Bien so xe",
    --   "type":"text","required":true,"validation":"regex"}]}]}
    FormSchema             NVARCHAR(MAX)     NOT NULL,
    PricingMethod          NVARCHAR(20)      NOT NULL DEFAULT 'LOOKUP_TABLE',
    -- LOOKUP_TABLE | FORMULA | API_REALTIME
    PricingConfig          NVARCHAR(MAX)     NULL,  -- JSON
    MinPremium             DECIMAL(18,2)     NULL,
    MaxPremium             DECIMAL(18,2)     NULL,
    PremiumUnit            NVARCHAR(20)      NOT NULL DEFAULT 'VND',
    PremiumLookupTable     NVARCHAR(MAX)     NULL,  -- JSON lookup table
    MinDurationDays        INT               NULL,
    MaxDurationDays        INT               NULL,
    DefaultDurationDays    INT               NULL DEFAULT 365,
    AllowCustomDuration    BIT               NOT NULL DEFAULT 0,
    MinInsuredAmount       DECIMAL(18,2)     NULL,
    MaxInsuredAmount       DECIMAL(18,2)     NULL,
    AllowInstallment       BIT               NOT NULL DEFAULT 0,
    -- JSON: {"options":[{"periods":1,"label":"1 lan"},
    --   {"periods":4,"label":"4 ky/nam","surcharge_rate":0.02}]}
    InstallmentConfig      NVARCHAR(MAX)     NULL,
    -- JSON: [{"code":"CCCD","name":"CCCD/CMND","required":true},
    --        {"code":"CAVET","name":"Cavet xe","required":true}]
    RequiredDocuments      NVARCHAR(MAX)     NULL,
    ContractTemplateUrl    NVARCHAR(500)     NULL,
    CertificateTemplateUrl NVARCHAR(500)     NULL,
    TemplateMergeFields    NVARCHAR(MAX)     NULL,  -- JSON field mapping
    ThumbnailUrl           NVARCHAR(500)     NULL,
    BannerUrl              NVARCHAR(500)     NULL,
    Tags                   NVARCHAR(500)     NULL,
    SortOrder              INT               NOT NULL DEFAULT 0,
    IsFeatured             BIT               NOT NULL DEFAULT 0,
    Status                 NVARCHAR(20)      NOT NULL DEFAULT 'DRAFT',
    -- DRAFT | PENDING_APPROVAL | APPROVED | ACTIVE | SUSPENDED | EXPIRED
    ApprovedBy             UNIQUEIDENTIFIER  NULL,
    ApprovedAt             DATETIME2         NULL,
    EffectiveFrom          DATE              NULL,
    EffectiveTo            DATE              NULL,
    ProviderProductCode    NVARCHAR(100)     NULL,
    ProviderProductName    NVARCHAR(255)     NULL,
    CreatedAt              DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CreatedBy              UNIQUEIDENTIFIER  NULL,
    UpdatedAt              DATETIME2         NULL,
    UpdatedBy              UNIQUEIDENTIFIER  NULL,
    IsDeleted              BIT               NOT NULL DEFAULT 0,
    CONSTRAINT PK_MasterProducts PRIMARY KEY (Id),
    CONSTRAINT UQ_MasterProducts_Code UNIQUE (ProductCode)
);
GO

CREATE TABLE ProductPlans (
    Id                UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MasterProductId   UNIQUEIDENTIFIER  NOT NULL REFERENCES MasterProducts(Id),
    PlanCode          NVARCHAR(50)      NOT NULL,  -- BRONZE|SILVER|GOLD|BASIC|PREMIUM
    PlanName          NVARCHAR(255)     NOT NULL,
    PlanNameEn        NVARCHAR(255)     NULL,
    Description       NVARCHAR(MAX)     NULL,
    BenefitSummary    NVARCHAR(MAX)     NULL,  -- JSON
    BenefitDetail     NVARCHAR(MAX)     NULL,  -- JSON
    CoveragePercent   DECIMAL(5,2)      NULL,
    InsuredAmount     DECIMAL(18,2)     NULL,
    PremiumAddon      NVARCHAR(MAX)     NULL,  -- JSON
    PremiumMultiplier DECIMAL(5,3)      NULL DEFAULT 1.0,
    Extensions        NVARCHAR(MAX)     NULL,  -- JSON
    IsRecommended     BIT               NOT NULL DEFAULT 0,
    SortOrder         INT               NOT NULL DEFAULT 0,
    IsActive          BIT               NOT NULL DEFAULT 1,
    ProviderPlanCode  NVARCHAR(50)      NULL,
    CreatedAt         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt         DATETIME2         NULL,
    CONSTRAINT PK_ProductPlans PRIMARY KEY (Id),
    CONSTRAINT UQ_ProductPlans_Code UNIQUE (MasterProductId, PlanCode)
);
GO

CREATE TABLE PremiumRateTable (
    Id                UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    MasterProductId   UNIQUEIDENTIFIER  NOT NULL REFERENCES MasterProducts(Id),
    PlanId            UNIQUEIDENTIFIER  NULL REFERENCES ProductPlans(Id),
    Condition1Key     NVARCHAR(100)     NULL,
    Condition1Value   NVARCHAR(100)     NULL,
    Condition2Key     NVARCHAR(100)     NULL,
    Condition2Value   NVARCHAR(100)     NULL,
    Condition3Key     NVARCHAR(100)     NULL,
    Condition3Value   NVARCHAR(100)     NULL,
    Condition4Key     NVARCHAR(100)     NULL,
    Condition4Value   NVARCHAR(100)     NULL,
    PremiumType       NVARCHAR(20)      NOT NULL DEFAULT 'FIXED',  -- FIXED|RATE_PERCENT
    PremiumFixed      DECIMAL(18,2)     NULL,
    PremiumRate       DECIMAL(8,6)      NULL,
    PremiumMin        DECIMAL(18,2)     NULL,
    PremiumMax        DECIMAL(18,2)     NULL,
    EffectiveFrom     DATE              NOT NULL,
    EffectiveTo       DATE              NULL,
    IsActive          BIT               NOT NULL DEFAULT 1,
    ImportBatchId     NVARCHAR(50)      NULL,
    CreatedAt         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PremiumRateTable PRIMARY KEY (Id)
);
GO

CREATE TABLE ProductVersionHistory (
    Id              BIGINT            NOT NULL IDENTITY(1,1),
    MasterProductId UNIQUEIDENTIFIER  NOT NULL REFERENCES MasterProducts(Id),
    VersionNumber   INT               NOT NULL,
    ChangeType      NVARCHAR(30)      NOT NULL,
    ChangeSummary   NVARCHAR(500)     NULL,
    OldData         NVARCHAR(MAX)     NULL,
    NewData         NVARCHAR(MAX)     NULL,
    EffectiveFrom   DATE              NOT NULL,
    ChangedBy       UNIQUEIDENTIFIER  NULL,
    ChangedAt       DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    ApprovedBy      UNIQUEIDENTIFIER  NULL,
    Notes           NVARCHAR(MAX)     NULL,
    CONSTRAINT PK_ProductVersionHistory PRIMARY KEY (Id)
);
GO
