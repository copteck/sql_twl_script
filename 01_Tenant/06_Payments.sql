-- ============================================================
-- TWL PORTAL 360LIFE - TENANT DATABASE
-- FILE: 06_Payments.sql
-- ============================================================
GO

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
