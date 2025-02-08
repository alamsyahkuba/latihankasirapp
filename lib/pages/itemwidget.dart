import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/editproduk.dart';
import 'package:latihankasirapp/pages/theme.dart';
import 'package:latihankasirapp/pages/transaksi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:latihankasirapp/pages/createproduk.dart';

final supabase = Supabase.instance.client;

class ItemWidget extends StatefulWidget {
  const ItemWidget(
      {super.key, required this.searchQuery, required this.onCartUpdated});

  final String searchQuery;
  final Function(Map<int, Map<String, dynamic>>) onCartUpdated;

  @override
  ItemWidgetState createState() => ItemWidgetState();
}

class ItemWidgetState extends State<ItemWidget> {
  List<Map<String, dynamic>> products = [];
  // Map<int, Map<String, dynamic>> cartItems = {};

  Future<String?> _getRole() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId == null) {
      print("User ID tidak ditemukan di SharedPreferences");
      return null;
    }

    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('users')
        .select('role')
        .eq('id', userId)
        .maybeSingle();

    return response?['role'];
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future fetchProducts() async {
    final response = await supabase
        .from('products')
        .select()
        .order('created_at', ascending: false);
    setState(() {
      products = List<Map<String, dynamic>>.from(response);
    });
  }

  // void _updateCart() {
  //   widget.onCartUpdated(cartItems);
  // }

  void deleteProduct(int productId) async {
    await supabase.from('products').delete().match({'id': productId});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Produk berhasil dihapus!')),
    );
    Navigator.pop(context);
    fetchProducts();
  }

  void showEditDialog(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Produk'),
          content: EditProductPage(
              product: product, onProductUpdated: fetchProducts),
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Produk'),
          content: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Anda yakin ingin menghapus produk ini?"),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child:
                            Text("Batal", style: TextStyle(color: Colors.red)),
                      ),
                      ElevatedButton(
                        onPressed: () => deleteProduct(product['id']),
                        child: Text("Hapus"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // void _incrementCart(Map<String, dynamic> product) {
  //   setState(() {
  //     int productId = product['id'];
  //     if (cartItems.containsKey(productId)) {
  //       cartItems[productId]!['jumlah'] += 1;
  //     } else {
  //       cartItems[productId] = {
  //         'nama': product['name'],
  //         'harga': product['price'],
  //         'jumlah': 1,
  //         'total_harga': product['price'],
  //       };
  //     }
  //     cartItems[productId]!['total_harga'] =
  //         cartItems[productId]!['jumlah'] * cartItems[productId]!['harga'];
  //     _updateCart();
  //   });
  // }

  // void _decrementCart(int productId) {
  //   setState(() {
  //     if (cartItems.containsKey(productId)) {
  //       if (cartItems[productId]!['jumlah'] > 1) {
  //         cartItems[productId]!['jumlah'] -= 1;
  //         cartItems[productId]!['total_harga'] =
  //             cartItems[productId]!['jumlah'] * cartItems[productId]!['harga'];
  //       } else {
  //         cartItems.remove(productId);
  //       }
  //     }
  //     _updateCart();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      final productName = product['name'].toLowerCase() ?? '';
      return productName.contains(widget.searchQuery);
    }).toList();

    return FutureBuilder(
      future: _getRole(),
      builder: (context, snapshot) {
        final role = snapshot.data;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final productId = product['id'];
                  // final cartCount = cartItems[productId]?['jumlah'] ?? 0;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                          Text(product['name'], style: thirdTextStyle),
                          SizedBox(height: 8),
                          Text("Harga: ${product['price']}",
                              style: fiveTextStyle),
                          SizedBox(height: 6),
                          Text("Stok: ${product['stock']}",
                              style: fiveTextStyle),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    color: Colors.blue[900],
                                    onPressed: () =>
                                        showEditDialog(context, product),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.red[900],
                                    onPressed: () =>
                                        showDeleteDialog(context, product),
                                  ),
                                ],
                              ),
                              // if (role == "Pegawai")
                              //   cartCount > 0
                              //       ? Row(
                              //           children: [
                              //             IconButton(
                              //               icon: Icon(Icons.remove),
                              //               color: Colors.red,
                              //               onPressed: () =>
                              //                   _decrementCart(productId),
                              //             ),
                              //             Text('$cartCount',
                              //                 style: fiveTextStyle),
                              //             IconButton(
                              //               icon: Icon(Icons.add),
                              //               color: Colors.green,
                              //               onPressed: () =>
                              //                   _incrementCart(product),
                              //             ),
                              //           ],
                              //         )
                              //       : IconButton(
                              //           icon: Icon(Icons.shopping_cart),
                              //           color: secondaryColor,
                              //           onPressed: () =>
                              //               _incrementCart(product),
                              //         ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
