import 'package:flutter/material.dart';

class ProfilPelangganPage extends StatefulWidget {
  @override
  _ProfilPelangganPageState createState() => _ProfilPelangganPageState();
}

class _ProfilPelangganPageState extends State<ProfilPelangganPage> {
  // Daftar pelanggan yang ditampilkan
  List<String> pelangganList = ['Pelanggan 1', 'Pelanggan 2', 'Pelanggan 3'];
  
  // Controller untuk mengelola input teks dari pengguna
  TextEditingController pelangganController = TextEditingController();

  // Fungsi untuk menambah pelanggan baru
  void _addPelanggan() {
    // Cek apakah input nama pelanggan tidak kosong
    if (pelangganController.text.isNotEmpty) {
      setState(() {
        // Menambah pelanggan baru ke dalam list
        pelangganList.add(pelangganController.text);
      });
      // Mengosongkan input setelah menambah pelanggan
      pelangganController.clear();
    }
  }

  // Fungsi untuk mengedit nama pelanggan yang sudah ada
  void _editPelanggan(int index) {
    // Mengisi field input dengan nama pelanggan yang akan diedit
    pelangganController.text = pelangganList[index];
    
    // Menampilkan dialog untuk mengedit nama pelanggan
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Pelanggan'), // Judul dialog
          content: TextField(
            controller: pelangganController, // Menghubungkan dengan controller
            decoration: InputDecoration(hintText: 'Nama Pelanggan'), // Placeholder
          ),
          actions: [
            // Tombol untuk menyimpan perubahan
            TextButton(
              onPressed: () {
                setState(() {
                  // Mengupdate nama pelanggan pada list
                  pelangganList[index] = pelangganController.text;
                });
                // Menutup dialog setelah perubahan disimpan
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
            // Tombol untuk membatalkan edit
            TextButton(
              onPressed: () {
                // Menutup dialog dan membersihkan input
                Navigator.pop(context);
                pelangganController.clear();
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menghapus pelanggan dari daftar
  void _deletePelanggan(int index) {
    setState(() {
      // Menghapus pelanggan pada index yang ditentukan
      pelangganList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pelanggan'), // Judul di bagian atas aplikasi
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Memberikan padding di sekitar tampilan
        child: Column(
          children: [
            // TextField untuk memasukkan nama pelanggan baru
            TextField(
              controller: pelangganController, // Menghubungkan dengan controller
              decoration: InputDecoration(
                labelText: 'Nama Pelanggan', // Label untuk input
                border: OutlineInputBorder(), // Border di sekitar input
              ),
            ),
            SizedBox(height: 10), // Memberikan jarak antara elemen
            ElevatedButton(
              onPressed: _addPelanggan, // Menambah pelanggan saat tombol ditekan
              child: Text('Tambah Pelanggan'), // Teks pada tombol
            ),
            SizedBox(height: 10), // Memberikan jarak lagi
            Expanded(
              child: ListView.builder(
                itemCount: pelangganList.length, // Jumlah item berdasarkan jumlah pelanggan
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5), // Memberikan margin pada card
                    child: ListTile(
                      leading: Icon(Icons.person), // Ikon orang di sebelah kiri
                      title: Text(pelangganList[index]), // Nama pelanggan
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min, // Menyusun ikon di sebelah kanan
                        children: [
                          // Ikon untuk mengedit pelanggan
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editPelanggan(index),
                          ),
                          // Ikon untuk menghapus pelanggan
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deletePelanggan(index),
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
      ),
    );
  }
}
