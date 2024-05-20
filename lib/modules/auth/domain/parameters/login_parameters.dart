import '../../../../core/utils/base_parameters.dart';

class LoginParameters extends BaseParameters {
  final String userName;
  final String password;

  const LoginParameters({
    required this.userName,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() => {
        "username": userName,
        "password": password,
      };

  @override
  List<Object> get props => [userName, password];
}
 