import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel extends HiveObject{
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
  late double? height;
  @HiveField(8)
  late double? weight;
  @HiveField(9)
  late String? avatarUrl;

	UserModel({
		this.firstName,
		this.lastName,
		this.city,
		this.country,
		this.primarySport,
		this.genderIndex = 0,
		this.birthdayInMiliseconds,
		this.height,
		this.weight,
		this.avatarUrl,
	});

}
