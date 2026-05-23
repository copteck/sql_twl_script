-- ============================================================
-- TWL PORTAL 360LIFE - SEED DATA
-- FILE: Seed_Roles_Permissions.sql
-- ============================================================
USE TWL_MASTER;
GO

-- ========================
-- SEED: Roles
-- ========================
INSERT INTO Roles (Id, RoleCode, RoleName, RoleDescription, TenantLevel, IsSystemRole, SortOrder) VALUES
(NEWID(), 'SYSTEM_ADMIN',    N'Quản trị hệ thống',   N'Full access toàn hệ thống',        0, 1, 1),
(NEWID(), 'HQ_ADMIN',        N'HQ Administrator',     N'Quản trị HQ TWL',                  1, 1, 2),
(NEWID(), 'BRANCH_OWNER',    N'Chủ chi nhánh',        N'Owner của branch/company',          2, 1, 3),
(NEWID(), 'BRANCH_MANAGER',  N'Quản lý chi nhánh',    N'Manager vận hành chi nhánh',        2, 1, 4),
(NEWID(), 'TEAM_LEADER',     N'Team Leader',          N'Trưởng nhóm kinh doanh',            3, 1, 5),
(NEWID(), 'SENIOR_AGENT',    N'Senior Agent',         N'Agent cao cấp',                     3, 1, 6),
(NEWID(), 'AGENT',           N'Agent',                N'Đại lý bảo hiểm',                  3, 1, 7),
(NEWID(), 'ACCOUNTING',      N'Kế toán',              N'Quản lý tài chính, hoa hồng',       2, 1, 8),
(NEWID(), 'COMPLIANCE',      N'Kiểm soát nội bộ',     N'Audit, compliance',                 2, 1, 9),
(NEWID(), 'MEMBER',          N'Khách hàng thành viên',N'Khách hàng đăng ký tài khoản',      3, 0, 10),
(NEWID(), 'GUEST',           N'Khách vãng lai',       N'Mua online không có tài khoản',     3, 0, 11);
GO

-- ========================
-- SEED: Permissions
-- ========================
INSERT INTO Permissions (Id, PermissionCode, PermissionName, Module, Action) VALUES
-- Dashboard
(NEWID(), 'dashboard.view',         N'Xem Dashboard',              'DASHBOARD',   'VIEW'),
(NEWID(), 'dashboard.hq',           N'Dashboard HQ tổng hợp',      'DASHBOARD',   'VIEW_HQ'),
-- Tenant
(NEWID(), 'tenant.view',            N'Xem danh sách chi nhánh',    'TENANT',      'VIEW'),
(NEWID(), 'tenant.create',          N'Tạo chi nhánh',              'TENANT',      'CREATE'),
(NEWID(), 'tenant.update',          N'Cập nhật chi nhánh',         'TENANT',      'UPDATE'),
(NEWID(), 'tenant.suspend',         N'Khoá / mở chi nhánh',        'TENANT',      'SUSPEND'),
-- Agents
(NEWID(), 'agent.view',             N'Xem Agent',                  'AGENT',       'VIEW'),
(NEWID(), 'agent.create',           N'Tạo Agent',                  'AGENT',       'CREATE'),
(NEWID(), 'agent.update',           N'Cập nhật Agent',             'AGENT',       'UPDATE'),
(NEWID(), 'agent.approve',          N'Duyệt Agent',                'AGENT',       'APPROVE'),
(NEWID(), 'agent.terminate',        N'Kết thúc hợp đồng Agent',    'AGENT',       'TERMINATE'),
-- Customers
(NEWID(), 'customer.view',          N'Xem Khách hàng',             'CUSTOMER',    'VIEW'),
(NEWID(), 'customer.create',        N'Tạo Khách hàng',             'CUSTOMER',    'CREATE'),
(NEWID(), 'customer.update',        N'Cập nhật Khách hàng',        'CUSTOMER',    'UPDATE'),
(NEWID(), 'customer.delete',        N'Xoá Khách hàng',             'CUSTOMER',    'DELETE'),
-- Policies
(NEWID(), 'policy.view',            N'Xem Hợp đồng',               'POLICY',      'VIEW'),
(NEWID(), 'policy.create',          N'Tạo Hợp đồng',               'POLICY',      'CREATE'),
(NEWID(), 'policy.update',          N'Cập nhật HĐ',                'POLICY',      'UPDATE'),
(NEWID(), 'policy.cancel',          N'Huỷ Hợp đồng',               'POLICY',      'CANCEL'),
(NEWID(), 'policy.approve',         N'Duyệt phát hành HĐ',         'POLICY',      'APPROVE'),
-- Commission
(NEWID(), 'commission.view',        N'Xem Hoa hồng',               'COMMISSION',  'VIEW'),
(NEWID(), 'commission.calculate',   N'Tính Hoa hồng',              'COMMISSION',  'CALCULATE'),
(NEWID(), 'commission.approve',     N'Duyệt Hoa hồng',             'COMMISSION',  'APPROVE'),
(NEWID(), 'commission.pay',         N'Chi trả Hoa hồng',           'COMMISSION',  'PAY'),
-- Reconciliation
(NEWID(), 'reconcile.view',         N'Xem Đối soát',               'RECONCILE',   'VIEW'),
(NEWID(), 'reconcile.create',       N'Tạo kỳ Đối soát',            'RECONCILE',   'CREATE'),
(NEWID(), 'reconcile.submit',       N'Gửi NCC',                    'RECONCILE',   'SUBMIT'),
(NEWID(), 'reconcile.finalize',     N'Chốt Đối soát',              'RECONCILE',   'FINALIZE'),
-- LandingPage
(NEWID(), 'landing.view',           N'Xem Landing Page',           'LANDING',     'VIEW'),
(NEWID(), 'landing.create',         N'Tạo Landing Page',           'LANDING',     'CREATE'),
(NEWID(), 'landing.publish',        N'Xuất bản Landing Page',      'LANDING',     'PUBLISH'),
-- Products
(NEWID(), 'product.view',           N'Xem Sản phẩm',               'PRODUCT',     'VIEW'),
(NEWID(), 'product.create',         N'Tạo Sản phẩm',               'PRODUCT',     'CREATE'),
(NEWID(), 'product.approve',        N'Duyệt Sản phẩm',             'PRODUCT',     'APPROVE'),
-- Reports
(NEWID(), 'report.view',            N'Xem Báo cáo',                'REPORT',      'VIEW'),
(NEWID(), 'report.export',          N'Xuất Báo cáo',               'REPORT',      'EXPORT'),
-- Users
(NEWID(), 'user.view',              N'Xem Người dùng',             'USER',        'VIEW'),
(NEWID(), 'user.manage',            N'Quản lý Người dùng',         'USER',        'MANAGE'),
-- System
(NEWID(), 'system.config',          N'Cấu hình hệ thống',          'SYSTEM',      'CONFIG'),
(NEWID(), 'system.audit',           N'Xem Audit Log',              'SYSTEM',      'AUDIT');
GO
