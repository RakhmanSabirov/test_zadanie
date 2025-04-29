import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => Dio());
}
