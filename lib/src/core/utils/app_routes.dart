import 'package:stackbudget/src/features/auth/ui/views/auth_view.dart';
import 'package:stackbudget/src/features/home/ui/views/home_view.dart';
import 'package:url_strategy/url_strategy.dart' as url;
import 'package:go_router/go_router.dart';

class AppRoutes {
  AppRoutes._();

  static void setPathUrlStrategy() {
    url.setPathUrlStrategy();
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  static final GoRouter routerConfig = GoRouter(
    initialLocation: '/${AuthView.routeName}',
    routes: [
      GoRoute(
        path: '/${AuthView.routeName}',
        name: AuthView.routeName,
        builder: (context, state) => const AuthView(),
      ),
      GoRoute(
        path: '/',
        name: HomeView.routeName,
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}
