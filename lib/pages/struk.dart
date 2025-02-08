import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal
import 'package:latihankasirapp/pages/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReceiptPage extends StatefulWidget {
  final String transactionId;
  final String cashier;
  final String customer;
  final List<Map<String, dynamic>> items;
  final double totalAmount;
  final double payment;
  final double change;

  ReceiptPage({
    required this.transactionId,
    required this.cashier,
    required this.customer,
    required this.items,
    required this.totalAmount,
    required this.payment,
    required this.change,
  });

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

    int totalItem =
        widget.items.fold(0, (sum, item) => sum + (item['jumlah'] as int));

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
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Kasir Pintar',
                  style: secondTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(height: 10),
              Text('STRUK INI DIBUAT DENGAN SEMESTINYA OLEH PIHAK KAMI'),
              Text('Terima kasih telah berbelanja'),
              Divider(),
              Text('No. Transaksi: ${widget.transactionId}'),
              Text('Petugas: ${widget.cashier}'),
              Divider(),
              ...widget.items
                  .map((item) => buildItemRow(item['name'],
                      item['jumlah'].toString(), item['price'].toString()))
                  .toList(),
              Divider(),
              buildTotalRow('Total Item', totalItem.toString(), ''),
              buildTotalRow(
                  'Total Belanja', '', widget.totalAmount.toStringAsFixed(2)),
              buildTotalRow('Bayar', '', widget.payment.toStringAsFixed(2)),
              buildTotalRow('Kembalian', '', widget.change.toStringAsFixed(2)),
              Divider(),
              SizedBox(height: 10),
              Text('Tgl. $formattedDate', style: TextStyle(fontSize: 12)),
              Text('Pelanggan: ${widget.customer}',
                  style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemRow(String name, String qty, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(name, style: TextStyle(fontSize: 14))),
          Text("$qty x ", style: TextStyle(fontSize: 14)),
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
          Expanded(
              child: Text(title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          Text(qty,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(amount,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
