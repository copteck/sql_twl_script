-- ============================================================
-- TWL PORTAL 360LIFE - MASTER DATABASE
-- FILE: 01_Tenants.sql
-- DESC: TenantRegistry, SystemConfiguration, TenantProductMapping
-- ============================================================
USE TWL_MASTER;
GO

-- ============================================================
-- TABLE: TenantRegistry
-- ============================================================
CREATE TABLE TenantRegistry (
    Id                       UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantCode               NVARCHAR(50)      NOT NULL,
    TenantName               NVARCHAR(255)     NOT NULL,
    TenantNameEn             NVARCHAR(255)     NULL,
    TenantLevel              TINYINT           NOT NULL,  -- 0=HQ,1=Branch,2=Group,3=Team,4=Agent
    TenantType               NVARCHAR(30)      NOT NULL,  -- HQ|COMPANY|BRANCH|GROUP|TEAM|INDIVIDUAL
    Subdomain                NVARCHAR(100)     NOT NULL,
    CustomDomain             NVARCHAR(255)     NULL,
    IsSubdomainActive        BIT               NOT NULL DEFAULT 1,
    DbServerName             NVARCHAR(255)     NOT NULL,
    DbServerPort             INT               NOT NULL DEFAULT 1433,
    DbName                   NVARCHAR(100)     NOT NULL,
    DbConnectionEncrypted    NVARCHAR(MAX)     NOT NULL,
    DbReadReplicaEncrypted   NVARCHAR(MAX)     NULL,
    ParentTenantId           UNIQUEIDENTIFIER  NULL REFERENCES TenantRegistry(Id),
    RootTenantId             UNIQUEIDENTIFIER  NOT NULL,
    HierarchyPath            NVARCHAR(500)     NULL,
    HierarchyLevel           INT               NOT NULL DEFAULT 1,
    LegalName                NVARCHAR(255)     NULL,
    TaxCode                  NVARCHAR(20)      NULL,
    BusinessLicense          NVARCHAR(100)     NULL,
    BusinessLicenseExpiry    DATE              NULL,
    RepresentativeName       NVARCHAR(255)     NULL,
    RepresentativePhone      NVARCHAR(20)      NULL,
    RepresentativeEmail      NVARCHAR(255)     NULL,
    Address                  NVARCHAR(500)     NULL,
    Ward                     NVARCHAR(100)     NULL,
    District                 NVARCHAR(100)     NULL,
    Province                 NVARCHAR(100)     NULL,
    Latitude                 DECIMAL(10,8)     NULL,
    Longitude                DECIMAL(11,8)     NULL,
    LogoUrl                  NVARCHAR(500)     NULL,
    FaviconUrl               NVARCHAR(500)     NULL,
    PrimaryColor             NVARCHAR(20)      NULL DEFAULT '#1D4ED8',
    SecondaryColor           NVARCHAR(20)      NULL DEFAULT '#06B6D4',
    ThemeConfig              NVARCHAR(MAX)     NULL,
    Phone                    NVARCHAR(20)      NULL,
    Email                    NVARCHAR(255)     NULL,
    ZaloOAId                 NVARCHAR(100)     NULL,
    FacebookPageId           NVARCHAR(100)     NULL,
    DefaultCurrency          NVARCHAR(10)      NOT NULL DEFAULT 'VND',
    TimeZone                 NVARCHAR(50)      NOT NULL DEFAULT 'SE Asia Standard Time',
    CommissionPayCycle       NVARCHAR(20)      NOT NULL DEFAULT 'MONTHLY',
    CommissionPayDay         INT               NOT NULL DEFAULT 15,
    MaxAgentLevel            INT               NOT NULL DEFAULT 5,
    AllowGuestPurchase       BIT               NOT NULL DEFAULT 1,
    RequireManagerApprove    BIT               NOT NULL DEFAULT 0,
    Status                   NVARCHAR(20)      NOT NULL DEFAULT 'ACTIVE',
    ActivatedAt              DATETIME2         NULL,
    SuspendedAt              DATETIME2         NULL,
    SuspendReason            NVARCHAR(500)     NULL,
    CreatedAt                DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CreatedBy                UNIQUEIDENTIFIER  NULL,
    UpdatedAt                DATETIME2         NULL,
    UpdatedBy                UNIQUEIDENTIFIER  NULL,
    IsDeleted                BIT               NOT NULL DEFAULT 0,
    DeletedAt                DATETIME2         NULL,
    CONSTRAINT PK_TenantRegistry PRIMARY KEY (Id),
    CONSTRAINT UQ_TenantRegistry_Code UNIQUE (TenantCode),
    CONSTRAINT UQ_TenantRegistry_Subdomain UNIQUE (Subdomain)
);
GO

-- ============================================================
-- TABLE: SystemConfiguration
-- ============================================================
CREATE TABLE SystemConfiguration (
    Id          UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    ConfigKey   NVARCHAR(200)     NOT NULL,
    ConfigValue NVARCHAR(MAX)     NULL,
    ConfigType  NVARCHAR(20)      NOT NULL DEFAULT 'STRING',
    Description NVARCHAR(500)     NULL,
    TenantId    UNIQUEIDENTIFIER  NULL REFERENCES TenantRegistry(Id),
    IsEncrypted BIT               NOT NULL DEFAULT 0,
    CreatedAt   DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt   DATETIME2         NULL,
    UpdatedBy   UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_SystemConfiguration PRIMARY KEY (Id),
    CONSTRAINT UQ_SystemConfig_Key_Tenant UNIQUE (ConfigKey, TenantId)
);
GO

-- ============================================================
-- TABLE: TenantProductMapping
-- ============================================================
CREATE TABLE TenantProductMapping (
    Id                UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId          UNIQUEIDENTIFIER  NOT NULL REFERENCES TenantRegistry(Id),
    MasterProductId   UNIQUEIDENTIFIER  NOT NULL,
    IsActive          BIT               NOT NULL DEFAULT 1,
    ActivatedAt       DATETIME2         NULL,
    DeactivatedAt     DATETIME2         NULL,
    DeactivateReason  NVARCHAR(500)     NULL,
    SortOrder         INT               NOT NULL DEFAULT 0,
    CustomDescription NVARCHAR(MAX)     NULL,
    CreatedAt         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CreatedBy         UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_TenantProductMapping PRIMARY KEY (Id),
    CONSTRAINT UQ_TenantProduct UNIQUE (TenantId, MasterProductId)
);
GO
