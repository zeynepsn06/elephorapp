import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Arka plan sistemleri ───────────────────────────────────────────
  static const Color bgPage    = Color(0xFFF7F7F8); // Ana arka plan (sayfa zemini)
  static const Color bgCard    = Color(0xFFFFFFFF); // Kart zeminleri (beyaz yüzeyler)
  static const Color bgSurface = Color(0xFFEFEFF1); // Bölüm ayrımları / soft container

  // ── Metin ve kontrast ──────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFF111111); // Ana başlıklar (en güçlü siyah)
  static const Color textSecondary = Color(0xFF2B2B2B); // Normal metin (body text)
  static const Color textHint      = Color(0xFF6B6B6B); // Açıklama / secondary text
  static const Color textDisabled  = Color(0xFFA1A1A1); // Disabled / pasif metin

  // ── Çerçeve & stroke (çizgiler) ────────────────────────────────────
  static const Color border      = Color(0xFFE6E6E6); // Kart border
  static const Color borderInput = Color(0xFFD9D9D9); // Input border
  static const Color borderLight = Color(0xFFF0F0F0); // Soft divider çizgiler

  // ── UI aksiyon renkleri ────────────────────────────────────────────
  static const Color primaryButton     = Color(0xFF111111); // Primary button (siyah buton)
  static const Color buttonText        = Color(0xFFFFFFFF); // Button text (ters kontrast)
  static const Color bgButtonSecondary = Color(0xFFF5F5F5); // Secondary button background

  // ── Bildirim / durum renkleri ──────────────────────────────────────
  static const Color danger  = Color(0xFFFF3B30); // Error / geciken ödeme
  static const Color warning = Color(0xFFFF9500); // Warning / dikkat
  static const Color success = Color(0xFF34C759); // Success / aktif / tamamlandı
  static const Color info    = Color(0xFF007AFF); // Info / vurgu (çok sınırlı)

  // ── Premium (Pro hissi) ────────────────────────────────────────────
  static const Color premiumGold      = Color(0xFFC8A24A); // Altın premium vurgu
  static const Color premiumDark      = Color(0xFF1C1C1E); // Premium dark yüzey
  static const Color premiumHighlight = Color(0xFFF3E7C1); // Soft gold background highlight

  // ── Compatibility Aliases (to prevent breaking existing code) ──────
  static const Color black900 = textPrimary;
  static const Color black800 = textSecondary;
  static const Color black700 = Color(0xFF4A4A4A);
  static const Color black600 = textHint;
  static const Color gray300  = borderInput;
  static const Color gray100  = bgButtonSecondary;
  static const Color gray50   = bgPage;
  static const Color bgLight  = bgPage;
  static const Color bgDark   = primaryButton;
  static const Color textOnDark = buttonText;

  // ── Gradients ──────────────────────────────────────────────────────
  static const LinearGradient darkHeaderGradient = LinearGradient(
    colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFFC8A24A), Color(0xFF1C1C1E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color primaryDark    = black900;
  static const Color primaryGreen   = black900; 
  static const Color primaryGreenDark = black800;
  static const Color accentBlue     = info;

  static const LinearGradient primaryGradient   = darkHeaderGradient;
  static const LinearGradient greenGradient     = darkHeaderGradient;

  // ── Mini-app category accents (subtle, used for icons only) ────────
  static const Color categoryPersonel  = Color(0xFF4F46E5); 
  static const Color categoryFinans    = Color(0xFF059669); 
  static const Color categoryMusteri   = Color(0xFF2563EB); 
  static const Color categoryOperasyon = Color(0xFFD97706); 
  static const Color categoryRaporlama = Color(0xFFDB2777); 

  // ── Dark Mode Colors ─────────────────────────
  static const Color bgPageDark    = Color(0xFF0F1115); // Ana arka plan
  static const Color bgSurfaceDark = Color(0xFF171A21); // İkinci seviye arka plan
  static const Color bgCardDark    = Color(0xFF1E222B); // Kart arka planı
  static const Color hoverDark     = Color(0xFF262B36); // Hover / seçili kart
  
  static const Color textPrimaryDark   = Color(0xFFFFFFFF); // Ana başlıklar
  static const Color textSecondaryDark = Color(0xFFE5E7EB); // Normal metin
  static const Color textHintDark      = Color(0xFFA8B0BD); // Açıklama metni
  static const Color textDisabledDark  = Color(0xFF6B7280); // Pasif metin
  
  static const Color borderCardDark    = Color(0xFF2D3440); // Kart kenarlıkları
  static const Color borderInputDark   = Color(0xFF3A414D); // Input kenarlıkları
  static const Color dividerDark       = Color(0xFF444C5A); // Ayırıcı çizgiler

  static const Color buttonPrimaryBgDark = Color(0xFFFFFFFF);
  static const Color buttonPrimaryTextDark = Color(0xFF111111);
  static const Color buttonSecondaryBgDark = Color(0xFF262B36);
  static const Color buttonSecondaryTextDark = Color(0xFFFFFFFF);

  static const Color successDark = Color(0xFF22C55E);
  static const Color warningDark = Color(0xFFF59E0B);
  static const Color errorDark   = Color(0xFFEF4444);
  static const Color infoDark    = Color(0xFF3B82F6);

  static const Color premiumGoldDark = Color(0xFFD4AF37);
  static const Color premiumCardDark = Color(0xFF18181B);
  
  static const LinearGradient premiumGradientDark = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFF4D35E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
