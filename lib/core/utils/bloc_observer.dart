import 'package:bloc/bloc.dart';

import 'logger.dart';

class AppBlocObserver extends BlocObserver {
  /// [BlocObserver] which logs all bloc state changes, errors and events.
  const AppBlocObserver();

  @override
  void onTransition(
      Bloc<Object?, Object?> bloc,
      Transition<Object?, Object?> transition,
      ) {
    final buffer = StringBuffer()
      ..writeln('▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰')
      ..writeln('╏ Bloc: ${bloc.runtimeType} | ${transition.event.runtimeType}')
      ..writeln('╏ Current State: ${transition.currentState.runtimeType}')
      ..writeln('╏ New State: ${transition.nextState.runtimeType}')
      ..writeln('▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰');
    logger.info(buffer.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc<Object?, Object?> bloc, Object? event) {
    final buffer = StringBuffer()
      ..writeln('▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰')
      ..writeln('╏ Bloc: ${bloc.runtimeType} | ${event.runtimeType}')
      ..writeln('╏ State: ${bloc.state.runtimeType}')
      ..writeln('▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰');
    logger.info(buffer.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase<Object?> bloc, Object error, StackTrace stackTrace) {
    logger.error(
      'Bloc: ${bloc.runtimeType} | $error',
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
