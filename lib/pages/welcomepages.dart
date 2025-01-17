import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/homeadmin.dart';
import 'theme.dart';
import 'package:latihankasirapp/pages/homeadmin.dart';

class Welcomepages extends StatefulWidget {
  const Welcomepages({super.key});

  @override
  State<Welcomepages> createState() => _WelcomepagesState();
}

class _WelcomepagesState extends State<Welcomepages> {
  var dropdownValue;
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
            Image.asset('assets/images/4860253.jpg',
                height: 250, fit: BoxFit.fill),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Selamat Datang!",
              style: secondTextStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Email atau Username",
              style: thirdTextStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Masukkan Email atau Username',
                hintStyle: fourthTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: greyColor, width: 2.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Kata Sandi",
              style: thirdTextStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              obscureText: !_isPasswordVisible, //field memasukkan sandi dengan biar bisa dilihat - disensor
              decoration: InputDecoration(
                hintText: 'Masukkan Kata Sandi',
                hintStyle: fourthTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: greyColor, width: 2.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off, //logika yang mengubah sandi bisa dilihat atau tidak
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
            const SizedBox(
              height: 10,
            ),
            Text(
              "Masuk Sebagai",
              style: thirdTextStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: greyColor,
                  width: 2.0,
                ),
              ),
              child: DropdownButton<String>( //dropdown admin - petugas
                value: dropdownValue,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                dropdownColor: whiteColor,
                style: thirdTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                underline: const SizedBox(),
                items: ['Admin', 'Petugas']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                if (dropdownValue == 'Admin'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeAdmin()),
                  );
                }
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith((states) {
                  return const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15);
                }),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  return const Color.fromARGB(255, 224, 13, 13);
                }),
                foregroundColor: MaterialStateProperty.resolveWith((states) {
                  return Colors.white;
                }),
                shape: MaterialStateProperty.resolveWith((states) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  );
                }),
              ),
              child: Text(
                'Masuk',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Lupa password?",
              textAlign: TextAlign.right,
              style: thirdTextStyle.copyWith(
                fontSize: 10,
                
              )
                

            ),
          ],
        ),
      ),
    );
  }
}
