import 'package:hive_flutter/hive_flutter.dart';
import 'package:jogingu_advanced/data/extensions/user_extention.dart';
import 'package:jogingu_advanced/data/models/user_model.dart';
import 'package:jogingu_advanced/domain/common/failure.dart';
import 'package:jogingu_advanced/domain/entities/user.dart';
import 'package:jogingu_advanced/domain/common/status.dart';

import 'package:jogingu_advanced/domain/repositories/user_repository.dart';

import '../../domain/common/logger.dart';
import '../config/boxes.dart';

class UserRepositoryImpl implements UserRepository {
  Box<UserModel>? userBox;

  @override
  Future<Status> add(User data) async {
    try {
      userBox = await Boxes.I.userBox;
      await userBox?.add(data.toUserModel());
      userBox?.close();
      return Future.value(Success());
    } catch (e) {
      Logger.error(message: "add user $e");
      userBox?.close();
      return Future.value(Error(const DefaultError("Error when add user")));
    }
  }

  @override
  Future<Status> delete(key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Status<User>> get(key) async {
    try {
      userBox = await Boxes.I.userBox;
      final user = userBox?.get(key);
      if (user == null) {
        throw DefaultError("Not found user $key");
      }
      userBox?.close();
      return Future.value(Success(user.toUser()));
    } catch (e) {
      Logger.error(message: "get user $e");
      userBox?.close();
      if (e is Failure) {
        return Future.value(Error(e));
      }
      return Future.value(Error(const DefaultError("Error when get user")));
    }
  }

  @override
  Stream<Status<List<User>>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Status<String>> getAvatarUrl() async {
    try {
      userBox = await Boxes.I.userBox;
      final user = userBox?.getAt(0);
      if (user == null) {
        throw const DefaultError("Not found user");
      }
      userBox?.close();
      return Future.value(Success(user.avatarUrl));
    } catch (e) {
      Logger.error(message: "get avatar user $e");
      userBox?.close();
      if (e is Failure) {
        return Future.value(Error(e));
      }
      return Future.value(
          Error(const DefaultError("Error when get avatar user")));
    }
  }

  @override
  Future<Status<String>> getName() async {
    try {
      userBox = await Boxes.I.userBox;
      final user = userBox?.getAt(0);
      if (user == null) {
        throw const DefaultError("Not found user");
      }
      userBox?.close();

      return Future.value(Success("${user.firstName} ${user.lastName}"));
    } catch (e) {
      Logger.error(message: "get name user $e");
      userBox?.close();
      if (e is Failure) {
        return Future.value(Error(e));
      }
      return Future.value(
          Error(const DefaultError("Error when get name user")));
    }
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
  Future<Status> update(key, User data) async {
    try {
      userBox = await Boxes.I.userBox;
      await userBox?.put(key, data.toUserModel());

      userBox?.close();
      return Future.value(Success());
    } catch (e) {
      Logger.error(message: "update user $e");
      userBox?.close();
      if (e is Failure) {
        return Future.value(Error(e));
      }
      return Future.value(Error(const DefaultError("Error when update user")));
    }
  }

  @override
  Future<Status<User>> getMe() async {
    try {
      userBox = await Boxes.I.userBox;
      if (userBox?.length == 0) throw const DefaultError("Not found user");
      final user = userBox?.getAt(0);
      userBox?.close();
      return Future.value(Success(user!.toUser()));
    } catch (e) {
      Logger.error(message: "get me $e");
      userBox?.close();
      if (e is Failure) {
        return Future.value(Error(e));
      }
      return Future.value(Error(const DefaultError("Error when get me")));
    }
  }

  @override
  Future<Status<double>> getBMR() async {
    try {
      userBox = await Boxes.I.userBox;
      if (userBox?.length == 0) throw const DefaultError("Not found user");
      final user = userBox?.getAt(0)!;
      final height = user?.height ?? 0;
      final weight = user?.weight ?? 0;
      final birthdayYear =
          DateTime.fromMillisecondsSinceEpoch(user?.birthdayInMiliseconds ?? 0)
              .year;
      final age = DateTime.now().year - birthdayYear;
      double result = 0;
      // if gender == MALE
      if (user?.genderIndex == 1) {
        result = (13.397 * weight) + (4.799 * height) - (5.677 * age) + 88.362;
      } else {
        result = (9.247 * weight) + (3.098 * height) - (4.33 * age) + 447.593;
      }
      userBox?.close();
      return Future.value(Success(result));
    } catch (e) {
      Logger.error(message: "get BMR $e");
      userBox?.close();
      if (e is Failure) {
        return Future.value(Error(e));
      }
      return Future.value(Error(const DefaultError("Error when get BMR")));
    }
  }
}
