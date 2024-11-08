import 'dart:async';
import '../../domain/usecases/firebase_auth_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc {
  final FirebaseAuthUseCase authUseCase;

  final _eventController = StreamController<AuthEvent>();
  final _stateController = StreamController<AuthState>.broadcast();

  Stream<AuthState> get state => _stateController.stream;
  Sink<AuthEvent> get eventSink => _eventController.sink;

  bool isLoginSelected = true;

  AuthBloc({required this.authUseCase}) {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(AuthEvent event) async {
    if (event is SubmitButtonPressed) {
      _stateController.add(AuthLoading());

      try {
        final user = await authUseCase.login(event.email, event.password);
        _stateController.add(AuthSuccess(user: user!));
      } catch (e) {
        _stateController.add(AuthFailure(error: e.toString()));
      }
    } else if (event is ToggleTab) {
      isLoginSelected = event.isLoginSelected;
      _stateController.add(TabChangedState(isLoginSelected: isLoginSelected));
    }
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
