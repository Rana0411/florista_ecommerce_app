import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/entity/login_entity.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/usecase/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<BaseState<LoginEntity>> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const BaseState());


  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final response = await _loginUseCase(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    emit(ResponseToStateMapper.handle(response));
  }


  void reset() => emit(const BaseState());
}
