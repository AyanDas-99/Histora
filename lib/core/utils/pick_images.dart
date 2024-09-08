import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage(bool fromCamera) async {
  final file = await ImagePicker().pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 40);
  return file;
}
