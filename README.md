# 🗄️ TWL Portal 360Life – Thiết Kế CSDL Toàn Hệ Thống (Việt Hóa)

> **TheWorldLink (TWL) – Kênh 360Life**  
> Hệ thống cơ sở dữ liệu siêu lớn cho Portal Bảo hiểm Phi nhân thọ  
> ✅ **100% tên bảng & cột bằng tiếng Việt (không dấu)**

---

## 📁 Cấu Trúc Thư Mục

```
twl-portal-database/
├── 00_Master/                      ← CSDL Chính (TWL_MASTER)
│   ├── 01_DangKyChiNhanh.sql       → DangKyChiNhanh, CauHinhHeThong, GanSanPhamChiNhanh
│   ├── 02_NhaCungCapBaoHiem.sql    → NhaCungCapBaoHiem, TaiKhoanNganHangNCC, TyLeHoaHongNCC
│   ├── 03_SanPhamGoc.sql           → DanhMucSanPham, SanPhamGoc, GoiSanPham, BangGiaPhi, LichSuPhienBan
│   ├── 04_MauHoaHong.sql           → MauHoaHongGoc
│   └── 05_QuanLyTaiKhoan.sql       → NguoiDung, VaiTro, Quyen, GanVaiTro, PhienDangNhap
│
├── 01_Tenant/                      ← CSDL Chi Nhánh (TWL_[MaChiNhanh])
│   ├── 01_ToChucChiNhanh.sql       → ThongTinChiNhanh, DonViToChuc, CapBacDaiLy, CauHinhHoaHong
│   ├── 02_DaiLy.sql                → DaiLy, LichSuCapBacDaiLy
│   ├── 03_KhachHang_CRM.sql        → KhachHang, LichSuLienHeKhachHang, TaiLieuKhachHang
│   ├── 04_KeHoachBanHang.sql       → KeHoachBanHang, HoatDongBanHang, BaoGia
│   ├── 05_HopDong.sql              → HopDong, LichSuTrangThaiHopDong, TaiLieuHopDong
│   ├── 06_ThanhToan.sql            → GiaoDichThanhToan, NhatKyWebhookThanhToan, LichTraGop
│   ├── 07_HoaHong.sql              → SoHoaHong, LoHoaHong, DuBaoHoaHong
│   ├── 08_DoiSoat.sql              → KyDoiSoat, ChiTietDoiSoat
│   ├── 09_TrangDich.sql            → MauTrangDich, TrangDich, LeadTrangDich, LuotXemTrangDich
│   ├── 10_ThongBao.sql             → MauThongBao, ThongBao, LichSuGuiThongBao
│   └── 11_NhatKyHeThong.sql        → NhatKyHoatDong, NhatKyThayDoiDuLieu
│
├── 02_BaoCaoDuLieu/                ← Kho Dữ Liệu Báo Cáo (TWL_BAO_CAO)
│   ├── 01_BangChieuDuLieu.sql      → ChieuThoiGian, ChieuChiNhanh, ChieuDaiLy, ChieuSanPham, ChieuNCC, ChieuKhachHang
│   ├── 02_BangSuKien.sql           → SKDoanhThuNgay, SKHoaHongThang, SKLeadNgay, SKDoiSoatThang, SKChupNhanhHangNgay
│   └── 03_LuotXemBaoCao.sql        → Views: DoanhThu, HoaHong, Lead, TongQuan
│
├── 03_ThuTucLuuTru/                ← Thủ Tục Lưu Trữ (Stored Procedures)
│   ├── TT_TinhHoaHong.sql          → Tính hoa hồng trực tiếp + gián tiếp
│   ├── TT_TaoKyDoiSoat.sql         → Tạo kỳ đối soát & tổng hợp dữ liệu
│   ├── TT_DuBaoHoaHong.sql         → Dự báo hoa hồng hàng tháng
│   └── TT_ChupNhanhThongKeNgay.sql → Snapshot thống kê cuối ngày
│
├── 04_ChiMuc/                      ← Chỉ Mục (Indexes)
│   └── TatCaChiMuc.sql             → Tất cả chỉ mục tối ưu truy vấn
│
└── 05_DuLieuMau/                   ← Dữ Liệu Mẫu (Seed Data)
    ├── DuLieu_VaiTro_Quyen.sql     → Vai trò, Quyền, Danh mục SP, Cấu hình
    └── DuLieu_CapBacDaiLy.sql      → Cấp bậc đại lý mẫu
```

---

## 📊 Thống Kê Hệ Thống

| Thành phần | Số lượng |
|-----------|----------|
| Tổng số bảng | **50+** |
| Stored Procedures | **4** |
| Views báo cáo | **4** |
| Indexes | **20+** |
| Seed data entries | **60+** |

---

## 🚀 Hướng Dẫn Triển Khai

### Bước 1: Tạo CSDL Chính (Master)
```sql
CREATE DATABASE TWL_MASTER;
GO
USE TWL_MASTER;
-- Chạy lần lượt:
-- 00_Master/01_DangKyChiNhanh.sql
-- 00_Master/02_NhaCungCapBaoHiem.sql
-- 00_Master/03_SanPhamGoc.sql
-- 00_Master/04_MauHoaHong.sql
-- 00_Master/05_QuanLyTaiKhoan.sql
```

### Bước 2: Tạo CSDL Chi Nhánh (cho mỗi chi nhánh)
```sql
CREATE DATABASE TWL_HCM;     -- Chi nhánh HCM
CREATE DATABASE TWL_HANOI;   -- Chi nhánh Hà Nội
CREATE DATABASE TWL_DANANG;  -- Chi nhánh Đà Nẵng
GO
-- Chạy lần lượt các file trong 01_Tenant/ cho mỗi DB chi nhánh
```

