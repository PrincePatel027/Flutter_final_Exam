import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseDbHelper {
  FirebaseDbHelper._();
  static FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addData(
      {required String name,
      required String time,
      required BuildContext context}) async {
    QuerySnapshot<Map<String, dynamic>> data =
        await firestore.collection("Tasks").get();

    List<QueryDocumentSnapshot> dataList = data.docs;

    // ignore: collection_methods_unrelated_type
    if (dataList.contains({
      "name": name,
      "time": time,
    })) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Already Task Avialable..."),
            backgroundColor: Colors.green,
          ),
        );
    } else {
      await firestore.collection("Tasks").doc().set({
        "name": name,
        "time": time,
      });
    }
  }

  fetchData() {
    Stream<QuerySnapshot<Map<String, dynamic>>> data =
        firestore.collection("Tasks").snapshots();

    return data;
  }
}
