class Result {
  final String timeXayRaPa;
  final String noiDung;
  final String tinhTrangPa;
  final String tenViTri;
  final String hinhnguoidung1;
  final String hinhnguoidung2;
  final String hinhnguoidung3;
  final String hinhnguoidung4;
  final String hinhtraloi1;
  final String hinhtraloi2;
  final String hinhtraloi3;
  final String hinhtraloi4;
  final int phanAnhId;
  
  Result(
      {this.timeXayRaPa,
      this.noiDung,
      this.tinhTrangPa,
      this.tenViTri,
      this.hinhnguoidung1,
      this.hinhnguoidung2,
      this.hinhnguoidung3,
      this.hinhnguoidung4,
      this.hinhtraloi1,
      this.hinhtraloi2,
      this.hinhtraloi3,
      this.hinhtraloi4,
      this.phanAnhId,});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      timeXayRaPa: json['thoi_gian_tao_pa'],
      noiDung: json['noi_dung'],
      tinhTrangPa: json['tinh_trang_pa'],
      phanAnhId: json['phan_anh_id'],
      tenViTri: json['ten_vi_tri'],
      hinhnguoidung1: json['anh_nguoi_dung1'],
      hinhnguoidung2: json['anh_nguoi_dung2'],
      hinhnguoidung3: json['anh_nguoi_dung3'],
      hinhnguoidung4: json['anh_nguoi_dung4'],
      hinhtraloi1: json['anh_nguoi_tl1'],
      hinhtraloi2: json['anh_nguoi_tl2'],
      hinhtraloi3: json['anh_nguoi_tl3'],
      hinhtraloi4: json['anh_nguoi_tl4'],
      );
}
