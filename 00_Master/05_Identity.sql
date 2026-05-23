-- ============================================================
-- TWL PORTAL 360LIFE - MASTER DATABASE
-- FILE: 05_Identity.sql
-- DESC: Roles, Permissions, RolePermissions, UserRoles
-- ============================================================
USE TWL_MASTER;
GO

CREATE TABLE Roles (
    Id              UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    RoleCode        NVARCHAR(50)      NOT NULL,
    RoleName        NVARCHAR(255)     NOT NULL,
    RoleDescription NVARCHAR(500)     NULL,
    TenantLevel     TINYINT           NOT NULL,
    IsSystemRole    BIT               NOT NULL DEFAULT 0,
    SortOrder       INT               NOT NULL DEFAULT 0,
    IsActive        BIT               NOT NULL DEFAULT 1,
    CreatedAt       DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt       DATETIME2         NULL,
    CONSTRAINT PK_Roles PRIMARY KEY (Id),
    CONSTRAINT UQ_Roles_Code UNIQUE (RoleCode)
);
GO

CREATE TABLE Permissions (
    Id             UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    PermissionCode NVARCHAR(100)     NOT NULL,
    PermissionName NVARCHAR(255)     NOT NULL,
    Module         NVARCHAR(50)      NOT NULL,
    Action         NVARCHAR(50)      NOT NULL,
    Description    NVARCHAR(500)     NULL,
    IsActive       BIT               NOT NULL DEFAULT 1,
    CreatedAt      DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt      DATETIME2         NULL,
    CONSTRAINT PK_Permissions PRIMARY KEY (Id),
    CONSTRAINT UQ_Permissions_Code UNIQUE (PermissionCode)
);
GO

CREATE TABLE RolePermissions (
    Id           UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    RoleId       UNIQUEIDENTIFIER  NOT NULL REFERENCES Roles(Id),
    PermissionId UNIQUEIDENTIFIER  NOT NULL REFERENCES Permissions(Id),
    IsGranted    BIT               NOT NULL DEFAULT 1,
    CreatedAt    DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CreatedBy    UNIQUEIDENTIFIER  NULL,
    CONSTRAINT PK_RolePermissions PRIMARY KEY (Id),
    CONSTRAINT UQ_RolePermission UNIQUE (RoleId, PermissionId)
);
GO

CREATE TABLE UserRoles (
    Id          UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID(),
    TenantId    UNIQUEIDENTIFIER  NULL REFERENCES TenantRegistry(Id),
    UserId      UNIQUEIDENTIFIER  NOT NULL,
    RoleId      UNIQUEIDENTIFIER  NOT NULL REFERENCES Roles(Id),
    AssignedBy  UNIQUEIDENTIFIER  NULL,
    AssignedAt  DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    ExpiredAt   DATETIME2         NULL,
    IsActive    BIT               NOT NULL DEFAULT 1,
    CONSTRAINT PK_UserRoles PRIMARY KEY (Id),
    CONSTRAINT UQ_UserRoles UNIQUE (TenantId, UserId, RoleId)
);
GO
