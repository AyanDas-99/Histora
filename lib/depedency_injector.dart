import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:histora/core/route/app_router.dart';
import 'package:histora/state/AI/repository/ai_repository.dart';
import 'package:histora/state/auth/backend/authenticator.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';
import 'package:histora/state/gps/respository/gps_repository.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';
import 'package:histora/state/structure/repository/structure_repository.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void init() {
  //! Blocs
  // Auth
  sl.registerFactory(() => AuthBloc(sl()));
  // History - Main Feature
  sl.registerFactory(() => HistoryBloc(
      gpsRepository: sl(), structureRepository: sl(), aiRepository: sl()));

  //! Repositories
  // Auth
  sl.registerLazySingleton(() => Authenticator(auth: sl(), googleSignIn: sl()));
  // Router
  sl.registerLazySingleton(() => AppRouter());
  // GpsRepository
  sl.registerLazySingleton<GpsRepository>(
      () => GpsRepositoryImpl(geolocatorAndroid: sl()));
  // Structure
  sl.registerLazySingleton<StructureRepository>(() => StructureRepositoryImpl(
      storage: sl(), firestore: sl(), httpClient: sl()));
  // AI
  sl.registerLazySingleton<AiRepository>(() => AiRepositoryImpl());

  //!External
  // Firebase
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  // Google Sign in
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn(scopes: ['email']));
  // GPS Location
  sl.registerLazySingleton(() => GeolocatorAndroid());
  // Http
  sl.registerLazySingleton<http.Client>(() => http.Client());
}
