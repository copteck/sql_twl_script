-- ============================================================
-- HE THONG TWL PORTAL 360LIFE - DU LIEU MAU
-- FILE: DuLieu_VaiTro_Quyen.sql
-- MO TA: Du lieu khoi tao cho VaiTro va Quyen
-- ============================================================
USE TWL_MASTER;
GO

-- ========================
-- DU LIEU MAU: VaiTro
-- ========================
INSERT INTO VaiTro (Ma, MaVaiTro, TenVaiTro, MoTaVaiTro, CapChiNhanh, LaVaiTroHeThong, ThuTuHienThi) VALUES
(NEWID(), 'QUANTRI_HETHONG',    N'Quản trị hệ thống',       N'Toàn quyền truy cập hệ thống',                  0, 1, 1),
(NEWID(), 'QUANTRI_TRUSOCHINH', N'Quản trị Trụ sở chính',   N'Quản trị viên tại HQ TWL',                      1, 1, 2),
(NEWID(), 'CHU_CHINHANH',       N'Chủ chi nhánh',           N'Chủ sở hữu chi nhánh/công ty thành viên',       2, 1, 3),
(NEWID(), 'QUANLY_CHINHANH',    N'Quản lý chi nhánh',       N'Quản lý vận hành chi nhánh',                    2, 1, 4),
(NEWID(), 'TRUONG_NHOM',        N'Trưởng nhóm',             N'Trưởng nhóm kinh doanh',                        3, 1, 5),
(NEWID(), 'DAILY_CAOCAP',       N'Đại lý cao cấp',          N'Đại lý có kinh nghiệm, thành tích tốt',        3, 1, 6),
(NEWID(), 'DAI_LY',             N'Đại lý',                  N'Đại lý bảo hiểm thông thường',                  3, 1, 7),
(NEWID(), 'KE_TOAN',            N'Kế toán',                 N'Quản lý tài chính, hoa hồng, đối soát',         2, 1, 8),
(NEWID(), 'KIEM_SOAT',          N'Kiểm soát nội bộ',        N'Kiểm toán, tuân thủ quy định',                  2, 1, 9),
(NEWID(), 'THANH_VIEN',         N'Khách hàng thành viên',   N'Khách hàng đã đăng ký tài khoản',              3, 0, 10),
(NEWID(), 'KHACH_VANGLAI',      N'Khách vãng lai',          N'Mua online không cần tài khoản',                3, 0, 11);
GO

