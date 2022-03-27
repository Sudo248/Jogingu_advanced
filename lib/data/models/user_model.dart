import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)
  late String? firstName;
  @HiveField(1)
  late String? lastName;
  @HiveField(2)
  late String? city;
  @HiveField(3)
  late String? country;
  @HiveField(4)
  late String? primarySport;
  @HiveField(5)
  late int genderIndex;
  @HiveField(6)
  late int? birthdayInMiliseconds;
  @HiveField(7)
  late int? age;
  @HiveField(8)
  late int? height;
  @HiveField(9)
  late int? weight;
  @HiveField(10)
  late String? avatarUrl;

	UserModel({
		this.firstName,
		this.lastName,
		this.city,
		this.country,
		this.primarySport,
		this.genderIndex = 0,
		this.birthdayInMiliseconds,
		this.age,
		this.height,
		this.weight,
		this.avatarUrl,
	});

}
