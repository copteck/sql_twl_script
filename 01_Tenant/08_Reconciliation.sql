-- ============================================================
-- TWL PORTAL 360LIFE - TENANT DATABASE
-- FILE: 08_Reconciliation.sql
-- ============================================================
GO

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
