import 'package:jogingu_advanced/domain/common/status.dart';
import 'package:jogingu_advanced/domain/repositories/repository.dart';

import '../entities/user.dart';

abstract class UserRepository extends Repositoty<User> {
  Future<Status<String>> getName();
  Future<Status<String>> getAvatarUrl();
  Future<Status<User>> getMe();
  Future<Status<double>> getBMR();
}
