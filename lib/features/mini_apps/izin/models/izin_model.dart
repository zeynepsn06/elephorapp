import 'package:flutter/material.dart';

enum IzinDurumu { bekliyor, onaylandi, reddedildi }

class IzinTalebi {
  final String id;
  final String personelId;
  final String personelName;
  final String personelImage; // Varsa avatar, yoksa baş harfi
  final String izinTuru; // Yıllık İzin, Sağlık, Mazeret vb.
  final DateTime baslangicTarihi;
  final DateTime bitisTarihi;
  final String aciklama;
  final IzinDurumu durum;
  final String? redNedeni;
  final DateTime talepTarihi;

  const IzinTalebi({
    required this.id,
    required this.personelId,
    required this.personelName,
    this.personelImage = '',
    required this.izinTuru,
    required this.baslangicTarihi,
    required this.bitisTarihi,
    this.aciklama = '',
    this.durum = IzinDurumu.bekliyor,
    this.redNedeni,
    required this.talepTarihi,
  });

  int get gunSayisi {
    return bitisTarihi.difference(baslangicTarihi).inDays + 1;
  }
}

class KalanIzinRapor {
  final String personelId;
  final String personelName;
  final int yillikIzinHakki;
  final int kullanilanIzin;
  
  const KalanIzinRapor({
    required this.personelId,
    required this.personelName,
    this.yillikIzinHakki = 14,
    this.kullanilanIzin = 0,
  });

  int get kalanIzin => yillikIzinHakki - kullanilanIzin;
}
