import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgPage,
      appBar: AppBar(
        backgroundColor: context.bgPage,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: context.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Gizlilik Politikası',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: context.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            Text(
              'Son Güncelleme: 1 Ocak 2026',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: context.textHint,
              ),
            ),
            const SizedBox(height: 24),
            _buildParagraph(context, 'Elephor+ olarak kişisel verilerinizin güvenliğine ve gizliliğine büyük önem veriyoruz. Bu Gizlilik Politikası, uygulamamızı kullanırken toplanan verilerinizin nasıl işlendiğini, saklandığını ve korunduğunu açıklamaktadır.'),
            
            const SizedBox(height: 24),
            _buildHeading(context, '1. Toplanan Veriler'),
            _buildParagraph(context, 'Hesabınızı oluştururken adınız, e-posta adresiniz, işletme bilgileriniz ve iletişim numaranız gibi temel kimlik ve iletişim bilgilerinizi topluyoruz. Ayrıca, uygulamayı kullanımınız sırasında girdiğiniz müşteri, personel, finans ve operasyon verileri de sunucularımızda saklanmaktadır.'),
            
            const SizedBox(height: 24),
            _buildHeading(context, '2. Verilerin Kullanımı'),
            _buildParagraph(context, 'Toplanan veriler, size kesintisiz ve kişiselleştirilmiş bir hizmet sunmak, hesabınızı güvende tutmak, ödemeleri işlemek ve teknik destek sağlamak amacıyla kullanılır. İstatistiksel veriler anonimleştirilerek hizmetlerimizi geliştirmek için analiz edilebilir.'),
            
            const SizedBox(height: 24),
            _buildHeading(context, '3. Veri Güvenliği'),
            _buildParagraph(context, 'Verileriniz en güncel şifreleme teknolojileriyle korunmaktadır. Sunucularımız düzenli güvenlik testlerinden geçmekte ve yetkisiz erişimlere karşı sıkı önlemlerle denetlenmektedir.'),

            const SizedBox(height: 24),
            _buildHeading(context, '4. Üçüncü Taraflarla Paylaşım'),
            _buildParagraph(context, 'Kişisel verileriniz, yasal zorunluluklar dışında veya açık izniniz olmadan kesinlikle üçüncü şahıslarla paylaşılmaz veya satılmaz. Yalnızca ödeme altyapısı gibi zorunlu hizmet sağlayıcılarla, güvenli kanallar üzerinden paylaşılır.'),
            
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.textPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: Text(
                'Kabul Ediyorum',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: context.bgPage,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: context.textPrimary,
        ),
      ),
    );
  }

  Widget _buildParagraph(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: context.textSecondary,
        height: 1.6,
      ),
    );
  }
}
