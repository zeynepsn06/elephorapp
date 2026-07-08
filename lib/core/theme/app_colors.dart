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

  // ── Dark Mode Colors (from elephor.com.tr) ─────────────────────────
  static const Color bgPageDark    = Color(0xFF07080A);
  static const Color bgCardDark    = Color(0xFF0F141B);
  static const Color bgSurfaceDark = Color(0xFF151A21);
  
  static const Color textPrimaryDark   = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFC9CDD3);
  static const Color textHintDark      = Color(0xFF7D8189);
  
  static const Color borderDark      = Color(0x1FFFFFFF);
  static const Color borderLightDark = Color(0x0FFFFFFF);
}
