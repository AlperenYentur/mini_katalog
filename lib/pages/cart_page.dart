import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../models/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void siparisiTamamla() {
    setState(() {
      Cart.temizle();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Siparişiniz alındı')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sepet')),
      body: Cart.urunler.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Sepetiniz boş',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Alışverişe başlamak için ürün ekleyin',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: Cart.urunler.length,
              itemBuilder: (context, index) {
                Product urun = Cart.urunler[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      urun.image,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    urun.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(urun.price),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        Cart.cikar(urun);
                      });
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Toplam', style: TextStyle(fontSize: 16)),
                  Text(
                    '\$${Cart.toplam.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: Cart.urunler.isEmpty ? null : siparisiTamamla,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Siparişi Tamamla'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
