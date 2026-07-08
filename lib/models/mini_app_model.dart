import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum MiniAppStatus { notAdded, added, premium, comingSoon }

class MiniAppModel {
  final String id;
  final String name;
  final String description;
  final String shortDescription;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String category;
  final MiniAppStatus status;
  final double rating;
  final int usageCount;
  final List<String> features;
  final List<String> permissions;
  final String route;
  
  // PDF gereksinimleri (Ana ekranda aktif uygulama kartı)
  final String? dailySummary;
  final String? quickActionText;
  final String? quickActionRoute;
  
  // Ortak Dashboard (Günlük Özet) kartları için
  final String? summaryValue;
  final String? summaryTitle;
  final String? summarySubtitle;

  const MiniAppModel({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.category,
    required this.status,
    required this.rating,
    required this.usageCount,
    required this.features,
    required this.permissions,
    required this.route,
    this.dailySummary,
    this.quickActionText,
    this.quickActionRoute,
    this.summaryValue,
    this.summaryTitle,
    this.summarySubtitle,
  });

  MiniAppModel copyWith({MiniAppStatus? status}) {
    return MiniAppModel(
      id: id,
      name: name,
      description: description,
      shortDescription: shortDescription,
      icon: icon,
      iconColor: iconColor,
      iconBgColor: iconBgColor,
      category: category,
      status: status ?? this.status,
      rating: rating,
      usageCount: usageCount,
      features: features,
      permissions: permissions,
      route: route,
      dailySummary: dailySummary,
      quickActionText: quickActionText,
      quickActionRoute: quickActionRoute,
      summaryValue: summaryValue,
      summaryTitle: summaryTitle,
      summarySubtitle: summarySubtitle,
    );
  }

  bool get isAdded => status == MiniAppStatus.added;
  bool get isPremium => status == MiniAppStatus.premium;
  bool get isComingSoon => status == MiniAppStatus.comingSoon;
}

