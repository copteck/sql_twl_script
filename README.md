# 🗄️ TWL Portal 360Life – Full Database Design

> **TheWorldLink (TWL) – Kênh 360Life**  
> Thiết kế database toàn hệ thống Portal Bảo hiểm Phi nhân thọ

---

## 📁 Cấu trúc thư mục

```
sql_twl_script/
├── 00_Master/              ← HQ Master Database (TWL_MASTER)
│   ├── 01_Tenants.sql
│   ├── 02_InsuranceProviders.sql
│   ├── 03_MasterProducts.sql
│   ├── 04_CommissionMaster.sql
│   └── 05_Identity.sql
│
├── 01_Tenant/              ← Tenant Database (TWL_[BranchCode])
│   ├── 01_BranchOrg.sql
│   ├── 02_Agents.sql
│   ├── 03_Customers_CRM.sql
│   ├── 04_Pipeline.sql
│   ├── 05_Policies.sql
│   ├── 06_Payments.sql
│   ├── 07_Commission.sql
│   ├── 08_Reconciliation.sql
│   └── 09_LandingPage.sql
│
└── 05_SeedData/            ← Seed Data
    └── Seed_Roles_Permissions.sql
```

---

## 🚀 Hướng dẫn Deploy

### Bước 1: Tạo Master Database
```sql
CREATE DATABASE TWL_MASTER;
GO
USE TWL_MASTER;
-- Chạy lần lượt:
-- 00_Master/01_Tenants.sql
-- 00_Master/02_InsuranceProviders.sql
-- 00_Master/03_MasterProducts.sql
-- 00_Master/04_CommissionMaster.sql
-- 00_Master/05_Identity.sql
```

### Bước 2: Tạo Tenant Database (cho mỗi chi nhánh)
```sql
CREATE DATABASE TWL_HCM;   -- Chi nhánh HCM
CREATE DATABASE TWL_HANOI; -- Chi nhánh Hà Nội
-- Chạy lần lượt các file trong 01_Tenant/ cho mỗi DB
```

### Bước 3: Seed Data
```sql
-- Chạy các file trong 05_SeedData/ trên TWL_MASTER
```

---

## 🏗️ Kiến trúc Database

| Database | Server | Mục đích |
|----------|--------|----------|
| TWL_MASTER | HQ Server | Tenant registry, Products, Identity |
| TWL_[CODE] | Branch Server | Dữ liệu từng chi nhánh |
| TWL_REPORT_DW | HQ Server | Aggregate reporting |

---

## 📊 Công nghệ
- **SQL Server 2022**
- **.NET 8 / EF Core 8**
- **ASP.NET Core API**
- **Blazor Web App + Radzen UI**

---
*Generated for TWL Portal 360Life – TheWorldLink*
