import 'dart:convert';

import 'package:ai_social_media_flutter/firebase_options.dart';
import 'package:ai_social_media_flutter/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<QuerySnapshot> feed;
  @override
  void initState() {
    feed = FirebaseFirestore.instance
        .collection('feed')
        .orderBy("date", descending: true)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {},
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: const Icon(
              Icons.add,
              color: Colors.red,
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          //bottom navigation bar on scaffold
          color: Colors.white,
          shape: const CircularNotchedRectangle(), //shape of notch

          child: Row(
            //children inside bottom appbar
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.message,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.feed,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.call_outlined,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Feed Explorer",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 12.0),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: feed,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text("Loading"),
                      );
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return PostCard(
                            date: data['date'],
                            imgUrl: "${data["imgUrl"]}",
                            content: "${data["content"]}",
                            username: "${data["username"]}",
                            userPic: "${data["userPic"]}",
                            numLikes: "${data["numLikes"]}",
                            numComments: "${data["numComments"]}");
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
