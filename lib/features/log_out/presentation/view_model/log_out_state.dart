part of 'log_out_cubit.dart';

class LogOutState extends Equatable {
  final BaseState<String> logOutState;
  LogOutState({BaseState<String>? logOutState})
    : logOutState =
          logOutState ?? BaseState<String>(isLoading: false, data: null);

  LogOutState copyWith({BaseState<String>? logOutState}) {
    return LogOutState(logOutState: logOutState ?? this.logOutState);
  }

  @override
  List<Object?> get props => [logOutState];
}
