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
    final response = await supabase
        .from('products')
        .select()
        .order('created_at', ascending: false);

    // memasukkan data yang telah diambil ke List array
    setState(() {
      products = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      final productName = product['name'].toLowerCase() ?? '';
      return productName.contains(widget.searchQuery);
    }).toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: thirdTextStyle,
                ),
                SizedBox(height: 8),
                Text(
                  "Harga: ${product['price']}",
                  style: fiveTextStyle,
                ),
                SizedBox(height: 6),
                Text(
                  "Stok: ${product['stock']}",
                  style: fiveTextStyle,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.blue[900],
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return EditProductPage(
                              product: product,
                            );
                          }),
                        );
                      },
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.red[900],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
