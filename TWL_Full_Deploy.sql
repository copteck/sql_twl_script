-- ============================================================
-- TWL PORTAL 360LIFE - FULL DEPLOYMENT SCRIPT
-- Generated: Single file for SQL Server Management Studio
-- ============================================================
-- EXECUTION ORDER:
--   1. Master Database: Tenants, InsuranceProviders, MasterProducts, CommissionMaster
--   2. Tenant Database: BranchOrg, Agents, Customers, Pipeline, Policies, Payments, Commission, Reconciliation, LandingPage
--   3. Seed Data: Roles & Permissions
-- ============================================================

-- ************************************************************
-- PART 1: MASTER DATABASE (TWL_MASTER)
-- ************************************************************

CREATE DATABASE TWL_MASTER;
GO
USE TWL_MASTER;
GO

-- ============================================================
-- 01_Tenants.sql
-- TenantRegistry, SystemConfiguration, TenantProductMapping
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

-- ============================================================
-- 02_InsuranceProviders.sql
-- InsuranceProviders, ProviderBankAccounts, CommissionProviderRate
-- ============================================================

CREATE TABLE InsuranceProviders (
    Id                       UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    ProviderCode             NVARCHAR(50)      NOT NULL,  -- BAOVIET|LIBERTY|BSH|PTI|MIC|BIC
    ProviderName             NVARCHAR(255)     NOT NULL,
    ProviderNameEn           NVARCHAR(255)     NULL,
    ShortName                NVARCHAR(50)      NULL,
    ProviderType             NVARCHAR(30)      NOT NULL DEFAULT 'INSURANCE_COMPANY',
    TaxCode                  NVARCHAR(20)      NULL,
    LicenseNumber            NVARCHAR(100)     NULL,
    LicenseExpiry            DATE              NULL,
    HeadquarterAddress       NVARCHAR(500)     NULL,
    Website                  NVARCHAR(255)     NULL,
    HotlinePhone             NVARCHAR(20)      NULL,
    ClaimPhone               NVARCHAR(20)      NULL,
    EmailGeneral             NVARCHAR(255)     NULL,
    EmailReconcile           NVARCHAR(255)     NULL,
    ContactPersonName        NVARCHAR(255)     NULL,
    ContactPersonPhone       NVARCHAR(20)      NULL,
    ContactPersonEmail       NVARCHAR(255)     NULL,
    -- API Integration
    ApiBaseUrl               NVARCHAR(500)     NULL,
    ApiAuthType              NVARCHAR(20)      NULL,  -- BASIC|BEARER|APIKEY|OAUTH2
    ApiCredentialEncrypted   NVARCHAR(MAX)     NULL,
    ApiVersion               NVARCHAR(20)      NULL,
    HasRealtimeQuote         BIT               NOT NULL DEFAULT 0,
    HasAutoIssuance          BIT               NOT NULL DEFAULT 0,
    ApiTimeoutSeconds        INT               NOT NULL DEFAULT 30,
    ApiRetryCount            INT               NOT NULL DEFAULT 3,
    -- Agency Contract
    AgencyContractNo         NVARCHAR(100)     NULL,
    AgencyContractDate       DATE              NULL,
    AgencyContractExpiry     DATE              NULL,
    AgencyContractFileUrl    NVARCHAR(500)     NULL,
    DefaultCommissionRate    DECIMAL(5,4)      NULL,
    LogoUrl                  NVARCHAR(500)     NULL,
    BrandColor               NVARCHAR(20)      NULL,
    IsActive                 BIT               NOT NULL DEFAULT 1,
    SortOrder                INT               NOT NULL DEFAULT 0,
    Notes                    NVARCHAR(MAX)     NULL,
    CreatedAt                DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt                DATETIME2         NULL,
    CONSTRAINT PK_InsuranceProviders PRIMARY KEY (Id),
    CONSTRAINT UQ_InsuranceProviders_Code UNIQUE (ProviderCode)
);
GO

CREATE TABLE ProviderBankAccounts (
    Id              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    ProviderId      UNIQUEIDENTIFIER  NOT NULL REFERENCES InsuranceProviders(Id),
    AccountType     NVARCHAR(20)      NOT NULL,  -- RECEIVE_PREMIUM|PAY_COMMISSION
    BankName        NVARCHAR(100)     NOT NULL,
    BankCode        NVARCHAR(20)      NULL,
    BankBranch      NVARCHAR(200)     NULL,
    AccountNumber   NVARCHAR(50)      NOT NULL,
    AccountName     NVARCHAR(255)     NOT NULL,
    IsDefault       BIT               NOT NULL DEFAULT 0,
    IsActive        BIT               NOT NULL DEFAULT 1,
    CreatedAt       DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_ProviderBankAccounts PRIMARY KEY (Id)
);
GO

CREATE TABLE CommissionProviderRate (
    Id                UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    ProviderId        UNIQUEIDENTIFIER  NOT NULL REFERENCES InsuranceProviders(Id),
    MasterProductId   UNIQUEIDENTIFIER  NOT NULL,
    CommissionRate    DECIMAL(5,4)      NOT NULL,
    BonusRate         DECIMAL(5,4)      NULL,
    BonusCondition    NVARCHAR(MAX)     NULL,
    EffectiveFrom     DATE              NOT NULL,
    EffectiveTo       DATE              NULL,
    ContractRef       NVARCHAR(100)     NULL,
    Notes             NVARCHAR(500)     NULL,
    IsActive          BIT               NOT NULL DEFAULT 1,
    CreatedAt         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CreatedBy         UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_CommissionProviderRate PRIMARY KEY (Id)
);
GO

-- ============================================================
-- 03_MasterProducts.sql
-- ProductCategories, MasterProducts, ProductPlans, PremiumRateTable, ProductVersionHistory
-- ============================================================

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
    InstallmentConfig      NVARCHAR(MAX)     NULL,
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

-- ============================================================
-- 04_CommissionMaster.sql
-- CommissionMasterTemplate
-- ============================================================

