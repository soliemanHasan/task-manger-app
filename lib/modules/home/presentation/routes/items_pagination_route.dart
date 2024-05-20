import 'package:go_router/go_router.dart';
import 'package:task_manger_app/modules/home/presentation/screens/items_pagination_screen.dart';

class ItemsPaginationRoute {
  static const String name = '/items_pagination';
  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) => const ItemsPaginationScreen(),
  );
}
