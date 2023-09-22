import 'package:flutter/material.dart';
import 'package:nexus_focus/utils/card.dart';
import 'package:nexus_focus/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nexus_focus/widgets/custom_buttom.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({Key? key}) : super(key: key);

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {

  Future<List<Map<String, dynamic>>> getRoutines() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    var request = http.Request('POST', Uri.parse('http://10.0.2.2:8080'));

    request.bodyFields = {
      'route': 'routine_get',
      'id':'2'
    };

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      List<dynamic> jsonData = json.decode(responseBody);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Erro na requisição. Código de status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1.0,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Olá!',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 30.0
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Sua rotina de hoje:',
                  style: TextStyle(
                      fontSize: 20.0
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: getRoutines(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Erro: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    List<Map<String, dynamic>> data = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        print('entrou no builder');
                        String title = data[index]['title'];
                        String text = data[index]['description_text'] != null ? data[index]['description_text'] : '';
                        String date = data[index]['date_time'];
                        int id = 1;
                        return CardRoutine(id: id, title: title, postText: text, date: date);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Nenhum dado encontrado.'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}