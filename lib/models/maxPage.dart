class MaxPage {
  final String page;
  final String maxpage;
  MaxPage({
    this.page,
    this.maxpage,
  });

  factory MaxPage.fromJson(Map<String, dynamic> json) => MaxPage(
        page: json['page'],
        maxpage: json['per_page'],
      );
}
