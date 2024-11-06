import 'dart:async';
import '../../domain/usecases/firebase_auth_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc {
  final FirebaseAuthUseCase loginUseCase;

  final _eventController = StreamController<LoginEvent>();
  final _stateController = StreamController<LoginState>.broadcast();

  Stream<LoginState> get state => _stateController.stream;
  Sink<LoginEvent> get eventSink => _eventController.sink;

  bool isLoginSelected = true;

  LoginBloc({required this.loginUseCase}) {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(LoginEvent event) async {
    if (event is SubmitButtonPressed) {
      _stateController.add(LoginLoading());

      try {
        final user = await loginUseCase.login(event.email, event.password);
        _stateController.add(LoginSuccess(user: user!));
      } catch (e) {
        _stateController.add(LoginFailure(error: e.toString()));
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
