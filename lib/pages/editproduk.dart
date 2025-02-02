import 'package:flutter/material.dart';
import 'package:latihankasirapp/components/bottombar.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:latihankasirapp/pages/theme.dart';
import 'package:latihankasirapp/pages/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProductPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const EditProductPage({super.key, required this.product});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _priceController = TextEditingController();
  late TextEditingController _stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product['name']);
    _priceController =
        TextEditingController(text: widget.product['price'].toString());
    _stockController =
        TextEditingController(text: widget.product['stock'].toString());
  }

  Future _saveProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final name = _nameController.text;
    final priceString = _priceController.text;
    final stockString = _stockController.text;

    final price = double.tryParse(priceString);
    final stock = int.tryParse(stockString);

    final response = await supabase
        .from('products')
        .update({
          'name': name,
          'price': price,
          'stock': stock,
        })
        .eq('id', widget.product['id'])
        .select()
        .maybeSingle();

    if (response == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kesalahan: $response')),
      );
    } else {
      // Kosongkan form
      _nameController.clear();
      _priceController.clear();
      _stockController.clear();
      // Tampilkan snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produk berhasil diperbarui!')),
      );

      // Langsung kembali ke halaman HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomBar(initialIndex: 0,),
        ),
      );
    }

    // Formatter Rupiah
    // final NumberFormat _currencyFormat = NumberFormat.currency(
    //   locale: 'id_ID',
    //   symbol: 'Rp',
    //   decimalDigits: 0,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Produk',
          style: sixTextStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomBar(initialIndex: 0,)),
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
