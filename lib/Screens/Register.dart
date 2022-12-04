import 'package:vigenesia/Constant/const.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dio/dio.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Ganti Base URL

  String baseurl = url;

  Future postRegister(
      String nama, String profesi, String email, String password) async {
    var dio = Dio();

    dynamic data = {
      "nama": nama,
      "profesi": profesi,
      "email": email,
      "password": password
    };

    try {
      final response = await dio.post("$baseurl/api/registrasi",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));

      print("Respon -> ${response.data} + ${response.statusCode}");

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print("Failed To Load $e");
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController profesiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            // <-- Berfungsi Untuk  Bisa Scroll
            child: SafeArea(
                // < -- Biar Gak Keluar Area Screen HP
                child: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(width: 10.0, color: Colors.lightBlue.shade900),
              bottom: BorderSide(width: 10.0, color: Colors.lightBlue.shade900),
              right: BorderSide(width: 10.0, color: Colors.lightBlue.shade600),
              left: BorderSide(width: 10.0, color: Colors.lightBlue.shade600))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Image.asset('assets/images/registration.png',
            height: 150,
            // color: Color.fromARGB(255, 15, 147, 59),
            opacity: const AlwaysStoppedAnimation<double>(1)),
        SizedBox(height: 10),
        Center(
          child: Form(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                children: [
                  FormBuilderTextField(
                      name: "name",
                      controller: nameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueAccent)),
                        //border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.people_alt_outlined),
                        labelText: "Name",
                        labelStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 15,
                            color: Colors.blueGrey),
                      ),
                      style: TextStyle(fontFamily: 'Nunito', fontSize: 13)),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                      name: "profesi",
                      controller: profesiController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueAccent)),
                        //border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.work_history_outlined),
                        labelText: "Profession",
                        labelStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 15,
                            color: Colors.blueGrey),
                      ),
                      style: TextStyle(fontFamily: 'Nunito', fontSize: 13)),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                      name: "email",
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueAccent)),
                        //border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: "Email",
                        labelStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 15,
                            color: Colors.blueGrey),
                      ),
                      style: TextStyle(fontFamily: 'Nunito', fontSize: 13)),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                      obscureText:
                          true, // <-- Buat bikin setiap inputan jadi bintang " * "
                      name: "password",
                      controller: passwordController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueAccent)),
                        //border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.password_outlined),
                        labelText: "Password",
                        labelStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 15,
                            color: Colors.blueGrey),
                      ),
                      style: TextStyle(fontFamily: 'Nunito', fontSize: 13)),
                  SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () async {
                          await postRegister(
                                  nameController.text,
                                  profesiController.text,
                                  emailController.text,
                                  passwordController.text)
                              .then((value) => {
                                    if (value != null)
                                      {
                                        setState(() {
                                          Navigator.pop(context);
                                          Flushbar(
                                            message: "Berhasil Registrasi",
                                            duration: Duration(seconds: 2),
                                            backgroundColor: Colors.greenAccent,
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                          ).show(context);
                                        })
                                      }
                                    else if (value == null)
                                      {
                                        Flushbar(
                                          message:
                                              "Check Your Field Before Register",
                                          duration: Duration(seconds: 5),
                                          backgroundColor: Colors.redAccent,
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                        ).show(context)
                                      }
                                  });
                        },
                        child: Text("Create")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    ))));
  }
}
