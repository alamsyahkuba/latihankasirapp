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
    final screenWidth = MediaQuery.of(context).size.width; // Mengatur ukuran lebar layar agar responsive menggunakan MediaQuery

    // memfilter products yang telah diambil dari supabase dengan mengubah nilai name menjadi lowercase
    final filteredProducts = products.where((product) {
      final productName = product['name'].toLowerCase() ?? '';
      return productName.contains(widget.searchQuery);
    }).toList();

    return GridView.builder(
        shrinkWrap: true,
        itemCount: filteredProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (screenWidth / 200).floor(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.5,
        ),
        itemBuilder: (context, index) {
          final product =
              products[index]; // mengambil product dari products sesuai index

          return GridTile(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    decoration: BoxDecoration(
                      color: Color(0xF8FAFC),
                      borderRadius: BorderRadius.circular(20),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.5), //warna bayangan
                      //     spreadRadius: 0.5,
                      //     blurRadius: 1,
                      //     offset: Offset(1, 1),
                      //   )
                      // ]
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            Icon(
                              Icons.favorite_border,
                              color: Colors.redAccent[700],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Image.asset(
                              "images/login.jpg",
                              height: 120,
                              width: 120,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            product['name'], // memanggil nama product
                            style: thirdTextStyle,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Harga: ${product['price']}", // memanggil harga
                            // "Stok: ${product['stock']}", //memanggil stok
                            style: fiveTextStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
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
        });
  }
}
