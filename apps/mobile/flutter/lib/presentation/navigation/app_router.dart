import 'package:go_router/go_router.dart';

import '../screens/tasks_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/tasks',
  routes: [
    GoRoute(
      path: '/tasks',
      name: 'tasks',
      builder: (context, state) => const TasksScreen(),
    ),
  ],
);
