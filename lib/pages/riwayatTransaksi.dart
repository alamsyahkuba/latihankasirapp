import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RiwayatTransaksi extends StatefulWidget {
  @override
  _RiwayatTransaksiState createState() => _RiwayatTransaksiState();
}

class _RiwayatTransaksiState extends State<RiwayatTransaksi> {
  final supabase = Supabase.instance.client;
  List<Transaction> transactions = [];
  int? expandedIndex;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    final response = await supabase
        .from('penjualan')
        .select('id, tanggalPenjualan, totalHarga, pelangganId')
        .order('id', ascending: false);

    List<Transaction> fetchedTransactions = [];

    for (var transaction in response) {
      final detailsResponse = await supabase
          .from('detailPenjualan')
          .select('produkId, jumlahProduk, subTotal')
          .eq('penjualanId', transaction['id']);

      List<Item> items = [];

      for (var detail in detailsResponse) {
        final productResponse = await supabase
            .from('products')
            .select('name, price')
            .eq('id', detail['produkId'])
            .maybeSingle();

        items.add(Item(
          name: productResponse?['name'] ?? 'Produk Tidak Diketahui',
          quantity: detail['jumlahProduk'],
          price: productResponse?['price'] ?? 0,
        ));
      }

      fetchedTransactions.add(Transaction(
        id: transaction['id'],
        date: transaction['tanggalPenjualan'].toString().split('T')[0],
        total: transaction['totalHarga'],
        items: items,
      ));
    }

    setState(() {
      transactions = fetchedTransactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Transaksi",
            style: sixTextStyle.copyWith(fontSize: 22, color: secondaryColor)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: transactions.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
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
  final double total;
  final List<Item> items;
  Transaction(
      {required this.id,
      required this.date,
      required this.total,
      required this.items});
}

class Item {
  final String name;
  final int quantity;
  final double price;
  Item({required this.name, required this.quantity, required this.price});
}

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final bool isExpanded;
  final VoidCallback onTap;

  TransactionTile(
      {required this.transaction,
      required this.isExpanded,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Transaksi #${transaction.id}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tanggal: ${transaction.date}'),
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
                  Text('Pesanan',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nama Barang',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Jumlah',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Harga',
                          style: TextStyle(fontWeight: FontWeight.bold)),
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
                      Text('Total Pesanan',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Rp ${transaction.total}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
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
