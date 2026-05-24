# 🗄️ TWL Portal 360Life – Full Database Design

> **TheWorldLink (TWL) – Kênh 360Life**  
> Thiết kế database toàn hệ thống Portal Bảo hiểm Phi nhân thọ

---

## 📁 Cấu trúc thư mục

```
twl-portal-database/
├── 00_Master/              ← HQ Master Database (TWL_MASTER)
│   ├── 01_Tenants.sql          (DangKyDoiTac, CauHinhHeThong, LienKetSanPhamDoiTac)
│   ├── 02_InsuranceProviders.sql (NhaCungCapBaoHiem, TaiKhoanNganHangNCC, TyLeHoaHongNCC)
│   ├── 03_MasterProducts.sql   (DanhMucSanPham, SanPhamGoc, GoiSanPham, BangPhiBaoHiem, LichSuPhienBanSanPham)
│   └── 04_CommissionMaster.sql  (MauHoaHongGoc)
│
├── 01_Tenant/              ← Tenant Database (TWL_[BranchCode])
│   ├── 01_BranchOrg.sql        (ThongTinChiNhanh, DonViToChuc, CapBacDaiLy, CauHinhHoaHong)
│   ├── 02_Agents.sql           (DaiLy, LichSuCapBacDaiLy)
│   ├── 03_Customers_CRM.sql    (KhachHang, LichSuLienHeKH, TaiLieuKhachHang)
│   ├── 04_Pipeline.sql         (QuyTrinhBanHang, HoatDongBanHang, BaoGia)
│   ├── 05_Policies.sql         (HopDong, LichSuTrangThaiHD, TaiLieuHopDong)
│   ├── 06_Payments.sql         (GiaoDichThanhToan, NhatKyWebhook, LichTraGop)
│   ├── 07_Commission.sql       (SoHoaHong, DotChiHoaHong, DuBaoHoaHong)
│   ├── 08_Reconciliation.sql   (KyDoiSoat, ChiTietDoiSoat)
│   └── 09_LandingPage.sql      (MauTrangDich, TrangDich, KhachTiemNangTrangDich, LuotXemTrangDich)
│
├── 02_ReportDW/            ← Reporting Data Warehouse
│   ├── 01_Dimensions.sql
│   ├── 02_Facts.sql
│   └── 03_Views_Reports.sql
│
├── 03_StoredProcedures/    ← Stored Procedures
│   ├── SP_TinhHoaHong.sql
│   ├── SP_TaoDoiSoat.sql
│   ├── SP_DuBaoHoaHong.sql
│   └── SP_ThongKeHangNgay.sql
│
├── 04_Indexes/             ← Indexes & Constraints
│   └── All_Indexes.sql
│
└── 05_SeedData/            ← Seed Data (VaiTro, QuyenHan)
    ├── Seed_Roles_Permissions.sql
    ├── Seed_ProductCategories.sql
    └── Seed_SystemConfig.sql
```

---

## 🚀 Hướng dẫn Deploy

### Bước 1: Tạo Master Database
```sql
CREATE DATABASE TWL_MASTER;
GO
USE TWL_MASTER;
-- Chạy lần lượt các file trong 00_Master/
```

### Bước 2: Tạo Tenant Database (cho mỗi chi nhánh)
```sql
CREATE DATABASE TWL_HCM;   -- Chi nhánh HCM
CREATE DATABASE TWL_HANOI; -- Chi nhánh Hà Nội
-- Chạy lần lượt các file trong 01_Tenant/ cho mỗi DB
```

### Bước 3: Tạo Report Database
```sql
CREATE DATABASE TWL_REPORT_DW;
-- Chạy các file trong 02_ReportDW/
```

### Bước 4: Stored Procedures
```sql
-- Chạy các file trong 03_StoredProcedures/ trên từng DB
```

### Bước 5: Indexes
```sql
-- Chạy 04_Indexes/All_Indexes.sql
```

### Bước 6: Seed Data
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
