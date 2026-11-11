import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/models/product.dart';

void main() {
  test('Product fromJson ve fiyat', () {
    final urun = Product.fromJson({
      'id': 1,
      'name': 'Test',
      'tagline': 'deneme',
      'description': 'aciklama',
      'price': '\$2,499',
      'image': 'assets/images/iphone.png',
      'specs': {'chip': 'A17'},
    });

    expect(urun.name, 'Test');
    expect(urun.priceValue, 2499);
    expect(urun.toJson()['id'], 1);
  });
}
