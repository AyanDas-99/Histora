import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/core/route/app_router.dart';
import 'package:histora/depedency_injector.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:histora/state/gps/respository/gps_repository.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  init();
  // Getting gps coordinates just to ensure device is connected. Not really necessary tho
  sl<GpsRepository>().getCurrentLocation();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => sl<AuthBloc>(),
    ),
    BlocProvider(
      create: (context) => sl<HistoryBloc>(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // Refreshing for auth check
        sl<AppRouter>().router.refresh();
      },
      child: MaterialApp.router(
        title: 'History',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'OpenSans'
        ),
        // routerConfig: sl<AppRouter>().router,
        routeInformationParser: sl<AppRouter>().router.routeInformationParser,
        routeInformationProvider:
            sl<AppRouter>().router.routeInformationProvider,
        routerDelegate: sl<AppRouter>().router.routerDelegate,
      ),
    );
  }
}


