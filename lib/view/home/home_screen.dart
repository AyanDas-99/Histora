import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:histora/core/utils/pick_images.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';
import 'package:histora/view/home/widgets/image_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String get name => 'home';

  static String get path => '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedImage;

  getOrResetImage() async {
    final image = await pickImage();
    if (image != null) {
      setState(() {
        selectedImage = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Let's see what \nyou're looking at",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Center(child: ImageBox(image: selectedImage)),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    const WidgetStatePropertyAll(Colors.orangeAccent),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
            onPressed: getOrResetImage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(selectedImage == null ? '  Get a picture' : 'Replace picture'),
                const SizedBox(width: 10),
                const FaIcon(FontAwesomeIcons.camera),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (selectedImage != null)
            TextButton(
              style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(Colors.blue),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              onPressed: () {
                context
                    .read<HistoryBloc>()
                    .add(SearchPhoto(imageFromUser: selectedImage!));
              },
              child: BlocConsumer<HistoryBloc, HistoryState>(
                listener: (context, state) {
                  if(state is HistoryFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if(state is HistoryNotFound) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Not found :(')));
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
        ],
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
