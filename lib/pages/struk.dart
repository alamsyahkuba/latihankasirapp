import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/theme.dart';

class ReceiptPage extends StatefulWidget {
  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Text('E-RECEIPT', style: TextStyle(color: Colors.white)),
        backgroundColor: secondaryColor,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 400,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 5),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Kasir Pintar', style: secondTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
              SizedBox(height: 10),
              Text('STRUK INI DIBUAT DENGAN SEMESTINYA OLEH PIHAK KAMI'),
              Text('Terima kasih telah berbelanja'),
              Divider(),
              Text('No. Transaksi'),
              Text('Petugas :'),
              Divider(),
              // ini rincian transaksi atau produk produk yang dibeli
              Divider(),
              buildTotalRow('Total Item', '', ''),
              buildTotalRow('Total Belanja', '', ''),
              buildTotalRow('Kembalian', '', ''),
              Divider(),
              SizedBox(height: 10),
              Text('Tgl. 06-02-2025 10:52:50 ', style: TextStyle(fontSize: 12)), // buat tanggal dan jam menjadi real time
              Text('Pelanggan: ', style: TextStyle(fontSize: 12)), // buat nama pelanggan sesuai dengan nama pelanggan
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemRow(String name, String qty, String price, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(name, style: TextStyle(fontSize: 14, fontWeight: isDiscount ? FontWeight.bold : FontWeight.normal))),
          Text(qty, style: TextStyle(fontSize: 14)),
          Text(price, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget buildTotalRow(String title, String qty, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          Text(qty, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(amount, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
