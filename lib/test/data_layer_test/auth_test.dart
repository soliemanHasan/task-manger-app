import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:task_manger_app/modules/auth/data/data_source/auth_data_source.dart';
import 'package:task_manger_app/modules/auth/data/data_source/auth_remote_data_source_imp.dart';
import 'package:task_manger_app/modules/auth/data/models/user_model.dart';
import 'package:task_manger_app/modules/auth/domain/parameters/login_parameters.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late AuthDataSource authDataSource;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;

    authDataSource = AuthRemoteDataSourceImp();
  });

  const loginParams = LoginParameters(userName: 'atuny0', password: '9uQFF1Lh');
  const userModel = UserModel(
      id: 1,
      userName: 'atuny0',
      email: 'atuny0@sohu.com',
      firstName: 'Terry',
      lastName: 'Medhurst',
      gender: 'male',
      image: 'https://robohash.org/Terry.png?set=set4',
      token:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..PiemvreHEomoQik2AzVs8Vg6SN-tV0ttF8QaQIMJvGU");

  test('should return UserModel when login is successful', () async {
    // Arrange
    dioAdapter.onPost(
        '/login', (server) => server.reply(200, userModel.toJson()));

    // Act
    final result = await authDataSource.login(loginParams);

    // Assert
    expect(result, equals(userModel));
  });

  test('should throw an exception when login fails', () async {
    // Arrange
    dioAdapter.onPost(
        '/login', (server) => server.reply(400, {'message': 'Login Failed'}));

    // Act & Assert
    expect(authDataSource.login(const LoginParameters(userName: "ds", password: "sds")), throwsException);
  });
}
