part of 'user_bloc.dart';

class UserState extends Equatable {
  final List<UserEntity> users;
  final bool hasMore;
  final bool isLoading;
  final String? error;
  final String searchQuery;

  const UserState({
    this.users = const [],
    this.hasMore = true,
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
  });

  UserState copyWith({
    List<UserEntity>? users,
    bool? hasMore,
    bool? isLoading,
    String? error,
    String? searchQuery,
  }) {
    return UserState(
      users: users ?? this.users,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [users, hasMore, isLoading, error, searchQuery];
}

