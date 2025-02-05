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

  void showEditDialog(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Produk'),
          content: EditProductForm(product: product, onProductUpdated: fetchProducts),
        );
      },
    );
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
                Text(product['name'], style: thirdTextStyle),
                SizedBox(height: 8),
                Text("Harga: ${product['price']}", style: fiveTextStyle),
                SizedBox(height: 6),
                Text("Stok: ${product['stock']}", style: fiveTextStyle),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.blue[900],
                          onPressed: () => showEditDialog(context, product),
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

class EditProductForm extends StatefulWidget {
  final Map<String, dynamic> product;
  final VoidCallback onProductUpdated;

  const EditProductForm({super.key, required this.product, required this.onProductUpdated});

  @override
  _EditProductFormState createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product['name']);
    _priceController = TextEditingController(text: widget.product['price'].toString());
    _stockController = TextEditingController(text: widget.product['stock'].toString());
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final updatedProduct = {
      'name': _nameController.text,
      'price': double.tryParse(_priceController.text),
      'stock': int.tryParse(_stockController.text),
    };
    await supabase.from('products').update(updatedProduct).eq('id', widget.product['id']);
    widget.onProductUpdated();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Nama Produk'),
            validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
          ),
          TextFormField(
            controller: _stockController,
            decoration: InputDecoration(labelText: 'Stok Produk'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Harga Produk'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: _saveProduct, child: Text('Simpan Produk')),
        ],
      ),
    );
  }
}
