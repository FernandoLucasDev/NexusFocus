import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus_focus/utils/colors.dart';
import 'package:nexus_focus/widgets/custom_buttom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<int> _SendForm() async {
    int status = 0;
    final String username;
    final String useremail;
    final int userid;

    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      var request = http.Request('POST', Uri.parse('http://10.0.2.2:8080'));

      request.bodyFields = {
        'route': 'login',
        'email': email,
        'pass': password
      };

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        status = 200;
      } else {
        status = response.statusCode;
      }

    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1.0,
        child: Container(
          width: 260,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 25.0),
                  child: Image.asset('assets/img/logo.png', height: 120),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Nexus',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Focus',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 30.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Fazer Login',
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: 360,
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, insira seu email';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            width: 360,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Senha",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, insira sua senha';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
                CustomButton(
                    text: "Fazer Login",
                    background: primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      // Navigator.pushNamed(context, '/routines');
                      if(_formKey.currentState!.validate()){
                        int res = await _SendForm();
                        if(res != 200){
                          showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('OOOPS!'),
                                  content: Text("Houve um problema. Verifique seu email ou senha!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              });
                        } else {
                          Navigator.pushNamed(context, '/routines');
                        }
                      }
                    }),
                const Text('Ou'),
                CustomButton(
                    text: "Cadastrar",
                    background: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    })
              ],
            ),
          )
        ),
      ),
    );
  }
}