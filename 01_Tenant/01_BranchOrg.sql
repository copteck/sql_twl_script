-- ============================================================
-- TWL PORTAL 360LIFE - TENANT DATABASE
-- FILE: 01_BranchOrg.sql
-- ============================================================
GO

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