CREATE TABLE CommissionMasterTemplate (
    Id                UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TemplateName      NVARCHAR(255)     NOT NULL,
    TemplateCode      NVARCHAR(50)      NOT NULL,
    MasterProductId   UNIQUEIDENTIFIER  NOT NULL REFERENCES MasterProducts(Id),
    ProviderId        UNIQUEIDENTIFIER  NOT NULL REFERENCES InsuranceProviders(Id),
    RateConfig        NVARCHAR(MAX)     NOT NULL,
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

-- ============================================================
-- Identity tables (Roles, Permissions) for Seed Data
-- ============================================================

CREATE TABLE Roles (
    Id              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWID(),
    RoleCode        NVARCHAR(50)      NOT NULL,
    RoleName        NVARCHAR(100)     NOT NULL,
    RoleDescription NVARCHAR(500)     NULL,
    TenantLevel     INT               NOT NULL DEFAULT 0,
    IsSystemRole    BIT               NOT NULL DEFAULT 0,
    SortOrder       INT               NOT NULL DEFAULT 0,
    CreatedAt       DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_Roles PRIMARY KEY (Id),
    CONSTRAINT UQ_Roles_Code UNIQUE (RoleCode)
);
GO

CREATE TABLE Permissions (
    Id              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWID(),
    PermissionCode  NVARCHAR(100)     NOT NULL,
    PermissionName  NVARCHAR(255)     NOT NULL,
    Module          NVARCHAR(50)      NOT NULL,
    Action          NVARCHAR(50)      NOT NULL,
    CreatedAt       DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_Permissions PRIMARY KEY (Id),
    CONSTRAINT UQ_Permissions_Code UNIQUE (PermissionCode)
);
GO

CREATE TABLE RolePermissions (
    RoleId       UNIQUEIDENTIFIER  NOT NULL REFERENCES Roles(Id),
    PermissionId UNIQUEIDENTIFIER  NOT NULL REFERENCES Permissions(Id),
    CONSTRAINT PK_RolePermissions PRIMARY KEY (RoleId, PermissionId)
);
GO

-- ************************************************************
-- PART 2: TENANT DATABASE (TWL_TENANT)
-- Thay doi ten database theo chi nhanh: TWL_HCM, TWL_HANOI...
-- ************************************************************

CREATE DATABASE TWL_TENANT;
GO
USE TWL_TENANT;
GO

-- ============================================================
-- 01_BranchOrg.sql
-- BranchInfo, OrgUnits, AgentRanks, CommissionConfig
-- ============================================================

CREATE TABLE BranchInfo (
    Id                   UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId             UNIQUEIDENTIFIER  NOT NULL,
    BranchCode           NVARCHAR(50)      NOT NULL,
    BranchName           NVARCHAR(255)     NOT NULL,
    BranchType           NVARCHAR(30)      NOT NULL,
    MonthlyRevenueTarget DECIMAL(18,2)     NULL,
    YearlyRevenueTarget  DECIMAL(18,2)     NULL,
    MonthlyPolicyTarget  INT               NULL,
    MonthlyAgentTarget   INT               NULL,
    TotalAgents          INT               NOT NULL DEFAULT 0,
    ActiveAgents         INT               NOT NULL DEFAULT 0,
    TotalCustomers       INT               NOT NULL DEFAULT 0,
    TotalRevenueMTD      DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TotalRevenueYTD      DECIMAL(18,2)     NOT NULL DEFAULT 0,
    LastStatsUpdated     DATETIME2         NULL,
    CreatedAt            DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt            DATETIME2         NULL,
    CONSTRAINT PK_BranchInfo PRIMARY KEY (Id)
);
GO

CREATE TABLE OrgUnits (
    Id              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId        UNIQUEIDENTIFIER  NOT NULL,
    UnitCode        NVARCHAR(50)      NOT NULL,
    UnitName        NVARCHAR(255)     NOT NULL,
    UnitType        NVARCHAR(30)      NOT NULL,
    ParentUnitId    UNIQUEIDENTIFIER  NULL REFERENCES OrgUnits(Id),
    HierarchyPath   NVARCHAR(500)     NULL,
    HierarchyLevel  INT               NOT NULL DEFAULT 1,
    HeadAgentId     UNIQUEIDENTIFIER  NULL,
    Description     NVARCHAR(500)     NULL,
    MonthlyTarget   DECIMAL(18,2)     NULL,
    YearlyTarget    DECIMAL(18,2)     NULL,
    IsActive        BIT               NOT NULL DEFAULT 1,
    CreatedAt       DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt       DATETIME2         NULL,
    CONSTRAINT PK_OrgUnits PRIMARY KEY (Id),
    CONSTRAINT UQ_OrgUnits_Code UNIQUE (TenantId, UnitCode)
);
GO

CREATE TABLE AgentRanks (
    Id                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId            UNIQUEIDENTIFIER  NOT NULL,
    RankCode            NVARCHAR(50)      NOT NULL,
    RankName            NVARCHAR(100)     NOT NULL,
    RankLevel           INT               NOT NULL,
    MinRevenueMTD       DECIMAL(18,2)     NULL,
    MinPoliciesMTD      INT               NULL,
    MinDownlineCount    INT               NULL,
    MinActivMonths      INT               NULL,
    DefaultDirectRate   DECIMAL(5,4)      NULL,
    DefaultOverrideRate DECIMAL(5,4)      NULL,
    BadgeIconUrl        NVARCHAR(500)     NULL,
    BadgeColor          NVARCHAR(20)      NULL,
    Description         NVARCHAR(500)     NULL,
    SortOrder           INT               NOT NULL DEFAULT 0,
    IsActive            BIT               NOT NULL DEFAULT 1,
    CreatedAt           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_AgentRanks PRIMARY KEY (Id),
    CONSTRAINT UQ_AgentRanks UNIQUE (TenantId, RankCode)
);
GO

CREATE TABLE CommissionConfig (
    Id                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId            UNIQUEIDENTIFIER  NOT NULL,
    MasterProductId     UNIQUEIDENTIFIER  NOT NULL,
    ProviderId          UNIQUEIDENTIFIER  NOT NULL,
    RankId              UNIQUEIDENTIFIER  NULL REFERENCES AgentRanks(Id),
    CommissionType      NVARCHAR(20)      NOT NULL,
    BaseRate            DECIMAL(6,5)      NOT NULL,
    TierEnabled         BIT               NOT NULL DEFAULT 0,
    TierConfig          NVARCHAR(MAX)     NULL,
    CampaignEnabled     BIT               NOT NULL DEFAULT 0,
    CampaignConfig      NVARCHAR(MAX)     NULL,
    OverrideLevel1Rate  DECIMAL(6,5)      NULL,
    OverrideLevel2Rate  DECIMAL(6,5)      NULL,
    OverrideLevel3Rate  DECIMAL(6,5)      NULL,
    MaxRateAllowed      DECIMAL(6,5)      NULL,
    MinRateAllowed      DECIMAL(6,5)      NULL,
    EffectiveFrom       DATE              NOT NULL,
    EffectiveTo         DATE              NULL,
    IsActive            BIT               NOT NULL DEFAULT 1,
    ApprovedBy          UNIQUEIDENTIFIER  NULL,
    ApprovedAt          DATETIME2         NULL,
    Notes               NVARCHAR(500)     NULL,
    CreatedAt           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CreatedBy           UNIQUEIDENTIFIER  NULL,
    UpdatedAt           DATETIME2         NULL,
    CONSTRAINT PK_CommissionConfig PRIMARY KEY (Id)
);
GO

-- ============================================================
-- 02_Agents.sql
-- Agents, AgentRankHistory
-- ============================================================

CREATE TABLE Agents (
    Id                    UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId              UNIQUEIDENTIFIER  NOT NULL,
    UserId                UNIQUEIDENTIFIER  NOT NULL,
    AgentCode             NVARCHAR(50)      NOT NULL,
    FullName              NVARCHAR(255)     NOT NULL,
    DateOfBirth           DATE              NULL,
    Gender                NVARCHAR(10)      NULL,
    AvatarUrl             NVARCHAR(500)     NULL,
    Phone                 NVARCHAR(20)      NOT NULL,
    PhoneSecondary        NVARCHAR(20)      NULL,
    Email                 NVARCHAR(255)     NOT NULL,
    ZaloId                NVARCHAR(100)     NULL,
    IdCardNumber          NVARCHAR(20)      NOT NULL,
    IdCardIssuedDate      DATE              NULL,
    IdCardIssuedPlace     NVARCHAR(255)     NULL,
    IdCardFrontUrl        NVARCHAR(500)     NULL,
    IdCardBackUrl         NVARCHAR(500)     NULL,
    PermanentAddress      NVARCHAR(500)     NULL,
    CurrentAddress        NVARCHAR(500)     NULL,
    Province              NVARCHAR(100)     NULL,
    District              NVARCHAR(100)     NULL,
    OrgUnitId             UNIQUEIDENTIFIER  NULL REFERENCES OrgUnits(Id),
    RankId                UNIQUEIDENTIFIER  NULL REFERENCES AgentRanks(Id),
    ParentAgentId         UNIQUEIDENTIFIER  NULL REFERENCES Agents(Id),
    UplineL2AgentId       UNIQUEIDENTIFIER  NULL REFERENCES Agents(Id),
    UplineL3AgentId       UNIQUEIDENTIFIER  NULL REFERENCES Agents(Id),
    HierarchyPath         NVARCHAR(500)     NULL,
    LicenseNumber         NVARCHAR(100)     NULL,
    LicenseType           NVARCHAR(50)      NULL,
    LicenseIssuedDate     DATE              NULL,
    LicenseExpiryDate     DATE              NULL,
    LicenseFileUrl        NVARCHAR(500)     NULL,
    BankName              NVARCHAR(100)     NULL,
    BankCode              NVARCHAR(20)      NULL,
    BankAccountNumber     NVARCHAR(50)      NULL,
    BankAccountName       NVARCHAR(255)     NULL,
    BankBranch            NVARCHAR(200)     NULL,
    PreviousExperience    NVARCHAR(MAX)     NULL,
    EducationLevel        NVARCHAR(50)      NULL,
    Specialization        NVARCHAR(255)     NULL,
    PersonalSubdomain     NVARCHAR(100)     NULL,
    PersonalLandingPageId UNIQUEIDENTIFIER  NULL,
    RecruitedByAgentId    UNIQUEIDENTIFIER  NULL REFERENCES Agents(Id),
    RecruitedAt           DATE              NULL,
    JoinDate              DATE              NULL,
    MonthlyRevenueTarget  DECIMAL(18,2)     NULL,
    YearlyRevenueTarget   DECIMAL(18,2)     NULL,
    MonthlyPolicyTarget   INT               NULL,
    TotalRevenueLTD       DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TotalRevenueMTD       DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TotalRevenueYTD       DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TotalPoliciesLTD      INT               NOT NULL DEFAULT 0,
    TotalPoliciesMTD      INT               NOT NULL DEFAULT 0,
    TotalCustomers        INT               NOT NULL DEFAULT 0,
    TotalDownlineAgents   INT               NOT NULL DEFAULT 0,
    LastStatsUpdatedAt    DATETIME2         NULL,
    Status                NVARCHAR(20)      NOT NULL DEFAULT 'ACTIVE',
    OnboardingStatus      NVARCHAR(30)      NOT NULL DEFAULT 'INCOMPLETE',
    TerminatedAt          DATE              NULL,
    TerminateReason       NVARCHAR(500)     NULL,
    Notes                 NVARCHAR(MAX)     NULL,
    InternalNotes         NVARCHAR(MAX)     NULL,
    CreatedAt             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CreatedBy             UNIQUEIDENTIFIER  NULL,
    UpdatedAt             DATETIME2         NULL,
    UpdatedBy             UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_Agents PRIMARY KEY (Id),
    CONSTRAINT UQ_Agents_Code UNIQUE (TenantId, AgentCode),
    CONSTRAINT UQ_Agents_UserId UNIQUE (UserId)
);
GO

CREATE TABLE AgentRankHistory (
    Id              BIGINT            NOT NULL IDENTITY(1,1),
    AgentId         UNIQUEIDENTIFIER  NOT NULL REFERENCES Agents(Id),
    OldRankId       UNIQUEIDENTIFIER  NULL REFERENCES AgentRanks(Id),
    NewRankId       UNIQUEIDENTIFIER  NOT NULL REFERENCES AgentRanks(Id),
    ChangeType      NVARCHAR(20)      NOT NULL,
    ChangeReason    NVARCHAR(500)     NULL,
    EvidenceNote    NVARCHAR(MAX)     NULL,
    ChangedBy       UNIQUEIDENTIFIER  NULL,
    ChangedAt       DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    EffectiveFrom   DATE              NOT NULL,
    CONSTRAINT PK_AgentRankHistory PRIMARY KEY (Id)
);
GO

-- ============================================================
-- 03_Customers_CRM.sql
-- Customers, CustomerContactHistory, CustomerDocuments
-- ============================================================

CREATE TABLE Customers (
    Id                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId                UNIQUEIDENTIFIER  NOT NULL,
    CustomerCode            NVARCHAR(50)      NOT NULL,
    CustomerType            NVARCHAR(20)      NOT NULL DEFAULT 'GUEST',
    UserId                  UNIQUEIDENTIFIER  NULL,
    FullName                NVARCHAR(255)     NOT NULL,
    DateOfBirth             DATE              NULL,
    Gender                  NVARCHAR(10)      NULL,
    IdCardType              NVARCHAR(20)      NULL,
    IdCardNumber            NVARCHAR(20)      NULL,
    IdCardIssuedDate        DATE              NULL,
    IdCardIssuedPlace       NVARCHAR(255)     NULL,
    Phone                   NVARCHAR(20)      NOT NULL,
    PhoneSecondary          NVARCHAR(20)      NULL,
    Email                   NVARCHAR(255)     NULL,
    ZaloId                  NVARCHAR(100)     NULL,
    Address                 NVARCHAR(500)     NULL,
    Ward                    NVARCHAR(100)     NULL,
    District                NVARCHAR(100)     NULL,
    Province                NVARCHAR(100)     NULL,
    Occupation              NVARCHAR(100)     NULL,
    OccupationCode          NVARCHAR(20)      NULL,
    CompanyName             NVARCHAR(255)     NULL,
    AssetInfo               NVARCHAR(MAX)     NULL,
    LookupToken             NVARCHAR(100)     NULL,
    LookupTokenExpiry       DATETIME2         NULL,
    CustomerSegment         NVARCHAR(30)      NULL,
    LeadScore               INT               NOT NULL DEFAULT 0,
    Tags                    NVARCHAR(MAX)     NULL,
    Source                  NVARCHAR(50)      NULL,
    SourceDetail            NVARCHAR(255)     NULL,
    ReferralAgentId         UNIQUEIDENTIFIER  NULL REFERENCES Agents(Id),
    ReferralCustomerId      UNIQUEIDENTIFIER  NULL REFERENCES Customers(Id),
    LandingPageId           UNIQUEIDENTIFIER  NULL,
    UtmSource               NVARCHAR(100)     NULL,
    UtmMedium               NVARCHAR(100)     NULL,
    UtmCampaign             NVARCHAR(100)     NULL,
    UtmContent              NVARCHAR(100)     NULL,
    AssignedAgentId         UNIQUEIDENTIFIER  NULL REFERENCES Agents(Id),
    AssignedAt              DATETIME2         NULL,
    InsuranceNeeds          NVARCHAR(MAX)     NULL,
    BudgetRange             NVARCHAR(50)      NULL,
    PreferredContactTime    NVARCHAR(100)     NULL,
    PreferredContactChannel NVARCHAR(50)      NULL,
    TotalPolicies           INT               NOT NULL DEFAULT 0,
    ActivePolicies          INT               NOT NULL DEFAULT 0,
    TotalPremiumPaid        DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TotalPremiumAnnual      DECIMAL(18,2)     NOT NULL DEFAULT 0,
    LoyaltyPoints           INT               NOT NULL DEFAULT 0,
    LastPurchaseAt          DATETIME2         NULL,
    LastContactAt           DATETIME2         NULL,
    UpgradedToMemberAt      DATETIME2         NULL,
    Notes                   NVARCHAR(MAX)     NULL,
    InternalNotes           NVARCHAR(MAX)     NULL,
    IsActive                BIT               NOT NULL DEFAULT 1,
    IsBlacklisted           BIT               NOT NULL DEFAULT 0,
    BlacklistReason         NVARCHAR(500)     NULL,
    CreatedAt               DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt               DATETIME2         NULL,
    CONSTRAINT PK_Customers PRIMARY KEY (Id),
    CONSTRAINT UQ_Customers_Code UNIQUE (TenantId, CustomerCode)
);
GO

CREATE TABLE CustomerContactHistory (
    Id                BIGINT            NOT NULL IDENTITY(1,1),
    CustomerId        UNIQUEIDENTIFIER  NOT NULL REFERENCES Customers(Id),
    TenantId          UNIQUEIDENTIFIER  NOT NULL,
    AgentId           UNIQUEIDENTIFIER  NULL REFERENCES Agents(Id),
    ContactType       NVARCHAR(20)      NOT NULL,
    Direction         NVARCHAR(10)      NULL,
    Duration          INT               NULL,
    Subject           NVARCHAR(500)     NULL,
    Content           NVARCHAR(MAX)     NULL,
    Outcome           NVARCHAR(50)      NULL,
    FollowUpDate      DATETIME2         NULL,
    FollowUpNote      NVARCHAR(500)     NULL,
    RelatedPipelineId UNIQUEIDENTIFIER  NULL,
    RelatedPolicyId   UNIQUEIDENTIFIER  NULL,
    IsSystemGenerated BIT               NOT NULL DEFAULT 0,
    CreatedAt         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CreatedBy         UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_CustomerContactHistory PRIMARY KEY (Id)
);
GO

CREATE TABLE CustomerDocuments (
    Id              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    CustomerId      UNIQUEIDENTIFIER  NOT NULL REFERENCES Customers(Id),
    TenantId        UNIQUEIDENTIFIER  NOT NULL,
    DocType         NVARCHAR(50)      NOT NULL,
    DocName         NVARCHAR(255)     NULL,
    FileUrl         NVARCHAR(500)     NOT NULL,
    FileSize        BIGINT            NULL,
    MimeType        NVARCHAR(100)     NULL,
    RelatedPolicyId UNIQUEIDENTIFIER  NULL,
    UploadedBy      UNIQUEIDENTIFIER  NULL,
    UploadedAt      DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    IsVerified      BIT               NOT NULL DEFAULT 0,
    VerifiedBy      UNIQUEIDENTIFIER  NULL,
    VerifiedAt      DATETIME2         NULL,
    ExpiryDate      DATE              NULL,
    IsActive        BIT               NOT NULL DEFAULT 1,
    CONSTRAINT PK_CustomerDocuments PRIMARY KEY (Id)
);
GO

-- ============================================================
-- 04_Pipeline.sql
-- SalesPipeline, PipelineActivities, Quotations
-- ============================================================

CREATE TABLE SalesPipeline (
    Id                   UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId             UNIQUEIDENTIFIER  NOT NULL,
    PipelineCode         NVARCHAR(50)      NOT NULL,
    CustomerId           UNIQUEIDENTIFIER  NOT NULL REFERENCES Customers(Id),
    AgentId              UNIQUEIDENTIFIER  NOT NULL REFERENCES Agents(Id),
    MasterProductId      UNIQUEIDENTIFIER  NULL,
    ProductPlanId        UNIQUEIDENTIFIER  NULL,
    InterestedProducts   NVARCHAR(MAX)     NULL,
    Stage                NVARCHAR(30)      NOT NULL DEFAULT 'NEW',
    StageChangedAt       DATETIME2         NULL,
    StageChangedBy       UNIQUEIDENTIFIER  NULL,
    PreviousStage        NVARCHAR(30)      NULL,
    LostReason           NVARCHAR(50)      NULL,
    LostNote             NVARCHAR(500)     NULL,
    EstimatedPremium     DECIMAL(18,2)     NULL,
    EstimatedCloseDate   DATE              NULL,
    CloseProbability     INT               NULL,
    ResultPolicyId       UNIQUEIDENTIFIER  NULL,
    FirstContactDeadline DATETIME2         NULL,
    FirstContactedAt     DATETIME2         NULL,
    SlaStatus            NVARCHAR(20)      NULL,
    LeadSource           NVARCHAR(50)      NULL,
    LeadSourceDetail     NVARCHAR(255)     NULL,
    Priority             NVARCHAR(10)      NOT NULL DEFAULT 'NORMAL',
    Notes                NVARCHAR(MAX)     NULL,
    CreatedAt            DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt            DATETIME2         NULL,
    ClosedAt             DATETIME2         NULL,
    CONSTRAINT PK_SalesPipeline PRIMARY KEY (Id)
);
GO

CREATE TABLE PipelineActivities (
    Id                BIGINT            NOT NULL IDENTITY(1,1),
    PipelineId        UNIQUEIDENTIFIER  NOT NULL REFERENCES SalesPipeline(Id),
    TenantId          UNIQUEIDENTIFIER  NOT NULL,
    AgentId           UNIQUEIDENTIFIER  NULL REFERENCES Agents(Id),
    ActivityType      NVARCHAR(30)      NOT NULL,
    OldStage          NVARCHAR(30)      NULL,
    NewStage          NVARCHAR(30)      NULL,
    Description       NVARCHAR(MAX)     NULL,
    Outcome           NVARCHAR(100)     NULL,
    ScheduledAt       DATETIME2         NULL,
    CompletedAt       DATETIME2         NULL,
    IsSystemGenerated BIT               NOT NULL DEFAULT 0,
    CreatedAt         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PipelineActivities PRIMARY KEY (Id)
);
GO

CREATE TABLE Quotations (
    Id                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId            UNIQUEIDENTIFIER  NOT NULL,
    QuotationCode       NVARCHAR(50)      NOT NULL,
    PipelineId          UNIQUEIDENTIFIER  NULL REFERENCES SalesPipeline(Id),
    CustomerId          UNIQUEIDENTIFIER  NOT NULL REFERENCES Customers(Id),
    AgentId             UNIQUEIDENTIFIER  NOT NULL REFERENCES Agents(Id),
    MasterProductId     UNIQUEIDENTIFIER  NOT NULL,
    ProductPlanId       UNIQUEIDENTIFIER  NULL,
    InputData           NVARCHAR(MAX)     NOT NULL,
    BasePremium         DECIMAL(18,2)     NOT NULL,
    DiscountAmount      DECIMAL(18,2)     NOT NULL DEFAULT 0,
    DiscountReason      NVARCHAR(255)     NULL,
    SurchargeAmount     DECIMAL(18,2)     NOT NULL DEFAULT 0,
    FinalPremium        DECIMAL(18,2)     NOT NULL,
    InsuredAmount       DECIMAL(18,2)     NULL,
    StartDate           DATE              NULL,
    EndDate             DATE              NULL,
    Status              NVARCHAR(20)      NOT NULL DEFAULT 'DRAFT',
    SentAt              DATETIME2         NULL,
    ViewedAt            DATETIME2         NULL,
    ExpiresAt           DATETIME2         NULL,
    AcceptedAt          DATETIME2         NULL,
    QuotePdfUrl         NVARCHAR(500)     NULL,
    Notes               NVARCHAR(MAX)     NULL,
    AgentNotes          NVARCHAR(MAX)     NULL,
    ConvertedPolicyId   UNIQUEIDENTIFIER  NULL,
    ConvertedAt         DATETIME2         NULL,
    CreatedAt           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt           DATETIME2         NULL,
    CONSTRAINT PK_Quotations PRIMARY KEY (Id),
    CONSTRAINT UQ_Quotations_Code UNIQUE (TenantId, QuotationCode)
);
GO

-- ============================================================
-- 05_Policies.sql
-- Policies, PolicyStatusHistory, PolicyDocuments
-- ============================================================

CREATE TABLE Policies (
    Id                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId                UNIQUEIDENTIFIER  NOT NULL,
    PolicyNumber            NVARCHAR(100)     NOT NULL,
    PolicyNumberNCC         NVARCHAR(100)     NULL,
    ReconcileCode           NVARCHAR(100)     NULL,
    QuotationId             UNIQUEIDENTIFIER  NULL REFERENCES Quotations(Id),
    PipelineId              UNIQUEIDENTIFIER  NULL REFERENCES SalesPipeline(Id),
    MasterProductId         UNIQUEIDENTIFIER  NOT NULL,
    ProductPlanId           UNIQUEIDENTIFIER  NULL,
    ProviderId              UNIQUEIDENTIFIER  NOT NULL,
    InsuranceType           NVARCHAR(50)      NOT NULL,
    CustomerId              UNIQUEIDENTIFIER  NOT NULL REFERENCES Customers(Id),
    InsuredName             NVARCHAR(255)     NULL,
    InsuredIdCard           NVARCHAR(20)      NULL,
    InsuredDOB              DATE              NULL,
    InsuredPhone            NVARCHAR(20)      NULL,
    InsuredRelationship     NVARCHAR(50)      NULL,
    InsuredObjectData       NVARCHAR(MAX)     NOT NULL,
    StartDate               DATE              NOT NULL,
    EndDate                 DATE              NOT NULL,
    DurationDays            INT               NOT NULL,
    BasePremium             DECIMAL(18,2)     NOT NULL,
    DiscountAmount          DECIMAL(18,2)     NOT NULL DEFAULT 0,
    SurchargeAmount         DECIMAL(18,2)     NOT NULL DEFAULT 0,
    FinalPremium            DECIMAL(18,2)     NOT NULL,
    PaymentInstallments     INT               NOT NULL DEFAULT 1,
    InstallmentAmount       DECIMAL(18,2)     NULL,
    InsuredAmount           DECIMAL(18,2)     NULL,
    SaleChannel             NVARCHAR(30)      NOT NULL,
    AgentId                 UNIQUEIDENTIFIER  NOT NULL REFERENCES Agents(Id),
    LandingPageId           UNIQUEIDENTIFIER  NULL,
    PolicyStatus            NVARCHAR(30)      NOT NULL DEFAULT 'DRAFT',
    PolicyStatusChangedAt   DATETIME2         NULL,
    PolicyStatusChangedBy   UNIQUEIDENTIFIER  NULL,
    PaymentStatus           NVARCHAR(20)      NOT NULL DEFAULT 'UNPAID',
    TotalPaid               DECIMAL(18,2)     NOT NULL DEFAULT 0,
    BalanceDue              DECIMAL(18,2)     NOT NULL DEFAULT 0,
    ProviderStatus          NVARCHAR(20)      NULL,
    ProviderSubmittedAt     DATETIME2         NULL,
    ProviderConfirmedAt     DATETIME2         NULL,
    ProviderRejectedAt      DATETIME2         NULL,
    ProviderRejectedReason  NVARCHAR(500)     NULL,
    ProviderResponse        NVARCHAR(MAX)     NULL,
    ReconciliationStatus    NVARCHAR(30)      NULL,
    ReconciliationPeriod    NVARCHAR(10)      NULL,
    ReconciledAt            DATETIME2         NULL,
    CommissionStatus        NVARCHAR(20)      NOT NULL DEFAULT 'PENDING',
    CommissionPaidAt        DATETIME2         NULL,
    CommissionBatchId       UNIQUEIDENTIFIER  NULL,
    RenewalStatus           NVARCHAR(20)      NULL,
    PreviousPolicyId        UNIQUEIDENTIFIER  NULL REFERENCES Policies(Id),
    RenewalPolicyId         UNIQUEIDENTIFIER  NULL REFERENCES Policies(Id),
    RenewalReminderSentAt   DATETIME2         NULL,
    RenewalReminderCount    INT               NOT NULL DEFAULT 0,
    ContractPdfUrl          NVARCHAR(500)     NULL,
    CertificatePdfUrl       NVARCHAR(500)     NULL,
    InvoiceUrl              NVARCHAR(500)     NULL,
    CancelledAt             DATETIME2         NULL,
    CancelReason            NVARCHAR(50)      NULL,
    CancelNote              NVARCHAR(500)     NULL,
    CancelledBy             UNIQUEIDENTIFIER  NULL,
    RefundAmount            DECIMAL(18,2)     NULL,
    Notes                   NVARCHAR(MAX)     NULL,
    InternalNotes           NVARCHAR(MAX)     NULL,
    Tags                    NVARCHAR(500)     NULL,
    CreatedAt               DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CreatedBy               UNIQUEIDENTIFIER  NULL,
    UpdatedAt               DATETIME2         NULL,
    UpdatedBy               UNIQUEIDENTIFIER  NULL,
    IsDeleted               BIT               NOT NULL DEFAULT 0,
    CONSTRAINT PK_Policies PRIMARY KEY (Id),
    CONSTRAINT UQ_Policies_Number UNIQUE (TenantId, PolicyNumber)
);
GO

CREATE TABLE PolicyStatusHistory (
    Id            BIGINT            NOT NULL IDENTITY(1,1),
    PolicyId      UNIQUEIDENTIFIER  NOT NULL REFERENCES Policies(Id),
    TenantId      UNIQUEIDENTIFIER  NOT NULL,
    OldStatus     NVARCHAR(30)      NULL,
    NewStatus     NVARCHAR(30)      NOT NULL,
    ChangeReason  NVARCHAR(500)     NULL,
    ChangedBy     UNIQUEIDENTIFIER  NULL,
    ChangedByType NVARCHAR(20)      NULL,
    Notes         NVARCHAR(MAX)     NULL,
    ChangedAt     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PolicyStatusHistory PRIMARY KEY (Id)
);
GO

CREATE TABLE PolicyDocuments (
    Id          UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    PolicyId    UNIQUEIDENTIFIER  NOT NULL REFERENCES Policies(Id),
    TenantId    UNIQUEIDENTIFIER  NOT NULL,
    DocType     NVARCHAR(50)      NOT NULL,
    DocName     NVARCHAR(255)     NULL,
    FileUrl     NVARCHAR(500)     NOT NULL,
    FileSize    BIGINT            NULL,
    MimeType    NVARCHAR(100)     NULL,
    Source      NVARCHAR(20)      NULL,
    IsVerified  BIT               NOT NULL DEFAULT 0,
    UploadedBy  UNIQUEIDENTIFIER  NULL,
    UploadedAt  DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    IsActive    BIT               NOT NULL DEFAULT 1,
    CONSTRAINT PK_PolicyDocuments PRIMARY KEY (Id)
);
GO

-- ============================================================
-- 06_Payments.sql
-- PaymentTransactions, PaymentWebhookLog, InstallmentSchedule
-- ============================================================

CREATE TABLE PaymentTransactions (
    Id                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId            UNIQUEIDENTIFIER  NOT NULL,
    TransactionCode     NVARCHAR(100)     NOT NULL,
    PolicyId            UNIQUEIDENTIFIER  NOT NULL REFERENCES Policies(Id),
    CustomerId          UNIQUEIDENTIFIER  NOT NULL REFERENCES Customers(Id),
    AgentId             UNIQUEIDENTIFIER  NULL REFERENCES Agents(Id),
    Amount              DECIMAL(18,2)     NOT NULL,
    Currency            NVARCHAR(10)      NOT NULL DEFAULT 'VND',
    PaymentType         NVARCHAR(20)      NOT NULL,
    InstallmentNumber   INT               NULL,
    PaymentMethod       NVARCHAR(30)      NOT NULL,
    PaymentGateway      NVARCHAR(30)      NULL,
    GatewayTransactionId NVARCHAR(200)    NULL,
    GatewayOrderId      NVARCHAR(200)     NULL,
    GatewayPayUrl       NVARCHAR(500)     NULL,
    GatewayStatus       NVARCHAR(50)      NULL,
    GatewayResponse     NVARCHAR(MAX)     NULL,
    BankCode            NVARCHAR(50)      NULL,
    CardType            NVARCHAR(30)      NULL,
    AccountNumber       NVARCHAR(50)      NULL,
    Status              NVARCHAR(20)      NOT NULL DEFAULT 'PENDING',
    InitiatedAt         DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CompletedAt         DATETIME2         NULL,
    ExpiredAt           DATETIME2         NULL,
    FailedAt            DATETIME2         NULL,
    FailReason          NVARCHAR(500)     NULL,
    ReceiptNumber       NVARCHAR(100)     NULL,
    ReceiptUrl          NVARCHAR(500)     NULL,
    InvoiceNumber       NVARCHAR(100)     NULL,
    IsRefund            BIT               NOT NULL DEFAULT 0,
    RefundForTxnId      UNIQUEIDENTIFIER  NULL,
    RefundReason        NVARCHAR(500)     NULL,
    RefundedAt          DATETIME2         NULL,
    Notes               NVARCHAR(500)     NULL,
    CreatedAt           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt           DATETIME2         NULL,
    CONSTRAINT PK_PaymentTransactions PRIMARY KEY (Id),
    CONSTRAINT UQ_PaymentTxn_Code UNIQUE (TenantId, TransactionCode)
);
GO

CREATE TABLE PaymentWebhookLog (
    Id              BIGINT            NOT NULL IDENTITY(1,1),
    TenantId        UNIQUEIDENTIFIER  NULL,
    Gateway         NVARCHAR(30)      NOT NULL,
    EventType       NVARCHAR(100)     NULL,
    RawPayload      NVARCHAR(MAX)     NOT NULL,
    ParsedTxnId     UNIQUEIDENTIFIER  NULL,
    IsVerified      BIT               NOT NULL DEFAULT 0,
    IsProcessed     BIT               NOT NULL DEFAULT 0,
    ProcessedAt     DATETIME2         NULL,
    ErrorMessage    NVARCHAR(500)     NULL,
    IpAddress       NVARCHAR(50)      NULL,
    ReceivedAt      DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PaymentWebhookLog PRIMARY KEY (Id)
);
GO

CREATE TABLE InstallmentSchedule (
    Id                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    PolicyId            UNIQUEIDENTIFIER  NOT NULL REFERENCES Policies(Id),
    TenantId            UNIQUEIDENTIFIER  NOT NULL,
    InstallmentNumber   INT               NOT NULL,
    DueDate             DATE              NOT NULL,
    Amount              DECIMAL(18,2)     NOT NULL,
    Status              NVARCHAR(20)      NOT NULL DEFAULT 'PENDING',
    PaidAmount          DECIMAL(18,2)     NOT NULL DEFAULT 0,
    PaidAt              DATETIME2         NULL,
    TransactionId       UNIQUEIDENTIFIER  NULL REFERENCES PaymentTransactions(Id),
    ReminderSentAt      DATETIME2         NULL,
    ReminderCount       INT               NOT NULL DEFAULT 0,
    CreatedAt           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_InstallmentSchedule PRIMARY KEY (Id)
);
GO

-- ============================================================
-- 07_Commission.sql
-- CommissionLedger, CommissionBatch, CommissionForecast
-- ============================================================

CREATE TABLE CommissionLedger (
    Id                    UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId              UNIQUEIDENTIFIER  NOT NULL,
    PolicyId              UNIQUEIDENTIFIER  NOT NULL REFERENCES Policies(Id),
    AgentId               UNIQUEIDENTIFIER  NOT NULL REFERENCES Agents(Id),
    BeneficiaryAgentId    UNIQUEIDENTIFIER  NOT NULL REFERENCES Agents(Id),
    CommissionType        NVARCHAR(20)      NOT NULL,
    OverrideLevel         INT               NULL,
    BasePremium           DECIMAL(18,2)     NOT NULL,
    CommissionRate        DECIMAL(6,5)      NOT NULL,
    GrossCommission       DECIMAL(18,2)     NOT NULL,
    TaxRate               DECIMAL(5,4)      NOT NULL DEFAULT 0.10,
    TaxAmount             DECIMAL(18,2)     NOT NULL DEFAULT 0,
    NetCommission         DECIMAL(18,2)     NOT NULL,
    PeriodYear            INT               NOT NULL,
    PeriodMonth           INT               NOT NULL,
    Status                NVARCHAR(20)      NOT NULL DEFAULT 'PENDING',
    StatusChangedAt       DATETIME2         NULL,
    StatusChangedBy       UNIQUEIDENTIFIER  NULL,
    ApprovedAt            DATETIME2         NULL,
    ApprovedBy            UNIQUEIDENTIFIER  NULL,
    BatchId               UNIQUEIDENTIFIER  NULL,
    BatchCode             NVARCHAR(50)      NULL,
    PaidAt                DATETIME2         NULL,
    PaymentReference      NVARCHAR(100)     NULL,
    CancelledAt           DATETIME2         NULL,
    CancelReason          NVARCHAR(500)     NULL,
    Notes                 NVARCHAR(500)     NULL,
    CreatedAt             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt             DATETIME2         NULL,
    CONSTRAINT PK_CommissionLedger PRIMARY KEY (Id)
);
GO

CREATE TABLE CommissionBatch (
    Id                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId            UNIQUEIDENTIFIER  NOT NULL,
    BatchCode           NVARCHAR(50)      NOT NULL,
    PeriodYear          INT               NOT NULL,
    PeriodMonth         INT               NOT NULL,
    TotalAgents         INT               NOT NULL DEFAULT 0,
    TotalPolicies       INT               NOT NULL DEFAULT 0,
    TotalGross          DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TotalTax            DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TotalNet            DECIMAL(18,2)     NOT NULL DEFAULT 0,
    Status              NVARCHAR(20)      NOT NULL DEFAULT 'DRAFT',
    PreparedBy          UNIQUEIDENTIFIER  NULL,
    PreparedAt          DATETIME2         NULL,
    ReviewedBy          UNIQUEIDENTIFIER  NULL,
    ReviewedAt          DATETIME2         NULL,
    ApprovedBy          UNIQUEIDENTIFIER  NULL,
    ApprovedAt          DATETIME2         NULL,
    PaidBy              UNIQUEIDENTIFIER  NULL,
    PaidAt              DATETIME2         NULL,
    Notes               NVARCHAR(MAX)     NULL,
    CreatedAt           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt           DATETIME2         NULL,
    CONSTRAINT PK_CommissionBatch PRIMARY KEY (Id),
    CONSTRAINT UQ_CommissionBatch UNIQUE (TenantId, BatchCode)
);
GO

CREATE TABLE CommissionForecast (
    Id                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId                UNIQUEIDENTIFIER  NOT NULL,
    AgentId                 UNIQUEIDENTIFIER  NOT NULL REFERENCES Agents(Id),
    PeriodYear              INT               NOT NULL,
    PeriodMonth             INT               NOT NULL,
    ForecastedPolicies      INT               NOT NULL DEFAULT 0,
    ForecastedRevenue       DECIMAL(18,2)     NOT NULL DEFAULT 0,
    ForecastedCommission    DECIMAL(18,2)     NOT NULL DEFAULT 0,
    ConfirmedPolicies       INT               NOT NULL DEFAULT 0,
    ConfirmedRevenue        DECIMAL(18,2)     NOT NULL DEFAULT 0,
    ConfirmedCommission     DECIMAL(18,2)     NOT NULL DEFAULT 0,
    ActualCommission        DECIMAL(18,2)     NOT NULL DEFAULT 0,
    CancelledCommission     DECIMAL(18,2)     NOT NULL DEFAULT 0,
    PendingNccCommission    DECIMAL(18,2)     NOT NULL DEFAULT 0,
    LastCalculatedAt        DATETIME2         NULL,
    CONSTRAINT PK_CommissionForecast PRIMARY KEY (Id),
    CONSTRAINT UQ_CommissionForecast UNIQUE (TenantId, AgentId, PeriodYear, PeriodMonth)
);
GO

-- ============================================================
-- 08_Reconciliation.sql
-- ReconciliationPeriods, ReconciliationItems
-- ============================================================

CREATE TABLE ReconciliationPeriods (
    Id                    UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId              UNIQUEIDENTIFIER  NOT NULL,
    PeriodCode            NVARCHAR(20)      NOT NULL,
    PeriodYear            INT               NOT NULL,
    PeriodMonth           INT               NOT NULL,
    PeriodStart           DATE              NOT NULL,
    PeriodEnd             DATE              NOT NULL,
    ProviderId            UNIQUEIDENTIFIER  NOT NULL,
    Status                NVARCHAR(20)      NOT NULL DEFAULT 'OPEN',
    TotalPoliciesPortal   INT               NOT NULL DEFAULT 0,
    TotalPoliciesNCC      INT               NOT NULL DEFAULT 0,
    TotalPremiumPortal    DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TotalPremiumNCC       DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TotalCommissionPortal DECIMAL(18,2)     NOT NULL DEFAULT 0,
    TotalCommissionNCC    DECIMAL(18,2)     NOT NULL DEFAULT 0,
    DiffPolicies          INT               NOT NULL DEFAULT 0,
    DiffPremium           DECIMAL(18,2)     NOT NULL DEFAULT 0,
    DiffCommission        DECIMAL(18,2)     NOT NULL DEFAULT 0,
    SubmittedAt           DATETIME2         NULL,
    SubmittedBy           UNIQUEIDENTIFIER  NULL,
    ProviderReviewedAt    DATETIME2         NULL,
    ProviderReviewNote    NVARCHAR(500)     NULL,
    FinalizedAt           DATETIME2         NULL,
    FinalizedBy           UNIQUEIDENTIFIER  NULL,
    ExportFileUrl         NVARCHAR(500)     NULL,
    NccImportFileUrl      NVARCHAR(500)     NULL,
    Notes                 NVARCHAR(MAX)     NULL,
    CreatedAt             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt             DATETIME2         NULL,
    CONSTRAINT PK_ReconciliationPeriods PRIMARY KEY (Id),
    CONSTRAINT UQ_ReconciliationPeriod UNIQUE (TenantId, PeriodCode, ProviderId)
);
GO

CREATE TABLE ReconciliationItems (
    Id                      UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    ReconciliationPeriodId  UNIQUEIDENTIFIER  NOT NULL REFERENCES ReconciliationPeriods(Id),
    TenantId                UNIQUEIDENTIFIER  NOT NULL,
    PolicyId                UNIQUEIDENTIFIER  NULL REFERENCES Policies(Id),
    PolicyNumber            NVARCHAR(100)     NULL,
    PolicyNumberNCC         NVARCHAR(100)     NULL,
    PortalStatus            NVARCHAR(30)      NULL,
    NccStatus               NVARCHAR(30)      NULL,
    PremiumPortal           DECIMAL(18,2)     NULL,
    PremiumNCC              DECIMAL(18,2)     NULL,
    CommissionPortal        DECIMAL(18,2)     NULL,
    CommissionNCC           DECIMAL(18,2)     NULL,
    MatchStatus             NVARCHAR(20)      NOT NULL DEFAULT 'UNMATCHED',
    DiffType                NVARCHAR(30)      NULL,
    DiffNote                NVARCHAR(500)     NULL,
    ResolvedAt              DATETIME2         NULL,
    ResolvedBy              UNIQUEIDENTIFIER  NULL,
    Resolution              NVARCHAR(30)      NULL,
    ResolutionNote          NVARCHAR(500)     NULL,
    RawNccData              NVARCHAR(MAX)     NULL,
    CreatedAt               DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_ReconciliationItems PRIMARY KEY (Id)
);
GO

-- ============================================================
-- 09_LandingPage.sql
-- LandingPageTemplates, LandingPages, LandingPageLeads, LandingPageViews
-- ============================================================

CREATE TABLE LandingPageTemplates (
    Id              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TemplateCode    NVARCHAR(50)      NOT NULL,
    TemplateName    NVARCHAR(255)     NOT NULL,
    Category        NVARCHAR(50)      NULL,
    ThumbnailUrl    NVARCHAR(500)     NULL,
    PreviewUrl      NVARCHAR(500)     NULL,
    LayoutConfig    NVARCHAR(MAX)     NOT NULL,
    IsActive        BIT               NOT NULL DEFAULT 1,
    IsPremium       BIT               NOT NULL DEFAULT 0,
    UsageCount      INT               NOT NULL DEFAULT 0,
    SortOrder       INT               NOT NULL DEFAULT 0,
    CreatedAt       DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_LandingPageTemplates PRIMARY KEY (Id),
    CONSTRAINT UQ_LandingPageTemplates_Code UNIQUE (TemplateCode)
);
GO

CREATE TABLE LandingPages (
    Id                  UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId            UNIQUEIDENTIFIER  NOT NULL,
    AgentId             UNIQUEIDENTIFIER  NULL REFERENCES Agents(Id),
    PageCode            NVARCHAR(50)      NOT NULL,
    PageTitle           NVARCHAR(255)     NOT NULL,
    PageType            NVARCHAR(30)      NOT NULL,
    -- SALE|RECRUITMENT|PROFILE|COMBINED|CAMPAIGN
    Subdomain           NVARCHAR(100)     NULL,
    CustomSlug          NVARCHAR(100)     NULL,
    FullUrl             NVARCHAR(500)     NULL,
    TemplateId          UNIQUEIDENTIFIER  NULL REFERENCES LandingPageTemplates(Id),
    LayoutConfig        NVARCHAR(MAX)     NOT NULL,
    FeaturedProductIds  NVARCHAR(MAX)     NULL,  -- JSON array of MasterProductIds
    LeadFormConfig      NVARCHAR(MAX)     NULL,
    MetaTitle           NVARCHAR(255)     NULL,
    MetaDescription     NVARCHAR(500)     NULL,
    MetaKeywords        NVARCHAR(500)     NULL,
    OgImageUrl          NVARCHAR(500)     NULL,
    FacebookPixelId     NVARCHAR(100)     NULL,
    GoogleAnalyticsId   NVARCHAR(50)      NULL,
    ZaloOAId            NVARCHAR(100)     NULL,
    TotalViews          BIGINT            NOT NULL DEFAULT 0,
    UniqueViews         BIGINT            NOT NULL DEFAULT 0,
    TotalLeads          INT               NOT NULL DEFAULT 0,
    TotalPolicies       INT               NOT NULL DEFAULT 0,
    ConversionRate      DECIMAL(5,4)      NULL,
    Status              NVARCHAR(20)      NOT NULL DEFAULT 'DRAFT',
    PublishedAt         DATETIME2         NULL,
    UnpublishedAt       DATETIME2         NULL,
    CreatedAt           DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt           DATETIME2         NULL,
    CONSTRAINT PK_LandingPages PRIMARY KEY (Id),
    CONSTRAINT UQ_LandingPages_Code UNIQUE (TenantId, PageCode)
);
GO

CREATE TABLE LandingPageLeads (
    Id                    UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId              UNIQUEIDENTIFIER  NOT NULL,
    LandingPageId         UNIQUEIDENTIFIER  NOT NULL REFERENCES LandingPages(Id),
    AgentId               UNIQUEIDENTIFIER  NULL REFERENCES Agents(Id),
    FullName              NVARCHAR(255)     NOT NULL,
    Phone                 NVARCHAR(20)      NOT NULL,
    Email                 NVARCHAR(255)     NULL,
    Message               NVARCHAR(1000)    NULL,
    ProductInterest       NVARCHAR(255)     NULL,
    FormData              NVARCHAR(MAX)     NULL,
    IpAddress             NVARCHAR(50)      NULL,
    UserAgent             NVARCHAR(500)     NULL,
    ReferrerUrl           NVARCHAR(500)     NULL,
    UtmSource             NVARCHAR(100)     NULL,
    UtmCampaign           NVARCHAR(100)     NULL,
    ConvertedToCustomerId UNIQUEIDENTIFIER  NULL REFERENCES Customers(Id),
    ConvertedToPipelineId UNIQUEIDENTIFIER  NULL,
    ConvertedAt           DATETIME2         NULL,
    Status                NVARCHAR(20)      NOT NULL DEFAULT 'NEW',
    -- NEW|CONTACTED|CONVERTED|INVALID|DUPLICATE
    CreatedAt             DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_LandingPageLeads PRIMARY KEY (Id)
);
GO

CREATE TABLE LandingPageViews (
    Id            BIGINT            NOT NULL IDENTITY(1,1),
    LandingPageId UNIQUEIDENTIFIER  NOT NULL REFERENCES LandingPages(Id),
    TenantId      UNIQUEIDENTIFIER  NOT NULL,
    SessionId     NVARCHAR(100)     NULL,
    IpAddress     NVARCHAR(50)      NULL,
    UserAgent     NVARCHAR(500)     NULL,
    ReferrerUrl   NVARCHAR(500)     NULL,
    UtmSource     NVARCHAR(100)     NULL,
    UtmMedium     NVARCHAR(100)     NULL,
    UtmCampaign   NVARCHAR(100)     NULL,
    Country       NVARCHAR(50)      NULL,
    City          NVARCHAR(100)     NULL,
    DeviceType    NVARCHAR(20)      NULL,  -- DESKTOP|MOBILE|TABLET
    ViewedAt      DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    TimeOnPage    INT               NULL,  -- seconds
    CONSTRAINT PK_LandingPageViews PRIMARY KEY (Id)
);
GO

-- ************************************************************
-- PART 3: SEED DATA
-- ************************************************************

USE TWL_MASTER;
GO

-- ========================
-- SEED: Roles
-- ========================
INSERT INTO Roles (Id, RoleCode, RoleName, RoleDescription, TenantLevel, IsSystemRole, SortOrder) VALUES
(NEWID(), 'SYSTEM_ADMIN',    N'Quản trị hệ thống',   N'Full access toàn hệ thống',        0, 1, 1),
(NEWID(), 'HQ_ADMIN',        N'HQ Administrator',     N'Quản trị HQ TWL',                  1, 1, 2),
(NEWID(), 'BRANCH_OWNER',    N'Chủ chi nhánh',        N'Owner của branch/company',          2, 1, 3),
(NEWID(), 'BRANCH_MANAGER',  N'Quản lý chi nhánh',    N'Manager vận hành chi nhánh',        2, 1, 4),
(NEWID(), 'TEAM_LEADER',     N'Team Leader',          N'Trưởng nhóm kinh doanh',            3, 1, 5),
(NEWID(), 'SENIOR_AGENT',    N'Senior Agent',         N'Agent cao cấp',                     3, 1, 6),
(NEWID(), 'AGENT',           N'Agent',                N'Đại lý bảo hiểm',                  3, 1, 7),
(NEWID(), 'ACCOUNTING',      N'Kế toán',              N'Quản lý tài chính, hoa hồng',       2, 1, 8),
(NEWID(), 'COMPLIANCE',      N'Kiểm soát nội bộ',     N'Audit, compliance',                 2, 1, 9),
(NEWID(), 'MEMBER',          N'Khách hàng thành viên',N'Khách hàng đăng ký tài khoản',      3, 0, 10),
(NEWID(), 'GUEST',           N'Khách vãng lai',       N'Mua online không có tài khoản',     3, 0, 11);
GO

-- ========================
-- SEED: Permissions
-- ========================
INSERT INTO Permissions (Id, PermissionCode, PermissionName, Module, Action) VALUES
-- Dashboard
(NEWID(), 'dashboard.view',         N'Xem Dashboard',              'DASHBOARD',   'VIEW'),
(NEWID(), 'dashboard.hq',           N'Dashboard HQ tổng hợp',      'DASHBOARD',   'VIEW_HQ'),
-- Tenant
(NEWID(), 'tenant.view',            N'Xem danh sách chi nhánh',    'TENANT',      'VIEW'),
(NEWID(), 'tenant.create',          N'Tạo chi nhánh',              'TENANT',      'CREATE'),
(NEWID(), 'tenant.update',          N'Cập nhật chi nhánh',         'TENANT',      'UPDATE'),
(NEWID(), 'tenant.suspend',         N'Khoá / mở chi nhánh',        'TENANT',      'SUSPEND'),
-- Agents
(NEWID(), 'agent.view',             N'Xem Agent',                  'AGENT',       'VIEW'),
(NEWID(), 'agent.create',           N'Tạo Agent',                  'AGENT',       'CREATE'),
(NEWID(), 'agent.update',           N'Cập nhật Agent',             'AGENT',       'UPDATE'),
(NEWID(), 'agent.approve',          N'Duyệt Agent',                'AGENT',       'APPROVE'),
(NEWID(), 'agent.terminate',        N'Kết thúc hợp đồng Agent',    'AGENT',       'TERMINATE'),
-- Customers
(NEWID(), 'customer.view',          N'Xem Khách hàng',             'CUSTOMER',    'VIEW'),
(NEWID(), 'customer.create',        N'Tạo Khách hàng',             'CUSTOMER',    'CREATE'),
(NEWID(), 'customer.update',        N'Cập nhật Khách hàng',        'CUSTOMER',    'UPDATE'),
(NEWID(), 'customer.delete',        N'Xoá Khách hàng',             'CUSTOMER',    'DELETE'),
-- Policies
(NEWID(), 'policy.view',            N'Xem Hợp đồng',               'POLICY',      'VIEW'),
(NEWID(), 'policy.create',          N'Tạo Hợp đồng',               'POLICY',      'CREATE'),
(NEWID(), 'policy.update',          N'Cập nhật HĐ',                'POLICY',      'UPDATE'),
(NEWID(), 'policy.cancel',          N'Huỷ Hợp đồng',               'POLICY',      'CANCEL'),
(NEWID(), 'policy.approve',         N'Duyệt phát hành HĐ',         'POLICY',      'APPROVE'),
-- Commission
(NEWID(), 'commission.view',        N'Xem Hoa hồng',               'COMMISSION',  'VIEW'),
(NEWID(), 'commission.calculate',   N'Tính Hoa hồng',              'COMMISSION',  'CALCULATE'),
(NEWID(), 'commission.approve',     N'Duyệt Hoa hồng',             'COMMISSION',  'APPROVE'),
(NEWID(), 'commission.pay',         N'Chi trả Hoa hồng',           'COMMISSION',  'PAY'),
-- Reconciliation
(NEWID(), 'reconcile.view',         N'Xem Đối soát',               'RECONCILE',   'VIEW'),
(NEWID(), 'reconcile.create',       N'Tạo kỳ Đối soát',            'RECONCILE',   'CREATE'),
(NEWID(), 'reconcile.submit',       N'Gửi NCC',                    'RECONCILE',   'SUBMIT'),
(NEWID(), 'reconcile.finalize',     N'Chốt Đối soát',              'RECONCILE',   'FINALIZE'),
-- LandingPage
(NEWID(), 'landing.view',           N'Xem Landing Page',           'LANDING',     'VIEW'),
(NEWID(), 'landing.create',         N'Tạo Landing Page',           'LANDING',     'CREATE'),
(NEWID(), 'landing.publish',        N'Xuất bản Landing Page',      'LANDING',     'PUBLISH'),
-- Products
(NEWID(), 'product.view',           N'Xem Sản phẩm',               'PRODUCT',     'VIEW'),
(NEWID(), 'product.create',         N'Tạo Sản phẩm',               'PRODUCT',     'CREATE'),
(NEWID(), 'product.approve',        N'Duyệt Sản phẩm',             'PRODUCT',     'APPROVE'),
-- Reports
(NEWID(), 'report.view',            N'Xem Báo cáo',                'REPORT',      'VIEW'),
(NEWID(), 'report.export',          N'Xuất Báo cáo',               'REPORT',      'EXPORT'),
-- Users
(NEWID(), 'user.view',              N'Xem Người dùng',             'USER',        'VIEW'),
(NEWID(), 'user.manage',            N'Quản lý Người dùng',         'USER',        'MANAGE'),
-- System
(NEWID(), 'system.config',          N'Cấu hình hệ thống',          'SYSTEM',      'CONFIG'),
(NEWID(), 'system.audit',           N'Xem Audit Log',              'SYSTEM',      'AUDIT');
GO

-- ============================================================
-- DEPLOYMENT COMPLETE
-- ============================================================
PRINT N'=== TWL PORTAL 360LIFE - Database deployment completed successfully! ===';
GO
