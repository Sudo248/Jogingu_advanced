import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/base/di.dart';
import 'package:jogingu_advanced/app/service/image_service.dart';
import 'package:jogingu_advanced/app/utils/util.dart';
import 'package:jogingu_advanced/domain/common/logger.dart';
import 'package:jogingu_advanced/domain/entities/gender.dart';
import 'package:jogingu_advanced/domain/repositories/user_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/entities/user.dart';

class ProfileBloc extends BlocBase {
  final UserRepository repo;
  final imageService = Di.get<ImageService>();
  User? user;
  bool onChange = false;
  DateTime? birthday;
  Gender? gender;
  File? avatar;
  bool prepareToRun = false;

  final GlobalKey<FormState> heightFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> weightFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> birthdayFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> genderFormKey = GlobalKey<FormState>();

  BehaviorSubject<String?> avatarUrl = BehaviorSubject.seeded("");

  late final TextEditingController firstNameCtrl,
      lastNameCtrl,
      cityCtrl,
      countryCtrl,
      primarySportCtrl,
      birthdayCtrl,
      heightCtrl,
      weightCtrl,
      genderCtrl;

  ProfileBloc({required this.repo}) {
    firstNameCtrl = TextEditingController();
    lastNameCtrl = TextEditingController();
    cityCtrl = TextEditingController();
    countryCtrl = TextEditingController();
    primarySportCtrl = TextEditingController();
    birthdayCtrl = TextEditingController();
    heightCtrl = TextEditingController();
    weightCtrl = TextEditingController();
    genderCtrl = TextEditingController();
  }

  @override
  void onDispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    cityCtrl.dispose();
    countryCtrl.dispose();
    primarySportCtrl.dispose();
    birthdayCtrl.dispose();
    heightCtrl.dispose();
    weightCtrl.dispose();
    genderCtrl.dispose();
  }

  @override
  void onInit() {
    updateUi();
  }

  Future<void> updateUi() async {
    final userStatus = await repo.getMe();
    if (userStatus.isSuccess) {
      user = userStatus.data!;
      firstNameCtrl.text = user?.firstName ?? "";
      lastNameCtrl.text = user?.lastName ?? "";
      cityCtrl.text = user?.city ?? "";
      countryCtrl.text = user?.country ?? "";
      primarySportCtrl.text = user?.primarySport ?? "";
      birthdayCtrl.text = simpleFormatTime(user?.birthday);
      heightCtrl.text = user?.height?.toStringAsFixed(1) ?? "";
      weightCtrl.text = user?.weight?.toStringAsFixed(1) ?? "";
      genderCtrl.text = user?.gender.name ?? "";
      birthday = user?.birthday;
      gender = user?.gender;
      if (user?.avatarUrl != null && user!.avatarUrl!.endsWith(".png")) {
        avatar = File(user!.avatarUrl!);
      }
    }
    onListenChange();
  }

  void onListenChange() async {
    firstNameCtrl.addListener(() {
      onChange = true;
    });
    lastNameCtrl.addListener(() {
      onChange = true;
    });
    cityCtrl.addListener(() {
      onChange = true;
    });
    countryCtrl.addListener(() {
      onChange = true;
    });
    primarySportCtrl.addListener(() {
      onChange = true;
    });
    birthdayCtrl.addListener(() {
      onChange = true;
    });
    heightCtrl.addListener(() {
      onChange = true;
    });
    weightCtrl.addListener(() {
      onChange = true;
    });
    genderCtrl.addListener(() {
      onChange = true;
    });
  }

  Future<void> pickImage(int selected) async {
    if (selected == 1) {
      await imageService.pickImage(ImageSource.gallery,
          storeImage: (image) async {
        final String path = (await getApplicationDocumentsDirectory()).path;
        avatar = await image.copy("$path/avatar.png");
        avatarUrl.sink.add(avatar?.path);
        onChange = true;
      });
    } else {
      await imageService.pickImage(ImageSource.camera,
          storeImage: (image) async {
        final String path = (await getApplicationDocumentsDirectory()).path;
        avatar = await image.copy("$path/avatar.png");
        avatarUrl.sink.add(avatar?.path);
        onChange = true;
      });
    }
  }

  void updateBirthday(DateTime? time) async {
    birthday = time;
    birthdayCtrl.text = simpleFormatTime(birthday);
  }

  void onChangeGender(String gender) async {
    this.gender = Gender.values.byName(gender);
  }

  void onSaveUser() async {
    if (birthdayFormKey.currentState!.validate() &&
        heightFormKey.currentState!.validate() &&
        weightFormKey.currentState!.validate() &&
        genderFormKey.currentState!.validate()) {
      final isUpdate = user != null;
      user = User(
        key: -1,
        firstName: firstNameCtrl.text,
        lastName: lastNameCtrl.text,
        city: cityCtrl.text,
        country: countryCtrl.text,
        primarySport: primarySportCtrl.text,
        gender: gender ?? Gender.Female,
        birthday: birthday,
        height: double.parse(heightCtrl.text),
        weight: double.parse(weightCtrl.text),
        avatarUrl: avatar?.path,
      );
      if (isUpdate) {
        await repo.update(0, user!);
      } else {
        await repo.add(user!);
      }
      navigator.back<bool>(true);
    }
  }

  String? birthdayValidator(String? value) {
    return value?.isEmpty ?? false ? "Not empty" : null;
  }

  String? heightValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Not empty";
    }
    final _value = double.parse(value);
    if (_value < 50.0) {
      return "Not less than 50cm";
    }
    if (_value > 300.0) {
      return "Not more than 300cm";
    }
    return null;
  }

  String? weightValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Not empty";
    }
    final _value = double.parse(value);
    if (_value < 10.0) {
      return "Not less than 10kg";
    }
    if (_value > 500.0) {
      return "Not more than 500kg";
    }
    return null;
  }

  String? genderValidator(String? value) {
    if (value == null || value == "") {
      return "Not empty";
    }
    return null;
  }
}
