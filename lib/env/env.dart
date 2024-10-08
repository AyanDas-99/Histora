import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'GEMINI_API_KEY')
  static final String geminiKey = _Env.geminiKey;
}
