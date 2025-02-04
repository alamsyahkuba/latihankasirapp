import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/theme.dart';

class TransaksiPage extends StatefulWidget {
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  String selectedCustomer = 'Isma';
  final List<String> customers = ['Isma', 'Nisa', 'Rena'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Transaksi",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nama Pelanggan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedCustomer,
              items: customers.map((String customer) {
                return DropdownMenuItem<String>(
                  value: customer,
                  child: Text(customer),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCustomer = newValue!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Rincian Pesanan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Table(
              border: TableBorder.all(color: Colors.black26),
              columnWidths: const {
                0: FlexColumnWidth(2.5),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
              },
              children: const [
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Nama Produk', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Jumlah', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Harga', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Total Harga', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Indomie'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('1'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('3.500'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('3.500'),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Telor'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('2'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('3.000'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('6.000'),
                  ),
                ]),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Total Pesanan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '9.500',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '9.500',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {},
                child: const Text(
                  'Konfirmasi Pembayaran',
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
