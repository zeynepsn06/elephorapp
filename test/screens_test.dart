import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:elephorapp/features/mini_apps/vardiya/vardiya_home_screen.dart';
import 'package:elephorapp/features/mini_apps/odeme/odeme_home_screen.dart';
import 'package:elephorapp/features/mini_apps/rezervasyon/rezervasyon_home_screen.dart';
import 'package:elephorapp/features/mini_apps/stok/stok_home_screen.dart';
import 'package:elephorapp/features/mini_apps/siparis/siparis_home_screen.dart';
import 'package:elephorapp/features/mini_apps/gelir_gider/gelir_gider_home_screen.dart';
import 'package:elephorapp/features/mini_apps/alacak_borc/alacak_borc_home_screen.dart';
import 'package:elephorapp/features/mini_apps/personel/personel_home_screen.dart';
import 'package:elephorapp/features/mini_apps/crm/crm_home_screen.dart';
import 'package:elephorapp/features/mini_apps/izin/izin_home_screen.dart';
import 'package:elephorapp/features/mini_apps/gorev/gorev_home_screen.dart';

void main() {
  testWidgets('Test screens', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: VardiyaHomeScreen()));
    await tester.pumpWidget(const MaterialApp(home: OdemeHomeScreen()));
    await tester.pumpWidget(const MaterialApp(home: RezervasyonHomeScreen()));
    await tester.pumpWidget(const MaterialApp(home: StokHomeScreen()));
    await tester.pumpWidget(const MaterialApp(home: SiparisHomeScreen()));
    await tester.pumpWidget(const MaterialApp(home: GelirGiderHomeScreen()));
    await tester.pumpWidget(const MaterialApp(home: AlacakBorcHomeScreen()));
    await tester.pumpWidget(const MaterialApp(home: PersonelHomeScreen()));
    await tester.pumpWidget(const MaterialApp(home: CrmHomeScreen()));
    await tester.pumpWidget(const MaterialApp(home: IzinHomeScreen()));
    await tester.pumpWidget(const MaterialApp(home: GorevHomeScreen()));
  });
}
