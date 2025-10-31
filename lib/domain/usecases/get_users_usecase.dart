import '../../data/repositories/user_repository.dart';
import '../entities/user_entity.dart';

class GetUsersUseCase {
  final UserRepository repository;
  GetUsersUseCase(this.repository);

  Future<List<UserEntity>> execute(int page) async {
    final users = await repository.fetchUsers(page);
    return users
        .map((u) => UserEntity(
      id: u.id,
      name: '${u.firstName} ${u.lastName}',
      email: u.email,
      avatar: u.avatar,
    ))
        .toList();
  }
}
