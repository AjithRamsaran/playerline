import 'package:bloc/bloc.dart';

class SimpleAppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    //log('${bloc.runtimeType} - Transition: $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    //log('${bloc.runtimeType} - Transition: $error');

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    //log('${bloc.runtimeType} - Transition: $transition');
  }
}