### Bước 3: Tạo CSDL Báo Cáo
```sql
CREATE DATABASE TWL_BAO_CAO;
GO
USE TWL_BAO_CAO;
-- Chạy các file trong 02_BaoCaoDuLieu/
```

### Bước 4: Thủ Tục Lưu Trữ
```sql
-- Chạy các file trong 03_ThuTucLuuTru/ trên từng DB chi nhánh
```

### Bước 5: Chỉ Mục
```sql
-- Chạy 04_ChiMuc/TatCaChiMuc.sql trên từng DB chi nhánh
```

### Bước 6: Dữ Liệu Mẫu
```sql
-- Chạy 05_DuLieuMau/DuLieu_VaiTro_Quyen.sql trên TWL_MASTER
-- Chạy 05_DuLieuMau/DuLieu_CapBacDaiLy.sql trên từng DB chi nhánh
```

---

## 🏗️ Kiến Trúc Cơ Sở Dữ Liệu

| Cơ sở dữ liệu | Máy chủ | Mục đích |
|---------------|---------|----------|
| **TWL_MASTER** | Trụ sở chính | Đăng ký chi nhánh, Sản phẩm, Tài khoản, Cấu hình |
| **TWL_[MÃ]** | Máy chủ chi nhánh | Dữ liệu vận hành từng chi nhánh |
| **TWL_BAO_CAO** | Trụ sở chính | Kho dữ liệu báo cáo tổng hợp |

---

## 📋 Quy Tắc Đặt Tên (Tiếng Việt Không Dấu)

| Loại | Quy tắc | Ví dụ |
|------|---------|-------|
| Bảng | PascalCase tiếng Việt | `HopDong`, `KhachHang`, `DaiLy` |
| Cột | PascalCase tiếng Việt | `MaChiNhanh`, `TenSanPham`, `NgayTao` |
| Khóa chính | `Ma` (UNIQUEIDENTIFIER) | `Ma UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID()` |
| Khóa ngoại | `Ma` + Tên bảng liên quan | `MaKhachHang`, `MaDaiLy`, `MaHopDong` |
| Trạng thái | Enum dạng NVARCHAR | `'HOATDONG'`, `'TAM_NGUNG'`, `'DA_XOA'` |
| Ngày tạo/sửa | `NgayTao`, `NgayCapNhat` | DATETIME2, DEFAULT GETUTCDATE() |
| Soft delete | `DaXoa` + `NgayXoa` | BIT DEFAULT 0 |
| Index | `IX_TenBang_CacCot` | `IX_HopDong_DaiLy` |
| Stored Proc | `TT_MoTaChucNang` | `TT_TinhHoaHong` |
| Constraint | `PK_`, `UQ_`, `FK_` | `PK_HopDong`, `UQ_DaiLy_MaDL` |

---

## 🔑 Các Bảng Chính & Mô Tả

### 🏢 Master (00_Master)
| Bảng | Mô tả |
|------|-------|
| DangKyChiNhanh | Đăng ký & quản lý chi nhánh/đối tác |
| CauHinhHeThong | Cấu hình hệ thống & theo chi nhánh |
| NhaCungCapBaoHiem | Công ty bảo hiểm đối tác |
| SanPhamGoc | Sản phẩm bảo hiểm gốc |
| GoiSanPham | Các gói (Đồng/Bạc/Vàng) của sản phẩm |
| MauHoaHongGoc | Mẫu cấu hình hoa hồng |
| NguoiDung | Tài khoản người dùng |
| VaiTro / Quyen | Phân quyền RBAC |

### 👥 Tenant (01_Tenant)
| Bảng | Mô tả |
|------|-------|
| DaiLy | Đại lý bảo hiểm |
| KhachHang | Khách hàng (CRM) |
| KeHoachBanHang | Pipeline bán hàng |
| BaoGia | Báo giá cho khách |
| HopDong | Hợp đồng bảo hiểm |
| GiaoDichThanhToan | Giao dịch thanh toán |
| SoHoaHong | Sổ hoa hồng (chi tiết) |
| LoHoaHong | Lô chi trả hoa hồng |
| KyDoiSoat | Đối soát với NCC |
| TrangDich | Landing page |
| ThongBao | Thông báo hệ thống |
| NhatKyHoatDong | Audit log |

---

## 📊 Công Nghệ Sử Dụng

- **SQL Server 2022** – Cơ sở dữ liệu
- **.NET 8 / EF Core 8** – Backend
- **ASP.NET Core API** – REST API
- **Blazor Web App + Radzen UI** – Frontend

---

## 🌟 Tính Năng Nổi Bật

- ✅ Multi-tenant (đa chi nhánh) với CSDL riêng biệt
- ✅ Hệ thống phân cấp đại lý (MLM) tối đa 6 cấp
- ✅ Tính hoa hồng tự động (trực tiếp + gián tiếp)
- ✅ Đối soát NCC tự động
- ✅ Landing page builder cho đại lý
- ✅ CRM khách hàng tích hợp
- ✅ Thanh toán online (VNPay, MoMo, ZaloPay)
- ✅ Báo cáo Data Warehouse theo mô hình Star Schema
- ✅ Audit log & Change Data Capture
- ✅ Thông báo đa kênh (App, Email, SMS, Zalo)
- ✅ 100% tên bảng/cột tiếng Việt – dễ hiểu cho team Việt Nam

---

*Thiết kế bởi TWL Portal 360Life – TheWorldLink – Phiên bản Việt hóa hoàn toàn*
