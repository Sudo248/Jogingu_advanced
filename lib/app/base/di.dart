import 'dart:async';

import 'package:get_it/get_it.dart';

abstract class DiInterface {

  final GetIt getIt = GetIt.instance;

  String _getKey(Type type, {String? instanceName}) {
    return instanceName == null
        ? type.toString()
        : type.toString() + instanceName;
  }

  bool isRegistered<T extends Object>({String? key}) {
    return getIt.isRegistered<T>(instanceName: key);
  }

  void lazyPut<T extends Object>(
    T Function() builder, {
    String? instanceName,
    FutureOr Function(T)? dispose,
  }) {
    String key = _getKey(T, instanceName: instanceName);
    if(!isRegistered<T>(key: key)){
      getIt.registerLazySingleton<T>(builder,
          instanceName: key, dispose: dispose);
    }
  }

  void lazyPutAsync<T extends Object>(
    Future<T> Function() builder, {
    String? instanceName,
    FutureOr Function(T)? dispose,
  }) {
    String key = _getKey(T, instanceName: instanceName);
    if(!isRegistered<T>(key: key)) {
      getIt.registerLazySingletonAsync<T>(builder,
          instanceName: key, dispose: dispose);
    }
  }

  void put<T extends Object>(T Function() builder, {String? instanceName}) {
    String key = _getKey(T, instanceName: instanceName);
    // print("put $T key: $key, isRegistered: ${isRegistered<T>(key: key)}");
    if (!isRegistered<T>(key: key)) {
      getIt.registerFactory<T>(builder, instanceName: key);
    }
  }

  void putAsync<T extends Object>(Future<T> Function() builder,
      {String? instanceName}) {
    String key = _getKey(T, instanceName: instanceName);
    if (!isRegistered<T>(key: key)) {
      getIt.registerFactoryAsync(builder, instanceName: key);
    }
  }

  T get<T extends Object>({String? instanceName}) {
    String key = _getKey(T, instanceName: instanceName);
    return getIt.get<T>(instanceName: key);
    // if(isRegistered<T>(instanceName: instanceName)){
    //
    // }else{
    //
    // }
  }

  Future<T> getAsync<T extends Object>({String? instanceName}) {
    String key = _getKey(T, instanceName: instanceName);
    return getIt.getAsync<T>(instanceName: key);
  }

  FutureOr delete<T extends Object>({
    String? instanceName,
    FutureOr Function(T)? disposingFunction,
  }) {
    String key = _getKey(T, instanceName: instanceName);
    return getIt.unregister<T>(
      instance: T,
      instanceName: key,
      disposingFunction: disposingFunction,
    );
  }

  Future<void> reset({bool dispose = true}) async {
    return getIt.reset(dispose: dispose);
  }

  FutureOr resetSingleton<T extends Object>({
    String? instanceName,
    FutureOr Function(T)? disposingFunction,
  }) {
    String key = _getKey(T, instanceName: instanceName);
    return getIt.resetLazySingleton(
      instance: T,
      instanceName: key,
      disposingFunction: disposingFunction,
    );
  }
}

class _DiImpl extends DiInterface{}

final Di = _DiImpl();
