import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nexus_focus/utils/colors.dart';
import 'dart:convert';

import 'package:nexus_focus/widgets/custom_buttom.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
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
      String name = _nameController.text;
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      var request = http.Request('POST', Uri.parse('http://localhost:8080'));

      request.bodyFields = {
        'route': 'create',
        'name': name,
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
                      'Cadastrar',
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
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: "Nome",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, insira seu nome';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 15.0),
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
                      text: "Cadastrar",
                      background: primaryColor,
                      textColor: Colors.white,
                      onPressed: () async {
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
                                          Navigator.pushNamed(context, '/register');
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            Navigator.pushNamed(context, '/home');
                          }
                        }
                      }),
                  const Text('Ou'),
                  CustomButton(
                      text: "Fazer Login",
                      background: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      })
                ],
              ),
            )
        ),
      ),
    );
  }
}