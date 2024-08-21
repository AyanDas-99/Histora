import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/core/route/app_router.dart';
import 'package:histora/core/utils/pick_images.dart';
import 'package:histora/depedency_injector.dart';
import 'package:histora/state/AI/ai_result.dart';
import 'package:histora/state/AI/repository/ai_repository.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  init();
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false;
  String result = 'Wowwwwwwww';

  compareImages() async {
    setState(() {
      loading = true;
    });

    try {
      final image = await pickImage();
      if (image == null) {
        return result = 'No image selected';
      }

      final response = await http.get(Uri.parse(
          'https://firebasestorage.googleapis.com/v0/b/histora-mobile.appspot.com/o/assets%2FJapanese%20Bunkere2587907-9369-41c7-b472-c8dad05f49f5%2Fa8ebad39-b2d7-4656-b6bb-f77f135fffbd?alt=media&token=c7e0b221-d2a7-4417-8fa1-b8027cd15eee'));

      final aiResponse = await AiRepositoryImpl().compareImageSets(
        UserImageBytes(image: await image.readAsBytes()),
        AssetImageBytes(
          images: [
            response.bodyBytes,
          ],
        ),
      );
      print(aiResponse);
      result = aiResponse.message;
    } catch (e) {
      result = e.toString();
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  createAccount() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Histora'),
      ),
      body: Center(
          child: loading ? const CircularProgressIndicator() : Text(result)),
      floatingActionButton:
          IconButton(onPressed: compareImages, icon: const Icon(Icons.air)),
    );
  }
}
