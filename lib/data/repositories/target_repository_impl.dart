import 'package:jogingu_advanced/data/shared_preference/target_pref.dart';
import 'package:jogingu_advanced/domain/entities/target.dart';
import 'package:jogingu_advanced/domain/common/status.dart';
import 'package:jogingu_advanced/domain/repositories/target_repository.dart';

import '../../domain/common/failure.dart';
import '../../domain/common/logger.dart';

class TargetRepositoryImpl implements TargetRepository {
  final TargetPref pref;

  TargetRepositoryImpl({required this.pref});

  @override
  Future<Status> add(Target data) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Status> delete(key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Stream<Status<List<Target>>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<void> onDispose() {
    // TODO: implement onDispose
    throw UnimplementedError();
  }

  @override
  Future<void> onInit() {
    // TODO: implement onInit
    throw UnimplementedError();
  }

  @override
  Future<Status> update(key, Target data) {
    try {
      pref.setTarget(data);
      return Future.value(Success());
    } catch (e) {
      Logger.error(message: "update target: $e");
      if (e is Failure) {
        return Future.value(Error(e));
      }
      return Future.value(
          Error(const DefaultError("Error when update target")));
    }
  }

  @override
  Future<Status<Target>> get(key) async {
    try {
      final target = await pref.getTarget();
      return Future.value(Success(target));
    } catch (e) {
      Logger.error(message: "update run: $e");
      if (e is Failure) {
        return Future.value(Error(e));
      }
      return Future.value(Error(const DefaultError("Error when get target")));
    }
  }
}
