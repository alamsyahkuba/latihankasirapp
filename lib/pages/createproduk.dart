import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/theme.dart';
import 'package:latihankasirapp/pages/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  Future _saveProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = _nameController.text;
    final priceString = _priceController.text;
    final stockString = _stockController.text;

    final price = double.tryParse(priceString);
    final stock = int.tryParse(stockString);

    final response = await supabase.from('products').insert({
      'name': name,
      'price': price,
      'stock': stock,
    });

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kesalahan: ${response.error.message}')),
      );
    } else {
      _nameController.clear();
      _priceController.clear();
      _stockController.clear();

      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Buat Produk', style: sixTextStyle),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  style: sevenTextStyle.copyWith(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nama Produk',
                    labelStyle: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama produk tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _stockController,
                  keyboardType: TextInputType.number,
                  style: sevenTextStyle.copyWith(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Stok Produk',
                    labelStyle: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Stok produk tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  style: sevenTextStyle.copyWith(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Harga Produk',
                    labelStyle: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga produk tidak boleh kosong';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Masukkan harga yang valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveProduct,
                  child: Text(
                    'Simpan Produk',
                    style: secondTextStyle.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
