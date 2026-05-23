-- ============================================================
-- TWL PORTAL 360LIFE - MASTER DATABASE
-- FILE: 02_InsuranceProviders.sql
-- DESC: InsuranceProviders, ProviderBankAccounts, CommissionProviderRate
-- ============================================================
USE TWL_MASTER;
GO

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
