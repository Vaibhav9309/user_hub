import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_hub/core/error/exception.dart';
import 'package:user_hub/domain/entities/user_entity.dart';
import 'package:user_hub/domain/usecases/get_users_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;
  int page = 1;

  UserBloc(this.getUsersUseCase) : super(const UserState()) {
    on<FetchUsers>(_onFetchUsers);
    on<RefreshUsers>(_onRefreshUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    if (!state.hasMore || state.isLoading) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final users = await getUsersUseCase.execute(page);
      if (users.isEmpty) {
        emit(state.copyWith(hasMore: false, isLoading: false));
      } else {
        emit(state.copyWith(
          users: [...state.users, ...users],
          isLoading: false,
        ));
        page++;
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: _mapExceptionToMessage(e),
      ));
    }
  }

  Future<void> _onRefreshUsers(RefreshUsers event, Emitter<UserState> emit) async {
    page = 1;
    emit(const UserState(isLoading: true));

    try {
      final users = await getUsersUseCase.execute(page);
      emit(state.copyWith(users: users, isLoading: false, hasMore: true));
      page++;
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: _mapExceptionToMessage(e),
      ));
    }
  }

  void _onSearchUsers(SearchUsers event, Emitter<UserState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  String _mapExceptionToMessage(Object e) {
    if (e is NetworkException) return "No Internet connection. Please check your network and try again.";
    if (e is TimeoutException) return "Request timed out. Please try again.";
    if (e is ServerException) return "Server error occurred. Please try again later.";
    if (e is UnauthorizedException) return "You are not authorized to access this resource.";
    if (e is NotFoundException) return "The requested resource was not found.";
    if (e is BadRequestException) return "Invalid request. Please try again.";
    if (e is DataParsingException) return "Something went wrong while processing data.";
    if (e is HttpException) return "Unexpected server response.";
    return "Unexpected error occurred. Please try again.";
  }
}
