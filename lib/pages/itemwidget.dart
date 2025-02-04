import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/editproduk.dart';
import 'package:latihankasirapp/pages/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ItemWidget extends StatefulWidget {
  const ItemWidget({super.key, required this.searchQuery});

  final String searchQuery;

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future fetchProducts() async {
    final response = await supabase.from('products').select().order('created_at', ascending: false);
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
        bool showQuantityControls = false;
        int quantity = 0;

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
                    Row(
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
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red[900],
                          onPressed: () {
                            // Tambahkan logika penghapusan produk
                          },
                        ),
                      ],
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.shopping_cart),
                              color: secondaryColor,
                              onPressed: () {
                                setState(() {
                                  showQuantityControls = !showQuantityControls;
                                });
                              },
                            ),
                            if (showQuantityControls) ...[
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 0) quantity--;
                                  });
                                },
                              ),
                              Text('$quantity', style: fiveTextStyle),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ]
                          ],
                        );
                      },
                    ),
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
