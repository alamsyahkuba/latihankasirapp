import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:latihankasirapp/pages/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransaksiPage extends StatefulWidget {
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  String? selectedCustomer;
  List<Map<String, dynamic>> customers = [];

  final supabase = Supabase.instance.client;

  Future fetchCustomers() async {
    final response = await supabase.from('pelanggan').select();
    setState(() {
      customers = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  void _showStrukPopup() {
    String formattedDate =
        DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPaint(
                    painter: SobekanPainter(),
                    child: Container(height: 40, width: double.infinity),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            spreadRadius: 1),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Struk Pembelian",
                            style: sixTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: secondaryColor),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("Tanggal: $formattedDate"),
                        Text("Pelanggan: $selectedCustomer"),
                        SizedBox(height: 10),
                        Text("Detail Transaksi:"),
                        Table(
                          border: TableBorder.all(color: Colors.black26),
                          columnWidths: const {
                            0: FlexColumnWidth(2.5),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(2),
                            3: FlexColumnWidth(2),
                          },
                          children: const [
                            TableRow(children: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('Nama Produk',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('Jumlah',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('Harga',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('Total Harga',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('Indomie'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('1'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('3.500'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('3.500'),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('Telor'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('2'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('3.000'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('6.000'),
                              ),
                            ]),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Total Transaksi:',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('9.500',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent)),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Tutup"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
        title: Text(
          "Transaksi",
          style: sixTextStyle.copyWith(
              fontSize: 22, fontWeight: FontWeight.bold, color: secondaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nama Pelanggan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
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
                  selectedCustomer = newValue!;
                });
              },
              decoration: InputDecoration(
                hintText: "Pilih pelanggan",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
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
                onPressed: () {
                  if (selectedCustomer == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Pilih pelanggan terlebih dahulu!")),
                    );
                    return;
                  }
                  _showStrukPopup;
                },
                child: const Text(
                  'Buat Struk',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SobekanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    for (double i = 0; i < size.width; i += 10) {
      path.lineTo(i, i % 20 == 0 ? 10 : 0);
    }
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
