import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/siparis_model.dart';

class SiparisDetailScreen extends StatefulWidget {
  final String id;
  const SiparisDetailScreen({super.key, required this.id});

  @override
  State<SiparisDetailScreen> createState() => _SiparisDetailScreenState();
}

class _SiparisDetailScreenState extends State<SiparisDetailScreen> {
  // Mock data for detail
  late SiparisModel _siparis;
  final _kargoNoCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _siparis = SiparisModel(
      id: widget.id,
      siparisNo: 'SP-1001',
      musteriId: 'm1',
      musteriAdi: 'Ahmet Yılmaz',
      tarih: DateTime.now().subtract(const Duration(hours: 2)),
      durum: SiparisDurumu.yeniSiparis,
      urunler: [
        const SiparisUrun(urunAdi: 'Laptop', adet: 1, birimFiyat: 25000),
        const SiparisUrun(urunAdi: 'Mouse', adet: 2, birimFiyat: 500),
      ],
    );
  }

  @override
  void dispose() {
    _kargoNoCtrl.dispose();
    super.dispose();
  }

  void _durumGuncelle(SiparisDurumu yeniDurum) {
    setState(() {
      _siparis = SiparisModel(
        id: _siparis.id,
        siparisNo: _siparis.siparisNo,
        musteriId: _siparis.musteriId,
        musteriAdi: _siparis.musteriAdi,
        urunler: _siparis.urunler,
        tarih: _siparis.tarih,
        durum: yeniDurum,
        kargoTakipNo: _kargoNoCtrl.text.isNotEmpty ? _kargoNoCtrl.text : _siparis.kargoTakipNo,
        notlar: _siparis.notlar,
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sipariş durumu güncellendi.'), backgroundColor: AppColors.success));
  }

  void _showDurumDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.bgPage,
        title: const Text('Durum Güncelle', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: SiparisDurumu.values.map((durum) {
            String text = '';
            Color color = Colors.black;
            switch(durum) {
              case SiparisDurumu.yeniSiparis: text = 'Yeni Sipariş'; color = Colors.blue; break;
              case SiparisDurumu.hazirlaniyor: text = 'Hazırlanıyor'; color = Colors.orange; break;
              case SiparisDurumu.kargoda: text = 'Kargoda'; color = Colors.purple; break;
              case SiparisDurumu.teslimEdildi: text = 'Teslim Edildi'; color = Colors.green; break;
              case SiparisDurumu.iptalEdildi: text = 'İptal Edildi'; color = Colors.red; break;
            }
            return ListTile(
              title: Text(text, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
              onTap: () {
                Navigator.pop(ctx);
                if (durum == SiparisDurumu.kargoda && _kargoNoCtrl.text.isEmpty) {
                   _askForKargoNo();
                } else {
                  _durumGuncelle(durum);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _askForKargoNo() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.bgPage,
        title: const Text('Kargo Bilgisi', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        content: TextField(
          controller: _kargoNoCtrl,
          decoration: InputDecoration(
            hintText: 'Kargo Takip No giriniz...',
            filled: true,
            fillColor: AppColors.bgCard,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('İptal', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _durumGuncelle(SiparisDurumu.kargoda);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.categoryOperasyon),
            child: const Text('Kargoya Verildi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Sipariş Detayı',
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
          // Başlık Kartı
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: _siparis.durumColor.withOpacity(0.5), width: 1.5),
              boxShadow: [BoxShadow(color: _siparis.durumColor.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_siparis.siparisNo, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _siparis.durumColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _siparis.durumText,
                        style: TextStyle(color: _siparis.durumColor, fontSize: 13, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.person_outline_rounded, size: 20, color: AppColors.textHint),
                    const SizedBox(width: 8),
                    Text(_siparis.musteriAdi, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 20, color: AppColors.textHint),
                    const SizedBox(width: 8),
                    Text('${_siparis.tarih.day}.${_siparis.tarih.month}.${_siparis.tarih.year} ${_siparis.tarih.hour}:${_siparis.tarih.minute.toString().padLeft(2, '0')}', style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500, fontSize: 14)),
                  ],
                ),
                if (_siparis.kargoTakipNo != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.categoryOperasyon.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.local_shipping_outlined, color: AppColors.categoryOperasyon, size: 20),
                        const SizedBox(width: 8),
                        Text('Kargo No: ${_siparis.kargoTakipNo}', style: const TextStyle(color: AppColors.categoryOperasyon, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Ürün Listesi
          Text('Sipariş İçeriği', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.3)),
          const SizedBox(height: 16),
          ..._siparis.urunler.map((urun) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.bgPage, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.inventory_2_outlined, color: AppColors.textSecondary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(urun.urunAdi, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text('${urun.adet} Adet x ₺${urun.birimFiyat}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Text('₺${urun.toplamFiyat.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.textPrimary)),
                ],
              ),
            );
          }),
          
          const SizedBox(height: 16),
          // Toplam Tutar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.categoryOperasyon.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Toplam Tutar', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.categoryOperasyon)),
                Text('₺${_siparis.toplamTutar.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: AppColors.categoryOperasyon)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            border: Border(top: BorderSide(color: AppColors.borderLight)),
          ),
          child: Row(
            children: [
              if (_siparis.durum != SiparisDurumu.teslimEdildi && _siparis.durum != SiparisDurumu.iptalEdildi) ...[
                Expanded(
                  child: OutlinedButton(
                    onPressed: _showDurumDialog,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.borderLight),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Durum Değiştir', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _durumGuncelle(SiparisDurumu.teslimEdildi),
                    icon: const Icon(Icons.check_circle_rounded, size: 20),
                    label: const Text('Teslim Edildi', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bgPage,
                      foregroundColor: AppColors.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Geri Dön', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
