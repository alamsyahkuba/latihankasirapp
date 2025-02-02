import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/editproduk.dart';
import 'package:latihankasirapp/pages/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ItemWidget extends StatefulWidget {
  const ItemWidget(
      {super.key,
      required this.searchQuery}); // Memberi opsi required searchQuery yang akan digunakan ketika memanggil ItemWidget di homepage

  final String searchQuery; // Membuat variabel String

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  List<Map<String, dynamic>> products =
      []; // List Map untuk products dalam bentuk array

  @override
  void initState() {
    super.initState();
    fetchProducts();
  } // Melakukan inisialisasi ketika aplikasi baru dibuka

  // Untuk mengambil data products dari supabase
  Future fetchProducts() async {
    final response = await supabase.from('products').select().order('created_at', ascending: false);

    // memasukkan data yang telah diambil ke List array
    setState(() {
      products = List<Map<String, dynamic>>.from(response);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final filteredProducts = products.where((product) {
      final productName = product['name'].toLowerCase() ?? '';
      return productName.contains(widget.searchQuery);
    }).toList();

    return GridView.builder(
      shrinkWrap: true,
      itemCount: filteredProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (screenWidth / 200).floor(),
        crossAxisSpacing: 8, // Jarak horizontal antar kotak
        mainAxisSpacing: 8, // Jarak vertikal antar kotak
        childAspectRatio: 1.2, // Mengatur rasio lebar ke tinggi kotak
      ),
      itemBuilder: (context, index) {
        final product = filteredProducts[index];

        return GridTile(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product['name'],
                          style: thirdTextStyle,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text(
                          "Harga: ${product['price']}",
                          style: fiveTextStyle,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Stok: ${product['stock']}",
                          style: fiveTextStyle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
