import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/pos_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'widgets/global_app_bar.dart';
import 'theme/pos_theme.dart';
import 'services/sync_manager.dart';

void main() async {
  // Load environment variables from .env file
  await dotenv.load(fileName: '.env');

  runApp(const ProviderScope(child: POSApp()));
}

class POSApp extends ConsumerStatefulWidget {
  const POSApp({super.key});

  @override
  ConsumerState<POSApp> createState() => _POSAppState();
}

class _POSAppState extends ConsumerState<POSApp> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Initialize sync manager when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(syncManagerProvider); // Initialize sync manager
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // When app resumes/comes to foreground, only push local changes (don't pull)
    // This prevents unnecessary API calls while still syncing pending changes
    if (state == AppLifecycleState.resumed) {
      final authState = ref.read(authProvider);
      // Only sync if user is authenticated (not on login screen)
      if (authState.isAuthenticated) {
        final syncManager = ref.read(syncManagerProvider);
        // Only push local changes to server, don't pull from server
        // This is more efficient for offline-first architecture
        syncManager.pushLocalChanges(); // Non-blocking
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final themeMode = ref.watch(themeProvider);

    // Listen to auth state changes and navigate accordingly
    ref.listen<AuthState>(authProvider, (previous, next) {
      // If user logged out, navigate to login
      if (previous?.isAuthenticated == true && !next.isAuthenticated) {
        _navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      }
      // If user logged in, navigate to POS
      else if (previous?.isAuthenticated == false && next.isAuthenticated) {
        _navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/pos',
          (route) => false,
        );
      }
    });

    return MaterialApp(
      title: 'POS System',
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      theme: POSTheme.lightTheme,
      darkTheme: POSTheme.darkTheme,
      themeMode: themeMode,
      initialRoute: authState.isAuthenticated ? '/pos' : '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/pos': (context) => const POSScreen(),
      },
      onGenerateRoute: (settings) {
        // Handle routes that need auth state
        if ((settings.name == '/home' || settings.name == '/pos') &&
            !authState.isAuthenticated) {
          return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
        if (settings.name == '/login' && authState.isAuthenticated) {
          return MaterialPageRoute(builder: (_) => const POSScreen());
        }
        return null;
      },
      builder: (context, child) {
        // Only show GlobalAppBar on non-POS screens
        final route = ModalRoute.of(context);
        final isPOSScreen = route?.settings.name == '/pos';

        if (isPOSScreen) {
          return child!;
        }

        return Scaffold(appBar: const GlobalAppBar(), body: child!);
      },
    );
  }
}
