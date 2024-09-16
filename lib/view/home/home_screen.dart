import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:histora/core/utils/pick_images.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';
import 'package:histora/view/history/history_screen.dart';
import 'package:histora/view/home/widgets/image_box.dart';
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

  onUncoverClicked(BuildContext content) {
    if (selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(text: 'Get image first ;)', type: SnackBarType.error),
      );
    } else {
      context
          .read<HistoryBloc>()
          .add(SearchPhoto(imageFromUser: selectedImage!));
    }
  }

  getOrResetImage(BuildContext context) async {
    final bool? getFromCamera = await fromCamera(context);
    if (getFromCamera == null) return;
    final image = await pickImage(getFromCamera);
    if (image != null) {
      setState(() {
        selectedImage = image.path;
      });
    }
  }

  Future<bool?> fromCamera(BuildContext context) async {
    final bool? fromCamera = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Gallery'),
              ),
            ],
          ),
        ),
      ),
    );

    return fromCamera;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            if (selectedImage != null)
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ImageBox(image: selectedImage!),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          selectedImage = null;
                        });
                      },
                      icon: const Icon(Icons.cancel))
                ],
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.orange.shade600),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                      onPressed: () => getOrResetImage(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedImage == null
                                ? '  Get a picture'
                                : 'Replace',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          const FaIcon(
                            FontAwesomeIcons.camera,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: selectedImage == null
                              ? WidgetStatePropertyAll(Colors.blue.shade200)
                              : const WidgetStatePropertyAll(Colors.blue),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                      onPressed: () => onUncoverClicked(context),
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
                                  text: 'Not found :(',
                                  type: SnackBarType.error),
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
                          switch (state) {
                            case HistoryInitial():
                              return const UncoverBtn();
                            case HistoryFailed():
                              return const UncoverBtn();
                            case HistorySuccess():
                              return const UncoverBtn();
                            case HistoryNotFound():
                              return const UncoverBtn();
                            default:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Uncover',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(width: 10),
        FaIcon(
          FontAwesomeIcons.wandMagicSparkles,
          color: Colors.white,
        ),
      ],
    );
  }
}
