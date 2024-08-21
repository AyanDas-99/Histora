import 'dart:typed_data';
import 'dart:developer' as dev;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:histora/core/error/exception.dart';
import 'package:histora/env/env.dart';
import 'package:histora/state/AI/ai_result.dart';

abstract class AiRepository {
  /// compare image and image set and return [AiResult]
  ///
  /// Throws [AiException] on error
  Future<AiResult> compareImageSets(
    UserImageBytes userImage,
    AssetImageBytes assetImage,
  );
}

class AiRepositoryImpl implements AiRepository {
  @override
  Future<AiResult> compareImageSets(
      UserImageBytes userImage, AssetImageBytes assetImage) async {
    try {
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
          responseMimeType: 'application/json',
        ),
      );

      final List<DataPart> assetDataFiles = [];

      for (Uint8List file in assetImage.images) {
        final DataPart data = DataPart(
          'image/jpeg',
          file,
        );
        assetDataFiles.add(data);
      }

      final content = Content.multi([
        DataPart('image/jpeg', userImage.image),
        ...assetDataFiles,
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
      dev.log(response.text ?? 'No response from AI');
      if (response.text == null) {
        throw AiException('No response from AI');
      }
      return AiResult.fromJson(response.text!);
    } catch (e) {
      throw AiException(e.toString());
    }
  }
}
