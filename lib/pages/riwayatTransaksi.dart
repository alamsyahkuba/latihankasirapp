import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/theme.dart';

class RiwayatTransaksi extends StatefulWidget {
  @override
  _RiwayatTransaksiState createState() => _RiwayatTransaksiState();
}

class _RiwayatTransaksiState extends State<RiwayatTransaksi> {
  List<Transaction> transactions = [
    Transaction(id: 34, date: '2 Februari 2024', total: 150000, items: [
      Item(name: 'Barang A', quantity: 2, price: 50000),
      Item(name: 'Barang B', quantity: 1, price: 50000),
    ]),
    Transaction(id: 33, date: '1 Februari 2024', total: 75000, items: [
      Item(name: 'Barang C', quantity: 1, price: 75000),
    ]),
    Transaction(id: 32, date: '30 Januari 2024', total: 150000, items: [
      Item(name: 'Barang D', quantity: 3, price: 50000),
    ]),
  ];

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Transaksi", style: sixTextStyle.copyWith(fontSize: 22, color: secondaryColor)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return TransactionTile(
              transaction: transactions[index],
              isExpanded: expandedIndex == index,
              onTap: () {
                setState(() {
                  expandedIndex = expandedIndex == index ? null : index;
                });
              },
            );
          },
        ),
      ),
    );
  }
}

class Transaction {
  final int id;
  final String date;
  final int total;
  final List<Item> items;
  Transaction({required this.id, required this.date, required this.total, required this.items});
}

class Item {
  final String name;
  final int quantity;
  final int price;
  Item({required this.name, required this.quantity, required this.price});
}

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final bool isExpanded;
  final VoidCallback onTap;

  TransactionTile({required this.transaction, required this.isExpanded, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Transaksi #${transaction.id}', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tgl. Transaksi: ${transaction.date}'),
                Text('Total: Rp ${transaction.total}'),
              ],
            ),
            trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
            onTap: onTap,
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Text('Nama Pembeli:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Pesanan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nama Barang', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Jumlah', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Harga', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: transaction.items.map((item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.name),
                          Text(item.quantity.toString()),
                          Text('Rp ${item.price}'),
                        ],
                      );
                    }).toList(),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Pesanan', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Rp ${transaction.total}', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
