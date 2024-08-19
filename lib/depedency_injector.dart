import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:histora/core/route/app_router.dart';
import 'package:histora/state/auth/backend/authenticator.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';
import 'package:histora/state/gps/respository/gps_repository.dart';
import 'package:histora/state/structure/repository/structure_repository.dart';

final sl = GetIt.instance;

void init() {
  sl.registerFactory(() => AuthBloc(sl()));

  sl.registerLazySingleton(() => Authenticator(auth: sl(), googleSignIn: sl()));

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn(scopes: ['email']));

  sl.registerLazySingleton(() => AppRouter());

  sl.registerLazySingleton(() => GeolocatorAndroid());
  sl.registerLazySingleton<GpsRepository>(
      () => GpsRepositoryImpl(geolocatorAndroid: sl()));

  sl.registerLazySingleton<StructureRepository>(
      () => StructureRepositoryImpl(storage: sl(), firestore: sl()));

  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
