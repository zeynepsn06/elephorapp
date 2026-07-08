import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/siparis_model.dart';

class SiparisAddScreen extends StatefulWidget {
  const SiparisAddScreen({super.key});

  @override
  State<SiparisAddScreen> createState() => _SiparisAddScreenState();
}

class _SiparisAddScreenState extends State<SiparisAddScreen> {
  String? _selectedMusteri;
  final List<String> _musteriler = ['Ahmet Yılmaz', 'Zeynep Kaya', 'Mavi Reklam Ajansı', 'ABC Teknoloji'];

  final List<SiparisUrun> _addedUrunler = [];

  final _urunAdiCtrl = TextEditingController();
  final _adetCtrl = TextEditingController(text: '1');
  final _fiyatCtrl = TextEditingController();

  @override
  void dispose() {
    _urunAdiCtrl.dispose();
    _adetCtrl.dispose();
    _fiyatCtrl.dispose();
    super.dispose();
  }

  void _urunEkle() {
    if (_urunAdiCtrl.text.trim().isEmpty || _adetCtrl.text.isEmpty || _fiyatCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen ürün bilgilerini eksiksiz girin.'), backgroundColor: AppColors.danger));
      return;
    }

    setState(() {
      _addedUrunler.add(SiparisUrun(
        urunAdi: _urunAdiCtrl.text.trim(),
        adet: int.tryParse(_adetCtrl.text) ?? 1,
        birimFiyat: double.tryParse(_fiyatCtrl.text) ?? 0,
      ));
      _urunAdiCtrl.clear();
      _adetCtrl.text = '1';
      _fiyatCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalTutar = _addedUrunler.fold(0, (sum, u) => sum + u.toplamFiyat);

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Yeni Sipariş Oluştur',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _FormSection(
            title: 'Müşteri Bilgisi',
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.bgPage,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedMusteri,
                  hint: const Text('Müşteri Seçiniz', style: TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w500)),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textHint),
                  dropdownColor: AppColors.bgCard,
                  items: _musteriler.map((m) => DropdownMenuItem(value: m, child: Text(m, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)))).toList(),
                  onChanged: (val) => setState(() => _selectedMusteri = val),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          _FormSection(
            title: 'Ürün Ekle',
            child: Column(
              children: [
                _buildTextField(controller: _urunAdiCtrl, hintText: 'Ürün Adı', icon: Icons.inventory_2_outlined),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildTextField(controller: _adetCtrl, hintText: 'Adet', icon: Icons.numbers_rounded, keyboardType: TextInputType.number),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: _buildTextField(controller: _fiyatCtrl, hintText: 'Birim Fiyat (₺)', icon: Icons.monetization_on_outlined, keyboardType: TextInputType.number),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _urunEkle,
                    icon: const Icon(Icons.add_shopping_cart_rounded, size: 18),
                    label: const Text('Listeye Ekle', style: TextStyle(fontWeight: FontWeight.w700)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.categoryOperasyon,
                      side: BorderSide(color: AppColors.categoryOperasyon.withOpacity(0.5)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          if (_addedUrunler.isNotEmpty) ...[
            Text('Siparişe Eklenen Ürünler', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.3)),
            const SizedBox(height: 16),
            ..._addedUrunler.asMap().entries.map((entry) {
              final idx = entry.key;
              final urun = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(urun.urunAdi, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                          const SizedBox(height: 4),
                          Text('${urun.adet} Adet x ₺${urun.birimFiyat}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    Text('₺${urun.toplamFiyat.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: AppColors.danger, size: 20),
                      onPressed: () => setState(() => _addedUrunler.removeAt(idx)),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.categoryOperasyon.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Toplam Tutar:', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.categoryOperasyon, fontSize: 16)),
                  Text('₺${totalTutar.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.categoryOperasyon, fontSize: 20)),
                ],
              ),
            ),
          ],
          
          const SizedBox(height: 40),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_selectedMusteri == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen müşteri seçiniz.'), backgroundColor: AppColors.warning));
                  return;
                }
                if (_addedUrunler.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Siparişe en az 1 ürün eklemelisiniz.'), backgroundColor: AppColors.warning));
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sipariş başarıyla oluşturuldu!'),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                context.pop();
              },
              icon: const Icon(Icons.check_rounded, size: 22),
              label: const Text('Siparişi Tamamla', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.categoryOperasyon,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hintText, required IconData icon, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w500),
        prefixIcon: Icon(icon, color: AppColors.textHint, size: 22),
        filled: true,
        fillColor: AppColors.bgPage,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: AppColors.borderLight.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: AppColors.borderLight.withOpacity(0.5))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.categoryOperasyon, width: 2)),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _FormSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [BoxShadow(color: AppColors.black900.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.3)),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}
