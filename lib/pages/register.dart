import 'package:flutter/material.dart';
import 'theme.dart';

class RegisterPage extends StatefulWidget {
    const RegisterPage({super.key});

    @override
    State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _usernameController = TextEditingController();
    String? _selectedJabatan;
    bool _isPasswordVisible = false;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
            bottom: false,
            child: ListView(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            children: [
                Image.asset('assets/images/2968290.jpg',
                    height: 350, fit: BoxFit.fill),
                const SizedBox(height: 15),
                Text("Buat Akun Baru!", style: secondTextStyle),
                const SizedBox(height: 20),
                Text("Username", style: thirdTextStyle),
                const SizedBox(height: 5),
                TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    hintText: 'Masukkan Username',
                    hintStyle: fourthTextStyle.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: greyColor, width: 2.0),
                    ),
                ),
                ),
                const SizedBox(height: 10),
                Text("Email", style: thirdTextStyle),
                const SizedBox(height: 5),
                TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: 'Masukkan Email',
                    hintStyle: fourthTextStyle.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: greyColor, width: 2.0),
                    ),
                ),
                ),
                const SizedBox(height: 10),
                Text("Kata Sandi", style: thirdTextStyle),
                const SizedBox(height: 5),
                TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                    hintText: 'Masukkan Kata Sandi',
                    hintStyle: fourthTextStyle.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: greyColor, width: 2.0),
                    ),
                    suffixIcon: IconButton(
                    icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: greyColor,
                    ),
                    onPressed: () {
                        setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                        });
                    },
                    ),
                ),
                ),
                const SizedBox(height: 10),
                Text("Jabatan", style: thirdTextStyle),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                value: _selectedJabatan,
                items: ['Admin', 'Pegawai',].map((jabatan) {
                    return DropdownMenuItem(
                    value: jabatan,
                    child: Text(jabatan, style: thirdTextStyle),
                    );
                }).toList(),
                onChanged: (value) {
                    setState(() {
                    _selectedJabatan = value;
                    });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: greyColor, width: 2.0),
                    ),
                ),
                ),
                const SizedBox(height: 30),
                TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                    backgroundColor:
                        MaterialStateProperty.all(Color.fromARGB(255, 224, 13, 13)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    ),
                ),
                child: Text(
                    'Daftar',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.white),
                ),
                ),
            ],
            ),
        ),
        );
    }
    }
