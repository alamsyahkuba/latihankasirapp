import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

class TransaksiPage extends StatefulWidget {
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  String selectedCustomer = 'Isma';
  final List<String> customers = ['Isma', 'Nisa', 'Rena'];

  void _showStrukPopup() {
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Struk Pembelian"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tanggal: $formattedDate"),
              Text("Pelanggan: $selectedCustomer"),
              const SizedBox(height: 10),
              const Text("Detail Transaksi:"),
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Total Transaksi:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('9.500', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nama Pelanggan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _showStrukPopup,
                child: const Text(
                  'Buat Struk',
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
