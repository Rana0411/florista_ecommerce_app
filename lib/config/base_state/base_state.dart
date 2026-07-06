import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool? isLoading;
  final T? data;
  final String? errorMessage;
  const BaseState({this.isLoading, this.data, this.errorMessage});

  BaseState<T> copyWith({
    bool? isLoading,
    String? errorMessage,
    T? data,
    bool clearData = false,
    bool clearError = false,
  }) {
    return BaseState<T>(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      data: clearData ? null : (data ?? this.data),
    );
  }

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}
