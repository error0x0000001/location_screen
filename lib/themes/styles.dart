import 'package:flutter/material.dart';

abstract class Styles {

  static const lightColorScheme = ColorScheme (
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 97, 42, 198),
      surfaceTint: Color(4285027469),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4293647615),
      onPrimaryContainer: Color(4280487750),
      secondary: Color(4284701552),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4293582584),
      onSecondaryContainer: Color(4280227882),
      tertiary: Color(4286534237),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294957537),
      onTertiaryContainer: Color(4281471003),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294899711),
      onSurface: Color(4280097568),
      onSurfaceVariant: Color(4282991950),
      outline: Color(4286215551),
      outlineVariant: Color(4291544271),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281478965),
      inversePrimary: Color(4292066301),
      primaryFixed: Color(4293647615),
      onPrimaryFixed: Color(4280487750),
      primaryFixedDim: Color(4292066301),
      onPrimaryFixedVariant: Color(4283448436),
      secondaryFixed: Color(4293582584),
      onSecondaryFixed: Color(4280227882),
      secondaryFixedDim: Color(4291674843),
      onSecondaryFixedVariant: Color(4283122520),
      tertiaryFixed: Color(4294957537),
      onTertiaryFixed: Color(4281471003),
      tertiaryFixedDim: Color(4294031300),
      onTertiaryFixedVariant: Color(4284758854),
      surfaceDim: Color(4292794592),
      surfaceBright: Color(4294899711),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294504954),
      surfaceContainer: Color(4294110452),
      surfaceContainerHigh: Color(4293781230),
      surfaceContainerHighest: Color(4293386472),
      
    );

  static const darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 98, 57, 219),
      surfaceTint: Color(4291673599),
      onPrimary: Color(4281608030),
      primaryContainer: Color(4283121270),
      onPrimaryContainer: Color(4293385983),
      secondary: Color(4291673599),
      onSecondary: Color(4281608030),
      secondaryContainer: Color(4283121270),
      onSecondaryContainer: Color(4293451519),
      tertiary: Color(4293834954),
      onTertiary: Color(4282983731),
      tertiaryContainer: Color(4284693322),
      onTertiaryContainer: Color(4294957540),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279112725),
      onSurface: Color(4292797413),
      onSurfaceVariant: Color(4291413200),
      outline: Color(4287860633),
      outlineVariant: Color(4282926414),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inversePrimary: Color(4284700303),
      primaryFixed: Color(4293385983),
      onPrimaryFixed: Color(4280225864),
      primaryFixedDim: Color(4291673599),
      onPrimaryFixedVariant: Color(4283121270),
      secondaryFixed: Color(4293451519),
      onSecondaryFixed: Color(4280225864),
      secondaryFixedDim: Color(4291673599),
      onSecondaryFixedVariant: Color(4283121270),
      tertiaryFixed: Color(4294957540),
      onTertiaryFixed: Color(4281405726),
      tertiaryFixedDim: Color(4293834954),
      onTertiaryFixedVariant: Color(4284693322),
      surfaceDim: Color(4279112725),
      surfaceBright: Color(4281612859),
      surfaceContainerLowest: Color(4278783760),
      surfaceContainerLow: Color(4279704862),
      surfaceContainer: Color(4279968034),
      surfaceContainerHigh: Color(4280625964),
      surfaceContainerHighest: Color(4281349687),
    );

  static const TextStyle searchText = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle deliveryTimeLabel = TextStyle(
    color: Color(0XFFC2C2C2),
    fontWeight: FontWeight.w300,
  );

static const TextStyle deliveryTime = TextStyle(
    color: Colors.grey,
  );

}