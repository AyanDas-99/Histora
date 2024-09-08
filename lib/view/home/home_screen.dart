import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:histora/core/utils/pick_images.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';
import 'package:histora/view/history/history_screen.dart';
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
              const Text('Get image from'),
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
            onPressed: () => getOrResetImage(context),


            // onPressed: () {
            //   Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => HistoryScreen(
            //       structure: Structure(
            //         id: 'id',
            //         title: "The Obelisk of Marina Park",
            //         description:
            //             "The Obelisk of Marina Park, a towering monument, stands tall as a symbol of maritime heritage. It’s a beacon of history, inspiring visitors to reflect on the ocean’s tales and mysteries.",
            //         images: const [
            //           "https://firebasestorage.googleapis.com/v0/b/histora-mobile.appspot.com/o/assets%2FThe%20Obelisk%20of%20Marina%20Parke8d34100-3ecd-488f-8c63-f24985f6b284%2Fbe225cde-7ae0-4446-9bed-f2dc80ea5450?alt=media&token=df5862f1-7226-4e8c-9037-04119ae2a1ea",
            //           "https://firebasestorage.googleapis.com/v0/b/histora-mobile.appspot.com/o/assets%2FThe%20Obelisk%20of%20Marina%20Parke8d34100-3ecd-488f-8c63-f24985f6b284%2Fb9e59dc1-e1bc-4266-9675-75d84376f74f?alt=media&token=d561ae3b-9d2a-4d2d-9b7e-2b94f8a74844",
            //           "https://firebasestorage.googleapis.com/v0/b/histora-mobile.appspot.com/o/assets%2FThe%20Obelisk%20of%20Marina%20Parke8d34100-3ecd-488f-8c63-f24985f6b284%2Fbdf4920b-685a-46bc-b184-cc3fec6df529?alt=media&token=d6d3bc00-0875-4b64-89e1-eaae883047f0",
            //         ],
            //         history: History(
            //             history:
            //                 "<p>Rising proudly in Marina Park, this obelisk is a tribute to the maritime history of the region. Its towering presence has inspired countless tales of the sea and stories of exploration.</p> <p>Some say the obelisk was erected to honor the brave souls who ventured into the unknown waters, while others believe it marks a significant navigational point used by ancient mariners.</p> <p>Over the years, the obelisk has become a favorite spot for visitors to ponder the mysteries of the ocean and the legacy of those who sailed before us. Its reflection in the surrounding water is said to resemble a lighthouse guiding lost ships home.</p> <p>Whether a memorial or a marker, the Obelisk of Marina Park continues to stand as a testament to the enduring spirit of adventure and the timeless connection between land and sea.</p>"),
            //         coordinate: (11.6698641, 92.7474356),
            //       ),
            //     ),
            //   ));
            // },
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(selectedImage == null
                    ? '  Get a picture'
                    : 'Replace picture'),
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
                  if (state is HistoryFailed) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if (state is HistoryNotFound) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Not found :(')));
                  }
                  if (state is HistorySuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Found structure ${state.structure.title}')));
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
