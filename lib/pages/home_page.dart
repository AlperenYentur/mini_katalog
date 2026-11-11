import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../data/product_service.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> tumUrunler = [];
  String arama = '';
  bool yukleniyor = true;

  @override
  void initState() {
    super.initState();
    verileriGetir();
  }

  void verileriGetir() async {
    List<Product> gelen = await urunleriYukle();
    setState(() {
      tumUrunler = gelen;
      yukleniyor = false;
    });
  }

  void sepeteGit() async {
    await Navigator.pushNamed(context, '/cart');
    setState(() {});
  }

  void detayaGit(Product urun) async {
    await Navigator.pushNamed(context, '/detail', arguments: urun);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Product> gosterilecek = tumUrunler.where((urun) {
      return urun.name.toLowerCase().contains(arama.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keşfet'),
        actions: [
          IconButton(
            onPressed: sepeteGit,
            icon: Badge(
              label: Text(Cart.urunler.length.toString()),
              isLabelVisible: Cart.urunler.isNotEmpty,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: yukleniyor
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Ürün ara',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (deger) {
                      setState(() {
                        arama = deger;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset('assets/images/banner.png'),
                  ),
                  const SizedBox(height: 12),
                  if (gosterilecek.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(child: Text('Ürün bulunamadı')),
                    ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: gosterilecek.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      Product urun = gosterilecek[index];
                      return ProductCard(
                        urun: urun,
                        onTap: () => detayaGit(urun),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