-- ========================
-- DU LIEU MAU: Quyen
-- ========================
INSERT INTO Quyen (Ma, MaQuyen, TenQuyen, PhanHe, HanhDong) VALUES
-- Bang dieu khien
(NEWID(), 'bangdieuhien.xem',          N'Xem Bảng điều khiển',            'BANGDIEUHIEN',    'XEM'),
(NEWID(), 'bangdieuhien.trusochinh',   N'Bảng điều khiển Trụ sở chính',   'BANGDIEUHIEN',    'XEM'),
-- Chi nhanh
(NEWID(), 'chinhanh.xem',              N'Xem danh sách chi nhánh',        'CHINHANH',        'XEM'),
(NEWID(), 'chinhanh.tao',              N'Tạo chi nhánh mới',              'CHINHANH',        'TAO'),
(NEWID(), 'chinhanh.capnhat',          N'Cập nhật chi nhánh',             'CHINHANH',        'CAPNHAT'),
(NEWID(), 'chinhanh.tamngung',         N'Khóa / mở chi nhánh',           'CHINHANH',        'CAPNHAT'),
-- Dai ly
(NEWID(), 'daily.xem',                 N'Xem Đại lý',                     'DAILY',           'XEM'),
(NEWID(), 'daily.tao',                 N'Tạo Đại lý mới',                 'DAILY',           'TAO'),
(NEWID(), 'daily.capnhat',             N'Cập nhật thông tin Đại lý',      'DAILY',           'CAPNHAT'),
(NEWID(), 'daily.duyet',               N'Duyệt Đại lý',                   'DAILY',           'DUYET'),
(NEWID(), 'daily.ngunghopdong',        N'Ngưng hợp đồng Đại lý',         'DAILY',           'CAPNHAT'),
-- Khach hang
(NEWID(), 'khachhang.xem',             N'Xem Khách hàng',                 'KHACHHANG',       'XEM'),
(NEWID(), 'khachhang.tao',             N'Tạo Khách hàng',                 'KHACHHANG',       'TAO'),
(NEWID(), 'khachhang.capnhat',         N'Cập nhật Khách hàng',            'KHACHHANG',       'CAPNHAT'),
(NEWID(), 'khachhang.xoa',             N'Xóa Khách hàng',                 'KHACHHANG',       'XOA'),
-- Hop dong
(NEWID(), 'hopdong.xem',               N'Xem Hợp đồng',                   'HOPDONG',         'XEM'),
(NEWID(), 'hopdong.tao',               N'Tạo Hợp đồng',                   'HOPDONG',         'TAO'),
(NEWID(), 'hopdong.capnhat',           N'Cập nhật Hợp đồng',             'HOPDONG',         'CAPNHAT'),
(NEWID(), 'hopdong.huy',               N'Hủy Hợp đồng',                   'HOPDONG',         'CAPNHAT'),
(NEWID(), 'hopdong.duyet',             N'Duyệt phát hành Hợp đồng',      'HOPDONG',         'DUYET'),
-- Hoa hong
(NEWID(), 'hoahong.xem',               N'Xem Hoa hồng',                   'HOAHONG',         'XEM'),
(NEWID(), 'hoahong.tinh',              N'Tính Hoa hồng',                  'HOAHONG',         'TAO'),
(NEWID(), 'hoahong.duyet',             N'Duyệt Hoa hồng',                 'HOAHONG',         'DUYET'),
(NEWID(), 'hoahong.chitra',            N'Chi trả Hoa hồng',               'HOAHONG',         'CAPNHAT'),
-- Doi soat
(NEWID(), 'doisoat.xem',               N'Xem Đối soát',                    'DOISOAT',         'XEM'),
(NEWID(), 'doisoat.tao',               N'Tạo kỳ Đối soát',                'DOISOAT',         'TAO'),
(NEWID(), 'doisoat.guincc',            N'Gửi NCC xác nhận',               'DOISOAT',         'CAPNHAT'),
(NEWID(), 'doisoat.chot',              N'Chốt Đối soát',                  'DOISOAT',         'DUYET'),
-- Trang dich
(NEWID(), 'trangdich.xem',             N'Xem Trang đích',                  'TRANGDICH',       'XEM'),
(NEWID(), 'trangdich.tao',             N'Tạo Trang đích',                  'TRANGDICH',       'TAO'),
(NEWID(), 'trangdich.xuatban',         N'Xuất bản Trang đích',            'TRANGDICH',       'XUATBAN'),
-- San pham
(NEWID(), 'sanpham.xem',               N'Xem Sản phẩm',                   'SANPHAM',         'XEM'),
(NEWID(), 'sanpham.tao',               N'Tạo Sản phẩm',                   'SANPHAM',         'TAO'),
(NEWID(), 'sanpham.duyet',             N'Duyệt Sản phẩm',                 'SANPHAM',         'DUYET'),
-- Bao cao
(NEWID(), 'baocao.xem',                N'Xem Báo cáo',                    'BAOCAO',          'XEM'),
(NEWID(), 'baocao.xuat',               N'Xuất Báo cáo',                   'BAOCAO',          'XEM'),
-- Nguoi dung
(NEWID(), 'nguoidung.xem',             N'Xem Người dùng',                 'NGUOIDUNG',       'XEM'),
(NEWID(), 'nguoidung.quanly',          N'Quản lý Người dùng',             'NGUOIDUNG',       'CAPNHAT'),
-- He thong
(NEWID(), 'hethong.cauhinh',           N'Cấu hình hệ thống',             'HETHONG',         'CAUHINH'),
(NEWID(), 'hethong.nhatky',            N'Xem Nhật ký hệ thống',          'HETHONG',         'XEM');
GO

