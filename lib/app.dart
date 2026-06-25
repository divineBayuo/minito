// root widget wiring the theme and the router
// using consumer widget
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minito/core/theme/app_theme.dart';
import 'package:minito/features/auth/presentation/auth_screen.dart' as auth;
import 'package:minito/features/auth/presentation/providers/auth_provider.dart';
import 'package:minito/features/home/presentation/home_screen.dart' as home;
import 'package:minito/features/meetings/presentation/meeting_detail_screen.dart';
import 'package:minito/features/recording/presentation/record_screen.dart';
import 'package:minito/features/recording/presentation/upload_screen.dart';

class Minito extends ConsumerWidget {
  const Minito({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = _buildRouter(ref);

    return MaterialApp.router(
      title: 'Minito',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }

  GoRouter _buildRouter(WidgetRef ref) {
    return GoRouter(
      initialLocation: '/home',
      redirect: (context, state) {
        final isLoggedIn = ref.read(authProvider).isLoggedIn;
        final goingToAuth = state.matchedLocation == '/auth';
        if (!isLoggedIn && !goingToAuth) return '/auth';
        if (isLoggedIn && goingToAuth) return '/home';
        return null;
      },
      routes: [
        GoRoute(path: '/auth', builder: (_, _) => const auth.AuthScreen()),
        ShellRoute(
          // shell wraps screens that share the bottom navbar
          builder: (context, state, child) => AppShell(child: child),
          routes: [
            GoRoute(path: '/home', builder: (_, _) => const home.HomeScreen()),
            GoRoute(path: '/record', builder: (_, _) => const RecordScreen()),
            GoRoute(path: '/upload', builder: (_, _) => const UploadScreen()),
          ],
        ),
        GoRoute(
          // meeting detail is pushed on top, no navbar
          path: '/meeting/:id',
          builder: (_, state) =>
              MeetingDetailScreen(meetingId: state.pathParameters['id']!),
        ),
      ],
    );
  }
}

// persistent bottom nav bar
class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    int selectedIndex = switch (location) {
      '/home' => 0,
      '/record' => 1,
      '/upload' => 2,
      _ => 0,
    };

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              context.go('/home');
            case 1:
              context.go('/record');
            case 2:
              context.go('/upload');
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.mic_outlined),
            label: 'Record',
          ),
          NavigationDestination(
            icon: Icon(Icons.upload_file_outlined),
            label: 'Upload',
          ),
        ],
      ),
    );
  }
}
