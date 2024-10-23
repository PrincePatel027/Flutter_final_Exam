// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:advance_flutter_exam/helper/db_helper.dart';
import 'package:advance_flutter_exam/helper/firebase_db_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int initialTime = 9;
  int temp = 9;
  bool isButtonDisable = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController conto = TextEditingController();

  List fields = [
    {
      "controller": TextEditingController(),
      "time": "9 PM",
    }
  ];

  @override
  void initState() {
    super.initState();
    initializeDB();
  }

  initializeDB() async {
    await DbHelper.dbHelper.initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'fetch');
            },
            child: const Text("Fetch LD"),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'firebase');
            },
            child: const Text("Fetch FFD"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    fields.length,
                    (index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: MyFiled(index),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: isButtonDisable
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                if (initialTime < 12) {
                  initialTime++;
                  temp++;
                  log(temp.toString());
                } else {
                  initialTime -= 12;
                  initialTime++;
                  temp++;
                }

                if (temp >= 19) {
                  isButtonDisable = true;
                  log(isButtonDisable.toString());
                  setState(() {});
                }

                fields.add({
                  "controller": TextEditingController(),
                  "time": (temp >= 12) ? "$initialTime AM" : "$initialTime PM",
                });

                // fields.length;

                setState(() {});
              },
              child: const Icon(Icons.add),
            ),
    );
  }

  // ignore: non_constant_identifier_names
  TextFormField MyFiled(int index) {
    return TextFormField(
      controller: fields[index]['controller'],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please Fill ${fields[index]['time']} & Continue";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${fields[index]['time']}",
        suffixIcon: IconButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              int? res = await DbHelper.dbHelper.insertData(
                  time: fields[index]['time'],
                  title: fields[index]['controller'].text,
                  context: context);

              await FirebaseDbHelper.firebaseDbHelper.addData(
                name: fields[index]['controller'].text,
                time: fields[index]['time'],
                context: context,
              );

              if (res != null && res >= 1) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text("Data Inserted Successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
              } else {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text("Data Insertion Failed..."),
                      backgroundColor: Colors.red,
                    ),
                  );
              }
            }
          },
          icon: const Icon(Icons.save),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue[200]!,
            width: 3,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[200]!,
            width: 3,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue[200]!,
            width: 3,
          ),
        ),
      ),
    );
  }
}
