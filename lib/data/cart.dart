import '../models/product.dart';

class Cart {
  static List<Product> urunler = [];

  static void ekle(Product urun) {
    urunler.add(urun);
  }

  static void cikar(Product urun) {
    urunler.remove(urun);
  }

  static void temizle() {
    urunler.clear();
  }

  static double get toplam {
    double sonuc = 0;
    for (var urun in urunler) {
      sonuc += urun.priceValue;
    }
    return sonuc;
  }
}
