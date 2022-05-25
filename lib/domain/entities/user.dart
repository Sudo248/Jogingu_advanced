import 'dart:ui';

import 'package:equatable/equatable.dart';
import './gender.dart';

class User extends Equatable {
  final String? userId;
  final int key;
  final String? firstName;
  final String? lastName;
  final String? city;
  final String? country;
  final String? primarySport;
  final Gender gender;
  final DateTime? birthday;
  final double? height;
  final double? weight;
  final String? avatarUrl;

   const User(
      {this.userId,
	  required this.key,
      this.firstName,
      this.lastName,
      this.city,
      this.country,
      this.primarySport,
      this.gender = Gender.Male,
      this.birthday,
      this.height,
      this.weight,
      this.avatarUrl});

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
        height,
        weight,
        avatarUrl,
      ];
}
