import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

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
          'Yardım Merkezi',
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: context.bgCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.borderLight),
              ),
              child: TextField(
                style: TextStyle(color: context.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Nasıl yardımcı olabiliriz?',
                  hintStyle: TextStyle(color: context.textHint, fontSize: 14),
                  icon: Icon(Icons.search_rounded, color: context.textHint),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 32),

            Text(
              'Sıkça Sorulan Sorular',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: context.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            _buildFaqItem(
              context,
              question: 'Nasıl yeni bir personel ekleyebilirim?',
              answer: 'Ekip & Yetkiler menüsüne giderek sağ üst köşedeki + butonuna tıklayabilir, personelinize ait bilgileri girerek hızlıca ekleyebilirsiniz.',
            ),
            const SizedBox(height: 12),
            _buildFaqItem(
              context,
              question: 'Aboneliğimi nasıl iptal edebilirim?',
              answer: 'Abonelik & Faturalama bölümünden mevcut planınızı görüntüleyebilir ve iptal seçeneklerini yönetebilirsiniz. İptal işlemi bir sonraki fatura döneminden itibaren geçerli olur.',
            ),
            const SizedBox(height: 12),
            _buildFaqItem(
              context,
              question: 'Birden fazla işletme ekleyebilir miyim?',
              answer: 'Evet, Elephor+ Pro veya Kurumsal plan kullanarak hesabınıza dilediğiniz kadar şube ve işletme bağlayabilir, hepsini tek merkezden yönetebilirsiniz.',
            ),
            const SizedBox(height: 12),
            _buildFaqItem(
              context,
              question: 'Verilerim güvende mi?',
              answer: 'Verileriniz en yüksek güvenlik standartlarıyla şifrelenir ve bulut sunucularımızda güvenle saklanır. Düzenli olarak otomatik yedeklemeler alınmaktadır.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(BuildContext context, {required String question, required String answer}) {
    return Container(
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderLight),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: context.textPrimary,
          collapsedIconColor: context.textHint,
          title: Text(
            question,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: context.textPrimary,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 13,
                  color: context.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