-- ========================
-- DU LIEU MAU: DanhMucSanPham
-- ========================
INSERT INTO DanhMucSanPham (Ma, MaDanhMuc, TenDanhMuc, TenDanhMucEN, Cap, ThuTuHienThi) VALUES
(NEWID(), 'XE_CO_GIOI',        N'Bảo hiểm Xe cơ giới',        'Motor Vehicle Insurance',      1, 1),
(NEWID(), 'SUC_KHOE',          N'Bảo hiểm Sức khỏe',          'Health Insurance',             1, 2),
(NEWID(), 'DU_LICH',           N'Bảo hiểm Du lịch',           'Travel Insurance',             1, 3),
(NEWID(), 'TAI_NAN',           N'Bảo hiểm Tai nạn',           'Accident Insurance',           1, 4),
(NEWID(), 'TAI_SAN',           N'Bảo hiểm Tài sản',           'Property Insurance',           1, 5),
(NEWID(), 'DOANH_NGHIEP',     N'Bảo hiểm Doanh nghiệp',      'Enterprise Insurance',         1, 6),
(NEWID(), 'GIAO_DUC',          N'Bảo hiểm Giáo dục',          'Education Insurance',          1, 7),
(NEWID(), 'KHAC',              N'Bảo hiểm Khác',              'Other Insurance',              1, 8);
GO

-- ========================
-- DU LIEU MAU: CauHinhHeThong
-- ========================
INSERT INTO CauHinhHeThong (Ma, KhoaCauHinh, GiaTriCauHinh, LoaiCauHinh, MoTa) VALUES
(NEWID(), 'he_thong.ten_ung_dung',          N'TWL Portal 360Life',              'CHUOI',    N'Tên hiển thị của hệ thống'),
(NEWID(), 'he_thong.phien_ban',             N'2.0.0',                           'CHUOI',    N'Phiên bản hiện tại'),
(NEWID(), 'he_thong.email_ho_tro',          N'support@360life.vn',              'CHUOI',    N'Email hỗ trợ'),
(NEWID(), 'he_thong.sdt_ho_tro',            N'1900-xxxx',                       'CHUOI',    N'Hotline hỗ trợ'),
(NEWID(), 'thanh_toan.vnpay_bat',           N'true',                            'BOOLEAN',  N'Bật cổng VNPAY'),
(NEWID(), 'thanh_toan.momo_bat',            N'true',                            'BOOLEAN',  N'Bật cổng MoMo'),
(NEWID(), 'thanh_toan.zalopay_bat',         N'false',                           'BOOLEAN',  N'Bật cổng ZaloPay'),
(NEWID(), 'hoahong.ty_le_thue_mac_dinh',   N'0.10',                            'SO',       N'Thuế TNCN mặc định 10%'),
(NEWID(), 'hoahong.ngay_tra_mac_dinh',     N'15',                              'SO',       N'Ngày chi trả HH hàng tháng'),
(NEWID(), 'thongbao.gui_email_bat',         N'true',                            'BOOLEAN',  N'Bật gửi thông báo qua email'),
(NEWID(), 'thongbao.gui_sms_bat',           N'true',                            'BOOLEAN',  N'Bật gửi thông báo qua SMS'),
(NEWID(), 'thongbao.gui_zalo_bat',          N'true',                            'BOOLEAN',  N'Bật gửi thông báo qua Zalo'),
(NEWID(), 'baomat.so_lan_sai_mk_toi_da',   N'5',                               'SO',       N'Số lần nhập sai mật khẩu trước khi khóa'),
(NEWID(), 'baomat.thoi_gian_phien_phut',    N'480',                             'SO',       N'Thời gian phiên đăng nhập (phút)'),
(NEWID(), 'baomat.bat_buoc_2fa',            N'false',                           'BOOLEAN',  N'Bắt buộc xác thực 2 bước');
GO
