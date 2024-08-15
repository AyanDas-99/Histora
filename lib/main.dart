import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/core/route/app_router.dart';
import 'package:histora/depedency_injector.dart';
import 'package:histora/env/env.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => sl<AuthBloc>(),
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
      // final files = await ImagePicker().pickMultiImage();
      // if (files.isEmpty) {
      //   throw Exception('No file selected');
      // }

      final apiKey = Env.geminiKey;

      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        // safetySettings: Adjust safety settings
        // See https://ai.google.dev/gemini-api/docs/safety-settings
        generationConfig: GenerationConfig(
          temperature: 1,
          topK: 64,
          topP: 0.95,
          maxOutputTokens: 8192,
          responseMimeType: 'text/plain',
        ),
      );

      // final List<DataPart> dataFiles = [];

      // for (XFile file in files) {
      //   final DataPart data = DataPart(
      //     file.mimeType ?? 'image/jpeg',
      //     await file.readAsBytes(),
      //   );
      //   dataFiles.add(data);
      // }

      final content = Content.multi([
        // ...dataFiles,
        TextPart(
            '[https://firebasestorage.googleapis.com/v0/b/verve-f9fb9.appspot.com/o/CuuM73OXrVcQ1zwBa5oHy7ChSpJ2%2Fimages%2Fa96ba06b-280a-4125-b8f7-8371ff495f98?alt=media&token=0258c2b2-0d45-4605-9f75-0df6116ac918]\n\n[https://firebasestorage.googleapis.com/v0/b/verve-f9fb9.appspot.com/o/CuuM73OXrVcQ1zwBa5oHy7ChSpJ2%2Fimages%2F264643d2-a0cd-4330-aecc-cac9df747b28?alt=media&token=7355a6e5-f34d-4512-a933-d7912b40cac0]'),

        TextPart(
            '''Analyze the provided images to determine confidence(percentage) in how similar they are in appearance.
            \n\n**Input:**\n* 
            Image 1: Single image of a historical structure.\n* 
            Image Set: Multiple images of another historical structure, potentially showing different angles or lighting conditions.\n\n
            **Output:**\n* Json value indicating whether Image 1 and Image Set represent the same structure.\nexample:\n
            {\nisSame: (true if confidence is more than 95%),\n
            message: generated message,
            confidence: (percentage of how similar they are)
            }\n\n
            **Criteria:**\n
            * Focus on architectural elements and overall structure shape.\n
            * Consider variations in lighting, angle, and perspective.\n
            * Disregard changes in surrounding environment or minor structural details.\n
            * Treat images of the same person with different postures as different structures.'''),
      ]);

      final GenerateContentResponse response =
          await model.generateContent([content]);
      print(response.text);
      if (response.text != null) {
        result = response.text!;
      } else {
        result = 'Nothing found';
      }
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
