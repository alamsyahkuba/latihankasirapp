import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
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

      // Formatter Rupiah
      // final NumberFormat _currencyFormat = NumberFormat.currency(
      //   locale: 'id_ID',
      //   symbol: 'Rp',
      //   decimalDigits: 0,
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
          'Buat Produk',
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
                style: sevenTextStyle.copyWith(
                  // Menggunakan gaya yang ada dan menyesuaikan
                  fontFamily: 'Poppins', // Mengganti font menjadi Roboto
                  fontSize: 13, // Ukuran font lebih besar
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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: greyColor,
                        width: 2.0), // Warna border saat tidak fokus
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: greyColor,
                        width: 2.0), // Warna border saat fokus
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
                controller: _descriptionController,
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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: greyColor,
                        width: 2.0), // Warna border saat tidak fokus
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: greyColor,
                        width: 2.0), // Warna border saat fokus
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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: greyColor,
                        width: 2.0), // Warna border saat tidak fokus
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: greyColor,
                        width: 2.0), // Warna border saat fokus
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
    );
  }
}
