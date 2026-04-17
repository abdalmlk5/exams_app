import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool isLoading;
  final T? data;
  final String? errorMessage;

  const BaseState({
    this.isLoading = false,
    this.data,
    this.errorMessage,
  });

  BaseState<T> copyWith({
    bool? isLoading,
    T? data,
    bool clearData = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return BaseState<T>(
      isLoading: isLoading ?? this.isLoading,
      data: clearData ? null : (data ?? this.data),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}
