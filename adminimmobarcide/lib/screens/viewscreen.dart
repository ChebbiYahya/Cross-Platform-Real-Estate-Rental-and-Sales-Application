import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("imageURL").snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: ((context, index) {
                          return Container(
                              margin: EdgeInsets.all(5),
                              child: /* Image.network(
                                snapshot.data!.docs[index].get("url"),
                                fit: BoxFit.cover),*/
                                  FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: snapshot.data!.docs[index].get("url"),
                                fit: BoxFit.cover,
                              ));
                        })),
                  );
          }),
    );
  }
}
