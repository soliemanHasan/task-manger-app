import 'package:task_manger_app/core/services/cache_storage_services.dart';

import '../../../../core/constants/apis_urls.dart';
import '../../../../core/services/api_services.dart';
// import '../../../../core/services/cache_storage_services.dart';
import '../../../../core/utils/app_response.dart';
import '../../domain/parameters/login_parameters.dart';
import '../models/user_model.dart';
import 'auth_data_source.dart';

class AuthRemoteDataSourceImp extends AuthDataSource {
  @override
  Future<UserModel> login(LoginParameters parameters) async {
    AppResponse response = await ApiServices().post(
      ApisUrls.login,
      data: parameters.toJson(),
    );
    await CacheStorageServices().setToken(response.data['token']);
    await CacheStorageServices().setId(response.data['id']);
    return UserModel.fromJson(response.data);
  }
}
