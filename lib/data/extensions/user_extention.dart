import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jogingu_advanced/data/models/user_model.dart';
import 'package:jogingu_advanced/domain/entities/gender.dart';
import 'package:jogingu_advanced/domain/entities/user.dart';

extension UserModelToUser on UserModel {
  User toUser() {
    return User(
      userId: key.toString(),
      key: key,
      firstName: firstName,
      lastName: lastName,
      city: city,
      country: country,
      primarySport: primarySport,
      gender: Gender.values[genderIndex],
      birthday: DateTime.fromMillisecondsSinceEpoch(birthdayInMiliseconds ?? 0),
      height: height,
      weight: weight,
      avatarUrl: avatarUrl,
    );
  }
}

extension UserToUserModel on User {
  UserModel toUserModel() {
    return UserModel(
      firstName: firstName,
      lastName: lastName,
      city: city,
      country: country,
      primarySport: primarySport,
      genderIndex: Gender.values.indexOf(gender),
      birthdayInMiliseconds: birthday?.millisecondsSinceEpoch,
      height: height,
      weight: weight,
      avatarUrl: avatarUrl,
    );
  }
}
