import 'package:advance_flutter_exam/helper/firebase_db_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseFetchPage extends StatefulWidget {
  const FirebaseFetchPage({super.key});

  @override
  State<FirebaseFetchPage> createState() => _FirebaseFetchPageState();
}

class _FirebaseFetchPageState extends State<FirebaseFetchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Fetch'),
      ),
      body: StreamBuilder(
        stream: FirebaseDbHelper.firebaseDbHelper.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? data =
                snapshot.data as QuerySnapshot<Map<String, dynamic>>;

            List<QueryDocumentSnapshot> finalData = data.docs;

            return ListView.builder(
              itemCount: finalData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(),
                  title: Text(finalData[index]['name']),
                  subtitle: Text(finalData[index]['time']),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
