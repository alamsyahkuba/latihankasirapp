import 'package:flutter/material.dart';
import 'theme.dart';

class Welcomepages extends StatefulWidget {
  const Welcomepages({super.key});

  @override
  State<Welcomepages> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Welcomepages> {
  @override
  Widget build(BuildContext context) {
    var dropdownValue;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            children: [
              Image.asset('assets/images/4860253.jpg',
                  height: 250, fit: BoxFit.fill),
              SizedBox(
                height: 15,
              ),
              Text(
                "Selamat Datang!",
                style: secondTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Email atau Username",
                style: thirdTextStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 40,
                width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                child: ElevatedButton(
                  onPressed: () {},
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Masukkan Email atau Username',
                      hintStyle: thirdTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor, // Warna background tombol
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Radius sudut tombol
                    ),
                    side: BorderSide(
                      color: greyColor, // Warna garis di sekitar tombol
                      width: 2.0, // Ketebalan garis
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Kata Sandi",
                style: thirdTextStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 40,
                width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                child: ElevatedButton(
                  onPressed: () {},
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Masukkan Kata Sandi',
                      hintStyle: thirdTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor, // Warna background tombol
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Radius sudut tombol
                    ),
                    side: BorderSide(
                      color: greyColor, // Warna garis di sekitar tombol
                      width: 2.0, // Ketebalan garis
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Masuk Sebagai",
                style: thirdTextStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  height: 40,
                  width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: greyColor,
                      width: 2.0,
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownColor: whiteColor,
                    style: thirdTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
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
                  )),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: WidgetStateProperty.resolveWith((states) {
                    return const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15);
                  }),
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    return const Color.fromARGB(255, 224, 13, 13);
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    return Colors.white;
                  }),
                  shape: WidgetStateProperty.resolveWith((states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    );
                  }),
                ),
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 20  ,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                ),),
              ),
            ]),
      ),
    );
  }
}
