import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/theme.dart';

class EReceiptScreen extends StatefulWidget {
  @override
  _EReceiptScreenState createState() => _EReceiptScreenState();
}

class _EReceiptScreenState extends State<EReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-RECEIPT', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kasir Pintar", style: secondTextStyle.copyWith(fontSize: 18),
            ),
            Text('No. Transaksi : M1H4-123-0602CMDX        Petugas : MARISKA',
                style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            _buildItemRow('KP BRANDING (L)', '1', '500', '500'),
            _buildItemRow('MS RL GPPR 2S', '1', '16,500', '16,500'),
            _buildItemRow('Disc.', '', '', '-2,600'),
            _buildItemRow('SEDAAP MRC 79G', '1', '5,500', '5,500'),
            _buildItemRow('SEDAAP KARI 81G', '1', '5,500', '5,500'),
            _buildItemRow('KNZLR BKS HT48G', '1', '8,900', '8,900'),
            _buildItemRow('WLS PP SHK150ML', '1', '10,700', '10,700'),
            Divider(),
            _buildSummaryRow('Total Item', '6', ''),
            _buildSummaryRow('Total Belanja', '', '45,000'),
            _buildSummaryRow('Kembalian', '', '0'),
            Divider(),
            SizedBox(height: 8),
            Center(child: Text('Tgl. 06-02-2025 10:52:50  V.2025.1.0')),
            Center(child: Text('Nama Pelanggan : LOLITA ********', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(String name, String qty, String price, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: Text(name, style: TextStyle(fontSize: 14))),
          Expanded(flex: 1, child: Text(qty, textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text(price, textAlign: TextAlign.right)),
          Expanded(flex: 2, child: Text(total, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String middle, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text(middle, textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text(value, textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
