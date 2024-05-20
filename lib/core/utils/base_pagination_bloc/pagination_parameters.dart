import 'package:task_manger_app/core/utils/base_parameters.dart';

abstract class PaginationParameters extends BaseParameters {
  final int limit;
  final int skip;

  const PaginationParameters({
    required this.limit,
    required this.skip,
  });

  @override
  Map<String, dynamic> toJson();

  @override
  List<Object> get props => [
        skip,
        limit,
      ];
}
