import '../../../../core/utils/base_parameters.dart';

class RegisterParameters extends BaseParameters {
  final String name;
  final String password;
  final String phoneNumber;

  const RegisterParameters({
    required this.name,
    required this.password,
    required this.phoneNumber,
  });

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "phoneNumber": phoneNumber,
      };

  @override
  List<Object> get props => [name, password, phoneNumber];
}
