class ChiTiet{
  final String noiDung;
  final String diaDiem;
  final String thoiGianXayRaPA;
  final String tenChuDe;
  final int phanAnhId;
  final String thoiGianTaoPhanAnh;
  final String tinhTrangPA;
  final String thoiGianTraLoiPA;
  final String noiDungTraLoi;
  final String fileDinhKem;
  final String nhanVienTraLoi;
  final String hinhNguoiDung1;
  final String hinhNguoiDung2;
  final String hinhNguoiDung3;
  final String hinhNguoiDung4;
  final String hinhTraLoi1;
  final String hinhTraLoi2;
  final String hinhTraLoi3;
  final String hinhTraLoi4;
  bool isFavorist;
  ChiTiet(
    {this.noiDung, 
    this.diaDiem, 
    this.thoiGianXayRaPA, 
    this.tenChuDe, 
    this.phanAnhId, 
    this.thoiGianTaoPhanAnh,
    this.tinhTrangPA, 
    this.thoiGianTraLoiPA, 
    this.noiDungTraLoi, 
    this.fileDinhKem, 
    this.nhanVienTraLoi, 
    this.hinhNguoiDung1,
    this.hinhNguoiDung2, 
    this.hinhNguoiDung3, 
    this.hinhNguoiDung4,  
    this.hinhTraLoi1,
    this.hinhTraLoi2,
    this.hinhTraLoi3,
    this.hinhTraLoi4,});
    
    factory ChiTiet.fromJson(Map<String, dynamic> json) => ChiTiet(
      noiDung: json['noi_dung'], 
      diaDiem: json['dia_diem'],  
      thoiGianXayRaPA: json['time_xay_ra_pa'], 
      tenChuDe: json['ten_chu_de'], 
      phanAnhId: json['phan_anh_id'],  
      thoiGianTaoPhanAnh: json['time_tao_pa'],  
      tinhTrangPA: json['tinh_trang_pa'], 
      thoiGianTraLoiPA: json['time_tl_pa'], 
      noiDungTraLoi: json['noi_dung_tl'],  
      fileDinhKem: json['file_dinh_kem'],  
      nhanVienTraLoi: json['nhan_vien_tl'], 
      hinhNguoiDung1: json['anh_nguoi_dung1'],
      hinhNguoiDung2: json['anh_nguoi_dung2'], 
      hinhNguoiDung3: json['anh_nguoi_dung3'], 
      hinhNguoiDung4: json['anh_nguoi_dung4'],  
      hinhTraLoi1: json['anh_nguoi_tl1'], 
      hinhTraLoi2: json['anh_nguoi_tl2'], 
      hinhTraLoi3: json['anh_nguoi_tl3'], 
      hinhTraLoi4: json['anh_nguoi_tl4'], 
      );
}

    