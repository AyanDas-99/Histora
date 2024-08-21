import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/core/utils/pick_images.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String get name => 'home';

  static String get path => '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthStateLoggedIn) {
                  return Text('${state.user.uid} ${state.user.displayName}');
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(Logout());
              },
              child: const Text('Log out'),
            ),
            BlocConsumer<HistoryBloc, HistoryState>(
              listener: (context, state) {
                if (state is HistoryNotFound) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('History not found...Dammmmmm')));
                }
                if (state is HistoryFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Dammmmmm ${state.message}')));
                }
              },
              builder: (context, state) {
                return switch (state) {
                  HistoryInitial() => const SearchButton(),
                  HistoryLoading() => const Loader('Loading...'),
                  GPSLoading() => const Loader('Getting GPS Location...'),
                  NearestStructureLoading() =>
                    const Loader('Getting structures nearest to you...'),
                  MatchingImages() =>
                    const Loader('Matching to you with AI...'),
                  DetailLoading() =>
                    const Loader('Hurray!! Match found. Loading details...'),
                  HistorySuccess() => Column(
                      children: [
                        Text(state.structure.title),
                        ...state.structure.images
                            .map((image) => Image.network(image)),
                        const SizedBox(height: 20),
                        state.structure.history.build(),
                      ],
                    ),
                  HistoryNotFound() => const SearchButton(),
                  HistoryFailed() => const SearchButton(),
                };
              },
            )
          ],
        ),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          final image = await pickImage();
          if (image == null) return;
          if (context.mounted) {
            context
                .read<HistoryBloc>()
                .add(SearchPhoto(imageFromUser: image.path));
          }
        },
        child: const Text('Get'));
  }
}

class Loader extends StatelessWidget {
  final String text;
  const Loader(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text),
        const CircularProgressIndicator(),
      ],
    );
  }
}
