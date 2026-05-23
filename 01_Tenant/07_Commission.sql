-- ============================================================
-- TWL PORTAL 360LIFE - TENANT DATABASE
-- FILE: 07_Commission.sql
-- ============================================================
GO

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
