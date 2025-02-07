import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:latihankasirapp/pages/theme.dart';

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
  String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
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
              Text("Tanggal: $formattedDate", style: fourthTextStyle.copyWith(color: Colors.black)),
              Text("Pelanggan: ${selectedCustomer ?? '-'}", style: fourthTextStyle.copyWith(color: Colors.black)),
              SizedBox(height: 10),
              Text("Detail Transaksi:", style: fourthTextStyle.copyWith(color: Colors.black)),
              SizedBox(height: 8),
              Table(
                border: TableBorder.all(color: greyColor),
                columnWidths: {
                  0: FlexColumnWidth(3.2),
                  1: FlexColumnWidth(2.5),
                  2: FlexColumnWidth(2.3),
                  3: FlexColumnWidth(2.5),
                },
                children: [
                  _buildTableRow(['Nama Produk', 'Jumlah', 'Harga', 'Total Harga',], isHeader: true,),
                  _buildTableRow(['Indomie', '1', '3.500', '3.500']),
                  _buildTableRow(['Telor', '2', '3.000', '6.000']),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Transaksi:', style: fourthTextStyle.copyWith(fontSize: 15,color: Colors.black, fontWeight: FontWeight.bold)),
                  Text('9.500', style: secondTextStyle.copyWith(fontSize: 15, color: Colors.redAccent)),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Tutup",
                  style: fiveTextStyle,
                  ),
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
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text("Tutup"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Transaksi",
          style: secondTextStyle.copyWith(fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            SizedBox(height: 16),
            Text("Rincian Transaksi",
            style: eightTextStyle,
            ),
            SizedBox(height: 8),
            Table(
              // border: TableBorder.all(color: Colors.grey),
              children: [
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(5.0), child: Text('Nama Produk', style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(5.0), child: Text('Jumlah', style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(5.0), child: Text('Harga', style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(5.0), child: Text('Total Harga', style: TextStyle(fontWeight: FontWeight.bold))),
                ]),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(8.0), child: Text('Indomie')),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('1')),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('3.500')),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('3.500')),
                ]),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(8.0), child: Text('Telor')),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('2')),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('3.000')),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('6.000')),
                ]),
              ],
            ),
            SizedBox(height: 16),
            Text("Total Pesanan ",
            style: thirdTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 16),
            Text("Total",
            style: eightTextStyle.copyWith(fontSize: 18),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: EdgeInsets.symmetric(vertical: 16)),
                onPressed: _showStrukPopup,
                child: Text('Cetak Struk', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}