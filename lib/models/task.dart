class Task {
  final int id_phan_anh;

  Task({this.id_phan_anh});

  Map<String, dynamic> toMap() {
    return {
      'id_phan_anh': id_phan_anh,
    };
  }
}
