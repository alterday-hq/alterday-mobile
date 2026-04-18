import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/splash/splash_screen.dart';

CustomTransitionPage<void> _fadePage(Widget child) => CustomTransitionPage(
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      final isSplash = state.matchedLocation == '/splash';

      if (isLoading || isSplash) return null;

      final session = authState.asData?.value.session;
      final isAuthed = session != null && session.user.emailConfirmedAt != null;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isAuthed && !isAuthRoute) return '/login';
      if (isAuthed && isAuthRoute) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', pageBuilder: (context, state) => _fadePage(const SplashScreen())),
      GoRoute(path: '/login', pageBuilder: (context, state) => _fadePage(const LoginScreen())),
      GoRoute(path: '/register', pageBuilder: (context, state) => _fadePage(const RegisterScreen())),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => _fadePage(
          const Scaffold(body: Center(child: Text('Home — coming soon'))),
        ),
      ),
    ],
  );
});
