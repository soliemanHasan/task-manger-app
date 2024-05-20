import 'package:go_router/go_router.dart';
import 'package:task_manger_app/modules/auth/presentation/screens/login_screen.dart';

class LoginRoute {
  static const String name = '/login';

  static GoRoute route = GoRoute(
    path: name,
    // redirect: (context, state) {
    //   storage handler has token
    //   return
    // },
    builder: (context, state) => LoginScreen(),
  );
}
