import 'package:go_router/go_router.dart';
import '../screens/hello_world_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'hello-world',
      builder: (context, state) => const HelloWorldScreen(),
    ),
  ],
);

