-- ============================================================
-- TWL PORTAL 360LIFE - TENANT DATABASE
-- FILE: 09_LandingPage.sql
-- ============================================================
GO

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
    -- JSON: {"theme":{...},"blocks":[{"id":"b1","type":"HeroBanner","order":1,"props":{...}},...]}
    LayoutConfig        NVARCHAR(MAX)     NOT NULL,
    FeaturedProductIds  NVARCHAR(MAX)     NULL,  -- JSON array of MasterProductIds
    -- JSON: {"fields":["name","phone","email","need"],"auto_assign_agent":true}
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
