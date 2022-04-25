import 'package:hive/hive.dart';
import 'package:jogingu_advanced/domain/common/status.dart';

abstract class Repositoty<T> {
  Future<void> onInit();
  Future<void> onDispose();

  Stream<Status<List<T>>> getAll();
  Future<Status<T>> get(dynamic key);
  Future<Status> add(T data);
  Future<Status> delete(dynamic key);
  Future<Status> update(dynamic key, T data);
}
