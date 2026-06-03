import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:florista_ecommerce_app/features/change_password/data/models/change_password_request.dart';
import 'package:florista_ecommerce_app/features/change_password/data/models/change_password_response.dart';
import 'package:florista_ecommerce_app/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:florista_ecommerce_app/features/change_password/presentation/view_model/cubit/change_password_event.dart';
import 'package:injectable/injectable.dart';

part 'change_password_state.dart';

@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;
  ChangePasswordViewModel({required this.changePasswordUseCase})
    : super(ChangePasswordState());

  void doEvent(ChangePasswordEvent event) {
    _changePassword(passwords: event.passwords);
  }

  Future<void> _changePassword({
    required ChangePasswordRequest passwords,
  }) async {
    emit(
      state.copyWith(
        apiError: null,
        changePasswordState: state.changePasswordState.copyWith(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );

    final response = await changePasswordUseCase(passwords: passwords);
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        apiError: handler.errorMessage,
        changePasswordState: state.changePasswordState.copyWith(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }
}
