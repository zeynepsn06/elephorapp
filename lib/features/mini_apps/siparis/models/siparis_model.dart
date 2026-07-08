import 'package:flutter/material.dart';

enum SiparisDurumu {
  yeniSiparis,
  hazirlaniyor,
  kargoda,
  teslimEdildi,
  iptalEdildi,
}

class SiparisUrun {
  final String urunAdi;
  final int adet;
  final double birimFiyat;

  const SiparisUrun({
    required this.urunAdi,
    required this.adet,
    required this.birimFiyat,
  });

  double get toplamFiyat => adet * birimFiyat;
}

class SiparisModel {
  final String id;
  final String siparisNo;
  final String musteriId;
  final String musteriAdi;
  final List<SiparisUrun> urunler;
  final DateTime tarih;
  final SiparisDurumu durum;
  final String? kargoTakipNo;
  final String? notlar;

  const SiparisModel({
    required this.id,
    required this.siparisNo,
    required this.musteriId,
    required this.musteriAdi,
    required this.urunler,
    required this.tarih,
    this.durum = SiparisDurumu.yeniSiparis,
    this.kargoTakipNo,
    this.notlar,
  });

  double get toplamTutar {
    return urunler.fold(0, (sum, urun) => sum + urun.toplamFiyat);
  }

  String get durumText {
    switch (durum) {
      case SiparisDurumu.yeniSiparis:
        return 'Yeni Sipariş';
      case SiparisDurumu.hazirlaniyor:
        return 'Hazırlanıyor';
      case SiparisDurumu.kargoda:
        return 'Kargoda';
      case SiparisDurumu.teslimEdildi:
        return 'Teslim Edildi';
      case SiparisDurumu.iptalEdildi:
        return 'İptal Edildi';
    }
  }

  Color get durumColor {
    switch (durum) {
      case SiparisDurumu.yeniSiparis:
        return Colors.blue;
      case SiparisDurumu.hazirlaniyor:
        return Colors.orange;
      case SiparisDurumu.kargoda:
        return Colors.purple;
      case SiparisDurumu.teslimEdildi:
        return Colors.green;
      case SiparisDurumu.iptalEdildi:
        return Colors.red;
    }
  }
}
