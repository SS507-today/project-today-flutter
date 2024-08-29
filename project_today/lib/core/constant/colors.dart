import 'package:flutter/material.dart';

class ColorSystem {
  const ColorSystem._();

  static const Color Red = Color(0xFFFA5D5D);
  static const Color Green = Color(0xFF00C27E);
  static const Color White = Color(0xFFFFFFFF);
}

class GreyColorSystem {
  const GreyColorSystem._();

  static const Color Grey = Color(0xFF2F2020);
  static const Color Grey90 = Color(0xFF443737);
  static const Color Grey80 = Color(0xFF584C4C);
  static const Color Grey70 = Color(0xFF6E6363);
  static const Color Grey60 = Color(0xFF827979);
  static const Color Grey50 = Color(0xFF968F8F);
  static const Color Grey40 = Color(0xFFACA6A6);
  static const Color Grey30 = Color(0xFFC1BDBD);
  static const Color Grey20 = Color(0xFFD5D2D2);
  static const Color Grey10 = Color(0xFFEBE9E9);
  static const Color Grey5 = Color(0xFFF4F4F4);
  static const Color Grey3 = Color(0xFFF8F8F8);
}

class PinkColorSystem {
  const PinkColorSystem._();

  static const Color Pink = Color(0xFFF56F90);
  static const Color Pink90 = Color(0xFFF67E9C);
  static const Color Pink80 = Color(0xFFF78CA6);
  static const Color Pink70 = Color(0xFFF89BB2);
  static const Color Pink60 = Color(0xFFF9A9BC);
  static const Color Pink50 = Color(0xFFF9B6C7);
  static const Color Pink40 = Color(0xFFFBC5D3);
  static const Color Pink30 = Color(0xFFFCD4DE);
  static const Color Pink20 = Color(0xFFFDE2E9);
  static const Color Pink10 = Color(0xFFFEF1F4);
  static const Color Pink05 = Color(0xFFFEF8F9);
}

class OrangeColorSystem {
  const OrangeColorSystem._();

  static const Color Orange = Color(0xFFFF9634);
  static const Color Orange90 = Color(0xFFFFA149);
  static const Color Orange80 = Color(0xFFFFAB5D);
  static const Color Orange70 = Color(0xFFFFB671);
  static const Color Orange60 = Color(0xFFFFC085);
  static const Color Orange50 = Color(0xFFFFCA99);
  static const Color Orange40 = Color(0xFFFFD5AE);
  static const Color Orange30 = Color(0xFFFFE0C3);
  static const Color Orange20 = Color(0xFFFFEAD6);
  static const Color Orange10 = Color(0xFFFFF5EB);
  static const Color Orange05 = Color(0xFFFFF9F5);
}

class GredientColorSystem {
  const GredientColorSystem._();

  static const Color BorderPink = Color(0xFFF19DB2);
  static const Color BgPink = Color(0xFFFFD8E1);
  static const Color BorderOrange = Color(0xFFF3BD8B);
  static const Color BgOrange = Color(0xFFFFECDA);
  static const Color FabPink = Color(0xFFF09FB3);
  static const Color FabOrange = Color(0xFFF9D0AB);

  static const LinearGradient BgGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment(0.5, -0.2),
    colors: [BgPink, BgOrange],
  );

  static const LinearGradient BorderGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment(0.5, -0.2),
    colors: [BorderPink, BorderOrange],
  );

  static const LinearGradient FabGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment(0.5, -0.2),
    colors: [FabPink, FabOrange],
  );
}
