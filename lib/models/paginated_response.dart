class PaginatedResponse<T> {
  const PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasNextPage => currentPage < lastPage;

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse(
      data: (json['data'] as List).map((e) => fromJsonT(e)).toList(),
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      total: json['total'],
    );
  }
}
