-- ============================================================
-- TWL PORTAL 360LIFE - TENANT DATABASE
-- FILE: 04_Pipeline.sql
-- ============================================================
GO

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
