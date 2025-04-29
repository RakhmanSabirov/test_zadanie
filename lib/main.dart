import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'app_runner.dart';
import 'core/dependencies/dependency_injection.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/logger.dart';

void main() {
  setup();
  Bloc.observer = const AppBlocObserver();
  logger.runLogging(
        () {
      runZonedGuarded(
            () => AppRunner(),
        logger.logZoneError,
      );
    },
    const LogOptions(),
  );
  runApp(const MyApp());
}
