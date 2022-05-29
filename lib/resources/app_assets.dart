import 'package:flutter/material.dart';

abstract class AppAssets {
  static const String _imagePath = "assets/images/";
  static const String _iconPath = "assets/icons/";

  //! Icon from assets
  // ignore: constant_identifier_names
  static const String ic_home = _iconPath + "ic_home.svg";
  // ignore: constant_identifier_names
  static const String ic_clock = _iconPath + "ic_clock.svg";
  // ignore: constant_identifier_names
  static const String ic_engergy = _iconPath + "ic_engergy.svg";
  // ignore: constant_identifier_names
  static const String ic_profile = _iconPath + "ic_profile.svg";
  // ignore: constant_identifier_names
  static const String ic_speed = _iconPath + "ic_speed.svg";
  // ignore: constant_identifier_names
  static const String ic_target = _iconPath + "ic_target.svg";
  // ignore: constant_identifier_names
  static const String ic_statistic = _iconPath + "ic_statistic.svg";

  //! Icon from DataIcon
  // ignore: constant_identifier_names
  static const Icon ic_pLay = Icon(Icons.play_arrow);
  // ignore: constant_identifier_names
  static const Icon ic_pause = Icon(Icons.pause);
  // ignore: constant_identifier_names
  static const Icon ic_more = Icon(Icons.more_vert);

  //! Image from assets
  static const String avatar = _imagePath + "avatar.jpg";
  // ignore: constant_identifier_names
  static const String logo_rouned = _imagePath + "logo_rouned.png";

  static const String logo = _imagePath + "logo.png";

  // ignore: constant_identifier_names
  static const String logo_splash = _imagePath + "logo_splash.gif";

  static const String cup_coffee = _imagePath + "cup_coffee.png";
}