// All available mini apps
final List<MiniAppModel> allMiniApps = [
  MiniAppModel(
    id: 'vardiya',
    name: 'Vardiya Takip',
    description:
        'Personel giriş-çıkışlarını kolayca takip edin. Geç kalma kontrolü, günlük ve aylık raporlar ile ekip bazlı takip yapın.',
    shortDescription: 'Personel giriş-çıkışlarını takip et.',
    icon: Icons.schedule_rounded,
    iconColor: AppColors.categoryPersonel,
    iconBgColor: AppColors.categoryPersonel.withOpacity(0.12),
    category: 'Personel',
    status: MiniAppStatus.notAdded,
    rating: 4.8,
    usageCount: 1240,
    features: [
      'Personel giriş-çıkış takibi',
      'Geç kalma kontrolü',
      'Günlük ve aylık rapor',
      'Ekip bazlı takip',
      'Bildirim desteği',
    ],
    permissions: [
      'Kendi vardiyasını görüntüleme',
      'Tüm ekip vardiyalarını görüntüleme',
      'Vardiya düzenleme',
      'Rapor indirme',
      'Bildirim gönderme',
    ],
    route: '/mini-apps/vardiya',
    dailySummary: 'Bugün 12 personel vardiyada.',
    quickActionText: 'Vardiya Ekle',
    quickActionRoute: '/mini-apps/vardiya/add',
    summaryValue: '12',
    summaryTitle: 'Aktif Vardiya',
    summarySubtitle: 'Bugün 12 personel',
  ),
  MiniAppModel(
    id: 'gelir_gider',
    name: 'Gelir-Gider Takibi',
    description: 'İşletmenizin günlük, haftalık ve aylık finans hareketlerini, kasa durumunu ve nakit akışını detaylı grafiklerle takip edin.',
    shortDescription: 'İşletmenizin finans hareketlerini takip edin.',
    icon: Icons.account_balance_rounded,
    iconColor: AppColors.categoryFinans,
    iconBgColor: AppColors.categoryFinans.withOpacity(0.12),
    category: 'Finans',
    status: MiniAppStatus.notAdded,
    rating: 4.8,
    usageCount: 1540,
    features: [
      'Gelir ve gider ekleme',
      'Kategori yönetimi',
      'Kasa hareketleri takibi',
      'Günlük, haftalık, aylık raporlar',
      'Grafiksel nakit akışı',
      'Excel/PDF dışa aktarma'
    ],
    permissions: [
      'Finans kayıtlarını görüntüleme',
      'Kayıt ekleme ve düzenleme',
      'Rapor alma',
    ],
    route: '/mini-apps/gelir-gider',
    dailySummary: 'Bugün 3 yeni işlem eklendi.',
    quickActionText: 'Gelir/Gider Ekle',
    quickActionRoute: '/mini-apps/gelir-gider/add',
    summaryValue: '₺24K',
    summaryTitle: 'Nakit Akışı',
    summarySubtitle: 'Bugünkü net gelir',
  ),
  MiniAppModel(
    id: 'stok',
    name: 'Stok Takibi',
    description: 'Ürünlerinizi barkodlu sistemle yönetin, depo stok giriş/çıkışlarını takip edin. Kritik stok uyarılarıyla ürünleriniz hiç tükenmesin.',
    shortDescription: 'Stok giriş çıkışını ve depoları yönetin.',
    icon: Icons.inventory_2_rounded,
    iconColor: AppColors.categoryOperasyon,
    iconBgColor: AppColors.categoryOperasyon.withOpacity(0.12),
    category: 'Operasyon',
    status: MiniAppStatus.notAdded,
    rating: 4.6,
    usageCount: 2100,
    features: [
      'Ürün ekleme',
      'Kategori sistemi',
      'Barkod desteği',
      'Stok giriş / çıkış',
      'Kritik stok uyarısı',
      'Depo yönetimi',
      'Stok raporu'
    ],
    permissions: [
      'Ürün listesini görüntüleme',
      'Stok ekleme ve azaltma',
      'Stok raporlarını görüntüleme',
    ],
    route: '/mini-apps/stok',
    dailySummary: '2 ürün kritik stok seviyesinde!',
    quickActionText: 'Stok Girişi',
    quickActionRoute: '/mini-apps/stok/movement?type=in',
    summaryValue: '2',
    summaryTitle: 'Kritik Stok',
    summarySubtitle: 'Tükenmek üzere',
  ),
  MiniAppModel(
    id: 'crm',
    name: 'Müşteri Yönetimi',
    description: 'Müşterilerinizle olan görüşmeleri, teklifleri ve notları tek merkezden yönetin. Müşteri bazlı etiketler ile iletişiminizi güçlendirin.',
    shortDescription: 'Müşteri iletişimi ve detaylı CRM yönetimi.',
    icon: Icons.groups_rounded,
    iconColor: AppColors.categoryMusteri,
    iconBgColor: AppColors.categoryMusteri.withOpacity(0.12),
    category: 'Müşteri',
    status: MiniAppStatus.notAdded,
    rating: 4.8,
    usageCount: 3100,
    features: [
      'Müşteri / Firma ekleme',
      'Etiket Sistemi',
      'Görüşme ve Not ekleme',
      'Teklif Geçmişi',
      'WhatsApp ve E-posta kısayolları'
    ],
    permissions: [
      'Müşteri verilerine erişim',
      'Yeni not ve görüşme ekleme',
    ],
    route: '/mini-apps/crm',
    dailySummary: 'Bugün 2 yeni görüşme planlandı.',
    quickActionText: 'Yeni Müşteri Ekle',
    quickActionRoute: '/mini-apps/crm/add',
    summaryValue: '5',
    summaryTitle: 'Yeni Görüşme',
    summarySubtitle: 'Bugün planlanan',
  ),
  MiniAppModel(
    id: 'personel',
    name: 'Personel Yönetimi',
    description: 'Çalışan bilgilerini, görevlerini, departmanlarını ve evraklarını tek merkezden yönetin. Performans değerlendirmelerini kolayca yapın.',
    shortDescription: 'İnsan kaynakları ve personel yönetimi.',
    icon: Icons.badge_rounded,
    iconColor: Colors.deepPurple,
    iconBgColor: Colors.deepPurple.withOpacity(0.12),
    category: 'Operasyon',
    status: MiniAppStatus.notAdded,
    rating: 4.5,
    usageCount: 1800,
    features: [
      'Personel ve departman ekleme',
      'İletişim ve maaş bilgileri',
      'Evrak yükleme',
      'Performans notu',
      'İşe giriş/çıkış takibi'
    ],
    permissions: [
      'Personel verilerine erişim',
      'Evrak yükleme',
    ],
    route: '/mini-apps/personel',
    dailySummary: 'Bugün 1 personelin doğum günü.',
    quickActionText: 'Personel Ekle',
    quickActionRoute: '/mini-apps/personel/add',
    summaryValue: '1',
    summaryTitle: 'Doğum Günü',
    summarySubtitle: 'Kutlamayı unutma',
  ),
  MiniAppModel(
    id: 'izin',
    name: 'İzin Yönetimi',
    description: 'Personellerinizin izin taleplerini, onay süreçlerini ve kalan izin günlerini takip edin.',
    shortDescription: 'İzin onay ve takvim süreçleri.',
    icon: Icons.event_busy_rounded,
    iconColor: AppColors.categoryOperasyon,
    iconBgColor: AppColors.categoryOperasyon.withOpacity(0.12),
    category: 'Operasyon',
    status: MiniAppStatus.notAdded,
    rating: 4.8,
    usageCount: 750,
    features: [
      'İzin talebi oluşturma',
      'Yönetici onayı',
      'İzin takvimi',
      'Kalan izin günü takibi',
      'İzin geçmişi',
    ],
    permissions: [
      'İzin verilerine erişim',
      'Personel verilerine erişim',
    ],
    route: '/mini-apps/izin',
    dailySummary: 'Onay bekleyen 2 izin talebi var.',
    quickActionText: 'Yeni Talep',
    quickActionRoute: '/mini-apps/izin/add',
    summaryValue: '2',
    summaryTitle: 'İzin Talebi',
    summarySubtitle: 'Onay bekleyen',
  ),
  MiniAppModel(
    id: 'siparis',
    name: 'Sipariş Takibi',
    description: 'Siparişlerin oluşturulmasından müşteriye teslim edilmesine kadar olan tüm süreci durum bazlı takip edin.',
    shortDescription: 'Tüm sipariş operasyonu.',
    icon: Icons.local_shipping_rounded,
    iconColor: AppColors.categoryOperasyon,
    iconBgColor: AppColors.categoryOperasyon.withOpacity(0.12),
    category: 'Operasyon',
    status: MiniAppStatus.notAdded,
    rating: 4.9,
    usageCount: 1200,
    features: [
      'Sipariş oluşturma',
      'Müşteri ve ürün seçimi',
      'Sipariş durumu takibi (Hazırlanıyor vb.)',
      'Kargo bilgisi',
      'Sipariş raporu',
    ],
    permissions: [
      'Sipariş verilerine erişim',
      'Müşteri verilerine erişim',
    ],
    route: '/mini-apps/siparis',
    dailySummary: 'Bugün teslim edilecek 2 siparişiniz var.',
    quickActionText: 'Sipariş Oluştur',
    quickActionRoute: '/mini-apps/siparis/add',
    summaryValue: '8',
    summaryTitle: 'Bekleyen Sipariş',
    summarySubtitle: '3 kargo bekliyor',
  ),
  MiniAppModel(
    id: 'alacak_borc',
    name: 'Alacak & Borç Takibi',
    description: 'İşletmenizin alacaklarını, borçlarını ve tahsilat süreçlerini vade tarihleriyle birlikte takip edin. Geciken ödemeler için uyarılar alın.',
    shortDescription: 'Cari bazlı alacak ve borç yönetimi.',
    icon: Icons.account_balance_wallet_rounded,
    iconColor: AppColors.categoryFinans,
    iconBgColor: AppColors.categoryFinans.withOpacity(0.12),
    category: 'Finans',
    status: MiniAppStatus.notAdded,
    rating: 4.7,
    usageCount: 980,
    features: [
      'Cari oluşturma',
      'Alacak / Borç ekleme',
      'Vade tarihi takibi',
      'Geciken ödemeler',
      'Raporlar',
    ],
    permissions: [
      'Cari verilerine erişim',
      'Finansal işlemleri yönetme',
    ],
    route: '/mini-apps/alacak-borc',
    dailySummary: 'Vadesi geçmiş 1 ödeme var.',
    quickActionText: 'Tahsilat Ekle',
    quickActionRoute: '/mini-apps/alacak-borc/add-transaction?type=alacak',
    summaryValue: '3',
    summaryTitle: 'Geciken Ödeme',
    summarySubtitle: 'Toplam 12.500₺',
  ),
  MiniAppModel(
    id: 'rezervasyon',
    name: 'Rezervasyon',
    description:
        'Randevu ve rezervasyonlarınızı takvimden yönetin. Müşteri bilgileri, hizmet türleri ve ekip atamaları tek yerden.',
    shortDescription: 'Randevu ve rezervasyonlarını takvimden yönet.',
    icon: Icons.calendar_month_rounded,
    iconColor: AppColors.categoryMusteri,
    iconBgColor: AppColors.categoryMusteri.withOpacity(0.12),
    category: 'Müşteri',
    status: MiniAppStatus.notAdded,
    rating: 4.9,
    usageCount: 1560,
    features: [
      'Takvim görünümü',
      'Müşteri bilgi yönetimi',
      'Hizmet türü tanımlama',
      'Ekip üyesi atama',
      'Hatırlatma bildirimleri',
    ],
    permissions: [
      'Rezervasyonları görüntüleme',
      'Rezervasyon ekleme',
      'Rezervasyon düzenleme',
      'Rezervasyon iptali',
      'Takvim yönetimi',
    ],
    route: '/mini-apps/rezervasyon',
    dailySummary: 'Bugün 7 randevunuz var.',
    quickActionText: 'Randevu Ekle',
    quickActionRoute: '/mini-apps/rezervasyon/add',
    summaryValue: '7',
    summaryTitle: 'Rezervasyon',
    summarySubtitle: 'Bugünkü randevular',
  ),
  MiniAppModel(
    id: 'gorev',
    name: 'Görev Yönetimi',
    description: 'Ekip içindeki işlerin oluşturulması, atanması ve detaylı takip edilmesi.',
    shortDescription: 'Ekip içi görev ve iş takibi.',
    icon: Icons.task_alt_rounded,
    iconColor: AppColors.categoryOperasyon,
    iconBgColor: AppColors.categoryOperasyon.withOpacity(0.12),
    category: 'Operasyon',
    status: MiniAppStatus.notAdded,
    rating: 4.8,
    usageCount: 1120,
    features: [
      'Görev oluşturma ve atama',
      'Alt görevler',
      'Son teslim tarihi ve Öncelik',
      'Dosya ekleme ve yorum sistemi',
      'Kanban ve liste görünümü',
    ],
    permissions: [
      'Görev oluşturma',
      'Görev atama',
      'Görev durumunu değiştirme',
      'Görev silme',
      'Tüm ekip görevlerini görme',
    ],
    route: '/mini-apps/gorev',
    dailySummary: 'Bugün teslim edilecek 3 görev var.',
    quickActionText: 'Görev Ekle',
    quickActionRoute: '/mini-apps/gorev/add',
    summaryValue: '4',
    summaryTitle: 'Açık Görev',
    summarySubtitle: '2 tanesi acil',
  ),
];
