import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/theme.dart';

class Pelanggan {
  String nama;
  String alamat;
  String kontak;

  Pelanggan({required this.nama, required this.alamat, required this.kontak});
}

class PelangganPage extends StatefulWidget {
  @override
  _PelangganPageState createState() => _PelangganPageState();
}

class _PelangganPageState extends State<PelangganPage> {
  List<Pelanggan> pelangganList = [];
  String searchQuery = '';

  void _tambahPelanggan() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController namaController = TextEditingController();
        TextEditingController alamatController = TextEditingController();
        TextEditingController kontakController = TextEditingController();
        
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text("Tambah Pelanggan", style: TextStyle(color: secondaryColor)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: InputDecoration(labelText: "Nama Pelanggan", labelStyle: TextStyle(color: secondaryColor)),
              ),
              TextField(
                controller: alamatController,
                decoration: InputDecoration(labelText: "Alamat", labelStyle: TextStyle(color: secondaryColor)),
              ),
              TextField(
                controller: kontakController,
                decoration: InputDecoration(labelText: "No. Telepon", labelStyle: TextStyle(color: secondaryColor)),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Batal", style: TextStyle(color: secondaryColor)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  pelangganList.add(Pelanggan(
                    nama: namaController.text,
                    alamat: alamatController.text,
                    kontak: kontakController.text,
                  ));
                });
                Navigator.pop(context);
              },
              child: Text("Simpan", style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor)),
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Kasir Pintar",
            style: secondTextStyle.copyWith(fontSize: 25, fontWeight: FontWeight.bold, color: secondaryColor)),
            Icon(Icons.exit_to_app, size: 30, color: secondaryColor),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Ketik untuk cari...",
                prefixIcon: Icon(Icons.search, color: secondaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Daftar Pelanggan",
                  style: sixTextStyle.copyWith(
                    fontSize: 18,
                    color: secondaryColor,
                  )),
                IconButton(
                  icon: Icon(Icons.add_circle, color: secondaryColor, size: 28),
                  onPressed: _tambahPelanggan,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pelangganList.length,
              itemBuilder: (context, index) {
                final pelanggan = pelangganList[index];
                if (!pelanggan.nama.toLowerCase().contains(searchQuery)) {
                  return SizedBox.shrink();
                }
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      pelanggan.nama,
                      style: sevenTextStyle.copyWith(fontWeight: FontWeight.bold, color: secondaryColor),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Alamat: ${pelanggan.alamat}", style: sevenTextStyle.copyWith(color: secondaryColor)),
                        Text("No. Telepon: ${pelanggan.kontak}", style: sevenTextStyle.copyWith(color: secondaryColor)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue[900]),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red[900]),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
