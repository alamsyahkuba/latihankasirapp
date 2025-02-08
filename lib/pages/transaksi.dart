import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:latihankasirapp/pages/theme.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  String? selectedCustomer;
  Map<String, dynamic>? selectedProduct;
  List<Map<String, dynamic>> customers = [];
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> cartItems = [];
  final supabase = Supabase.instance.client;
  // final _formKey = GlobalKey<FormState>();

  Future fetchCustomers() async {
    final response = await supabase.from('pelanggan').select();
    setState(() {
      customers = List<Map<String, dynamic>>.from(response);
    });
  }

  Future fetchProducts() async {
    final response = await supabase.from('products').select();
    setState(() {
      products = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCustomers();
    fetchProducts();
  }

  void _addProductToCart(Map<String, dynamic> product) {
    setState(() {
      // Cek apakah produk sudah ada di keranjang
      bool productExists = false;
      for (var item in cartItems) {
        if (item['id'] == product['id']) {
          // Jika produk sudah ada, tambahkan jumlahnya
          item['jumlah'] += 1;
          productExists = true;
          break;
        }
      }

      // Jika produk belum ada, tambahkan produk baru dengan jumlah 1
      if (!productExists) {
        cartItems.add({
          'id': product['id'],
          'name': product['name'],
          'price': product['price'],
          'jumlah': 1,
        });
      }
    });
  }

  void _incrementQuantity(int index) {
    setState(() {
      cartItems[index]['jumlah']++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (cartItems[index]['jumlah'] > 1) {
        cartItems[index]['jumlah']--;
      }
    });
  }

  void _removeProductFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // Fungsi untuk menghitung total transaksi
  double _calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item['jumlah'] * item['price'];
    }
    return total;
  }

  Future<void> _simpanTransaksi() async {
    // Pastikan pelanggan dipilih sebelum menyimpan
    if (selectedCustomer == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pilih pelanggan terlebih dahulu!'),
      ));
      return;
    }

    // Menyimpan data ke tabel penjualan
    final responsePenjualan = await supabase.from('penjualan').insert([
      {
        'tanggalPenjualan':
            DateTime.now().toIso8601String(), // Tanggal sekarang
        'totalHarga': _calculateTotal(), // Total harga dari keranjang
        'pelangganId': customers.firstWhere(
            (customer) => customer['nama'] == selectedCustomer)['id'],
      }
    ]);

    if (responsePenjualan != null) {
      // Jika gagal menyimpan data penjualan
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Gagal menyimpan transaksi: $responsePenjualan'),
      ));
      return;
    }

    final responsePenjualanId = await supabase
        .from('penjualan')
        .select('id') // Ambil hanya kolom 'id'
        .eq(
            'tanggalPenjualan',
            DateTime.now()
                .toIso8601String()) // Cari berdasarkan tanggal transaksi
        .order('id',
            ascending:
                false) // Urutkan berdasarkan ID, yang terakhir akan menjadi yang baru
        .limit(1) // Ambil hanya satu data terakhir
        .single(); // Ambil satu data saja, karena hanya ada satu data yang diinsert

    // Dapatkan id penjualan yang baru disimpan
    final penjualanId = responsePenjualanId['id'];

    // Menyimpan data ke tabel detailpenjualan
    for (var item in cartItems) {
      final produkId = item['id'];
      final jumlahProduk = item['jumlah'];
      final subTotal = item['jumlah'] * item['price'];

      final responseDetail = await supabase.from('detailPenjualan').insert([
        {
          'penjualanId': penjualanId,
          'produkId': produkId,
          'jumlahProduk': jumlahProduk,
          'subTotal': subTotal,
        }
      ]);

      if (responseDetail != null) {
        // Jika gagal menyimpan detail penjualan
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal menyimpan detail produk: $responseDetail'),
        ));
        return;
      }
    }

    // Jika semua berhasil disimpan, tampilkan struk
    _showStrukPopup();
  }

  // Menampilkan popup struk
  void _showStrukPopup() {
    String formattedDate =
        DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(16),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Struk Pembelian",
                    style: secondTextStyle.copyWith(fontSize: 19),
                  ),
                ),
                SizedBox(height: 8),
                Text("Tanggal: $formattedDate",
                    style: fourthTextStyle.copyWith(color: Colors.black)),
                Text("Pelanggan: ${selectedCustomer ?? '-'}",
                    style: fourthTextStyle.copyWith(color: Colors.black)),
                SizedBox(height: 10),
                Text("Detail Transaksi:",
                    style: fourthTextStyle.copyWith(color: Colors.black)),
                SizedBox(height: 8),
                Table(
                  border: TableBorder.all(color: greyColor),
                  columnWidths: {
                    0: FlexColumnWidth(3.0),
                    1: FlexColumnWidth(2.9),
                    2: FlexColumnWidth(2.4),
                    3: FlexColumnWidth(2.4),
                  },
                  children: [
                    _buildTableRow(
                      ['Nama Produk', 'Jumlah', 'Harga', 'Total Harga'],
                      isHeader: true,
                    ),
                    ...cartItems.map((product) {
                      return _buildTableRow([
                        product['name'],
                        product['jumlah'].toString(),
                        NumberFormat.currency(locale: 'id-ID', symbol: 'Rp ')
                            .format(product['price']),
                        NumberFormat.currency(locale: 'id-ID', symbol: 'Rp ')
                            .format(product['jumlah'] * product['price']),
                      ]);
                    }).toList(),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Transaksi:',
                        style: fourthTextStyle.copyWith(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    Text(
                      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
                          .format(_calculateTotal()),
                      style: secondTextStyle.copyWith(
                          fontSize: 15, color: Colors.redAccent),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Reset form setelah transaksi selesai
                      setState(() {
                        selectedCustomer =
                            null; // Mengosongkan pelanggan yang dipilih
                        selectedProduct = null;
                        cartItems.clear(); // Mengosongkan keranjang
                      });
                    },
                    child: Text("Tutup", style: fiveTextStyle),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TableRow _buildTableRow(List<String> values, {bool isHeader = false}) {
    return TableRow(
      children: values.map((value) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Transaksi", style: secondTextStyle.copyWith(fontSize: 22)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Dropdown
            Text("Nama Pelanggan", style: eightTextStyle),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedCustomer,
              items: customers.map((customer) {
                return DropdownMenuItem<String>(
                  value: customer['nama'],
                  child: Text(customer['nama']),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCustomer = newValue;
                });
              },
              decoration: InputDecoration(
                hintText: "Pilih pelanggan",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            SizedBox(height: 16),

            // Form untuk menambah produk
            Text("Pilih Produk", style: eightTextStyle),
            SizedBox(height: 8),
            DropdownButtonFormField<Map<String, dynamic>>(
              value: selectedProduct,
              hint: Text("Pilih produk"),
              items: products.map((product) {
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: product,
                  child: Text(product['name']),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  _addProductToCart(newValue);
                }
                selectedProduct = newValue;
              },
              decoration: InputDecoration(
                hintText: "Pilih produk",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            SizedBox(height: 16),

            // Menampilkan tulisan "Tambah Produk" dan Total di sebelah kanan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Rincian Pesanan", style: eightTextStyle),
                Row(
                  children: [
                    Text("Total: ", style: eightTextStyle),
                    Text(
                      "Rp ${_calculateTotal()}", // Menampilkan total harga produk
                      style: eightTextStyle.copyWith(color: Colors.redAccent),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartItems[index];
                  return ListTile(
                    title: Text(product['name']),
                    subtitle: Text(
                        'Jumlah: ${product['jumlah']} - Sub Total: Rp ${product['jumlah'] * product['price']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.red),
                          onPressed: () => _decrementQuantity(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.green),
                          onPressed: () => _incrementQuantity(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.blue),
                          onPressed: () => _removeProductFromCart(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Print Receipt Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _simpanTransaksi,
                child: Text('Cetak Struk',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
