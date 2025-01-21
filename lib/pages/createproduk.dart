import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/theme.dart';

class CreateProductPage extends StatefulWidget {
  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      // String name = _nameController.text;
      // String description = _descriptionController.text;
      // double price = double.parse(_priceController.text);

      // // Simpan data produk (logic tergantung kebutuhan, misalnya kirim ke API atau simpan ke database)
      // print('Nama Produk: $name');
      // print('Deskripsi Produk: $description');
      // print('Harga Produk: $price');

      // // Tampilkan snackbar atau navigasi kembali
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Produk berhasil disimpan!')),
      // );

      // // Kosongkan form
      // _nameController.clear();
      // _descriptionController.clear();
      // _priceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Produk',
          style: sixTextStyle,
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
                decoration: InputDecoration(
                  labelText: 'Nama Produk',
                  border: OutlineInputBorder(),
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
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Produk',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi produk tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga Produk',
                  border: OutlineInputBorder(),
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
                child: Text('Simpan Produk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
