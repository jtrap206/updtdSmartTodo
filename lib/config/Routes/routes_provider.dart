
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_new/config/Routes/routes.dart';

final routesProvider = Provider<GoRouter>((Ref){
return GoRouter(
  initialLocation: RouteLocation.home,
  navigatorKey: navigationKey,
  routes: appRoutes,
);
}
);