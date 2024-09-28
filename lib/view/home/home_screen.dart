import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/core/utils/pick_images.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';
import 'package:histora/view/history/history_screen.dart';
import 'package:histora/view/widgets/custom_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String get name => 'home';

  static String get path => '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedImage;

  onUncoverClicked(BuildContext content, bool fromCamera) async {
    final image = await pickImage(fromCamera);

    if (image == null) {
      return;
    } else {
      if (mounted) {
        context.read<HistoryBloc>().add(SearchPhoto(imageFromUser: image.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Let's discover the unique, and know the unknown !",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Rosarivo',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/man-with-cam.avif')),
            ),
            const SizedBox(height: 20),
            const Text(
              "Search for history of unique place by uploading an image of the place",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.orange.shade600),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () => onUncoverClicked(context, true),
                    child: const Text(
                      'Use Camera',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.blue),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () => onUncoverClicked(context, false),
                    child: BlocConsumer<HistoryBloc, HistoryState>(
                      listener: (context, state) {
                        if (state is HistoryFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(
                              text: state.message,
                              type: SnackBarType.error,
                            ),
                          );
                        }
                        if (state is HistoryNotFound) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(
                                text: 'Not found :(', type: SnackBarType.error),
                          );
                        }
                        if (state is HistorySuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(
                                text:
                                    'Found structure ${state.structure.title}',
                                type: SnackBarType.success),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  HistoryScreen(structure: state.structure),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return const UncoverBtn();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class UncoverBtn extends StatelessWidget {
  const UncoverBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Use Gallery',
      style: TextStyle(color: Colors.white),
    );
  }
}
