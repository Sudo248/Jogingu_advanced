import 'dart:ui';

import 'package:equatable/equatable.dart';
import './gender.dart';

class User extends Equatable {
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? city;
  final String? country;
  final String? primarySport;
  final Gender gender;
  final DateTime? birthday;
  final int? age;
  final int? height;
  final int? weight;
  final Image? avatar;

   const User(
      {this.userId,
      this.firstName,
      this.lastName,
      this.city,
      this.country,
      this.primarySport,
      this.gender = Gender.Male,
      this.birthday,
      this.age,
      this.height,
      this.weight,
      this.avatar});

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        city,
        country,
        primarySport,
        gender,
        birthday,
        age,
        height,
        weight,
        avatar,
      ];
}
