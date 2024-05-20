import '../../../../core/utils/base_parameters.dart';

class GetCategoryParameters extends BaseParameters {
  final String id;

  const GetCategoryParameters({required this.id});

  @override
  Map<String, dynamic> toJson() => {};
  @override
  List<Object> get props => [id];
}
