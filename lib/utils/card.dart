import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus_focus/utils/colors.dart';

class CardRoutine extends StatelessWidget {
  final int id;
  final String title;
  final String postText;
  final String date;

  CardRoutine({required this.id, required this.title, required this.postText, required this.date});

  String getHour(String data) {
    DateTime dateTime = DateTime.parse(data);
    String hm = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return hm;
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Descrição:',
                      style: TextStyle(
                        fontWeight: FontWeight.w200
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      postText != '' ? postText : 'Sem descrição',
                    )
                  ],
                )
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: InkWell(
                onTap: () {
                  _showModal(context);
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 50,
                    minWidth: double.infinity
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 190,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              Text(
                                getHour(date),
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          )
                        )
                    ),
                  ),
                ),
              ),
            )));
  }
}
