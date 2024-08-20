import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage() async {
  final file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 40);
  return file;
}
