import 'package:blockchain_upi/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailedComm extends StatelessWidget {
  const DetailedComm({super.key, required this.data, required this.index});
  final data;
  final index;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: const Row(
        children: [
          TextField(),
        ],
      ),
      appBar: AppBar(
        title: Text(
          "Community",
          style: TextStyle(
            color: purple1,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.3,
                child: Hero(
                    tag: data["postUrl"],
                    child: Image.network(
                      data["postUrl"],
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Text(
                  data['title'],
                  style: TextStyle(
                      fontSize: size.width * 0.07, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Text(
                  data["descr"],
                  style: TextStyle(fontSize: size.width * 0.04),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  const Icon(Icons.arrow_upward),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Text(
                    data['ups'].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: size.width * 0.07,
                  ),
                  const Icon(Icons.arrow_downward),
                  const Spacer(
                    flex: 3,
                  ),
                  const Icon(Icons.message),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Text(
                    data['comments'].length.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  const Icon(Icons.share),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  const Text(
                    "Share",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Text(
                  "Comments",
                  style: TextStyle(
                      fontSize: size.width * 0.05, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Posts")
                      .doc("Posts")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List allComments =
                        snapshot.data!.data()!['posts'][index]['comments'];
                    if (allComments.isEmpty) {
                      return const Center(
                        child: Text("No Comments Yet."),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: allComments.length,
                        itemBuilder: (context, index) {
                          final comment = allComments[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                  CircleAvatar(
                                    radius: size.width * 0.045,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  Text(
                                    comment['by'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * 0.05),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.15,
                                    right: size.width * 0.06),
                                child: Text(comment['comment']),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                            ],
                          );
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
