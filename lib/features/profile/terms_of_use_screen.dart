import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

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
          'Kullanım Koşulları',
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
              'Yürürlük Tarihi: 1 Ocak 2026',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: context.textHint,
              ),
            ),
            const SizedBox(height: 24),
            _buildParagraph(context, 'Elephor+ platformuna hoş geldiniz. Uygulamamızı veya hizmetlerimizi kullanarak aşağıdaki Kullanım Koşullarını kabul etmiş sayılırsınız. Lütfen dikkatlice okuyunuz.'),
            
            const SizedBox(height: 24),
            _buildHeading(context, '1. Hizmet Kapsamı'),
            _buildParagraph(context, 'Elephor+, işletmelerin günlük operasyonlarını (vardiya, personel, sipariş, stok, vb.) dijital olarak yönetebilmeleri için sunulan bir hizmettir (SaaS).'),
            
            const SizedBox(height: 24),
            _buildHeading(context, '2. Kullanıcı Sorumlulukları'),
            _buildParagraph(context, 'Hesap bilgilerinizin gizliliği ve hesabınız altında gerçekleşen tüm faaliyetler sizin sorumluluğunuzdadır. Platform üzerinden yasadışı veya başkalarına zarar verici eylemler gerçekleştirmek yasaktır.'),
            
            const SizedBox(height: 24),
            _buildHeading(context, '3. Ödeme ve Abonelikler'),
            _buildParagraph(context, 'Ücretli planlarımıza geçiş yaptığınızda, seçtiğiniz döneme göre otomatik yenileme ile faturalandırılırsınız. İptal talepleri fatura dönemi bitmeden önce yapılmalıdır.'),

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
                'Anladım',
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
