import '../../../../core/utils/base_pagination_bloc/pagination_parameters.dart';

class ItemsPaginationParameters extends PaginationParameters {
  const ItemsPaginationParameters({required super.limit, required super.skip});

  @override
  Map<String, dynamic> toJson() => {'limit': limit, 'skip': skip};

  @override
  List<Object> get props => [limit, skip];
}
