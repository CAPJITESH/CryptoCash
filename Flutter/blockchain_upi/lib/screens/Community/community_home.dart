import 'package:blockchain_upi/screens/community/detailedcomm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommunityHome extends StatelessWidget {
  const CommunityHome({super.key});

  /*List<Map<String,dynamic>> data = [
    {
      "time":DateTime(2000),
      "pfp":"",
      "by":"Zeeshan",
      "comments":[
        {
          "by":"Zeeshan",
          "time": DateTime(2002),
          "message":"This is Comment",
          "senderPicUrl": "",
          "replies":[
            {
              "by":"User1",
              "reply":"Reply Message1",
            },
            {
              "by":"User2",
              "reply":"Reply Message2",
            },
            {
              "by":"User3",
              "reply":"Reply Message3",
            },
          ],
        },
        {
          "by":"Zeeshan",
          "time": DateTime(2002),
          "message":"This is Comment",
          "senderPicUrl": "",
          "replies":[
            {
              "by":"User1",
              "reply":"Reply Message1",
            },
            {
              "by":"User2",
              "reply":"Reply Message2",
            },
            {
              "by":"User3",
              "reply":"Reply Message3",
            },
          ],
        },
      ],
      "title":"Post Title",
      "descr":"This is the Description of Post",
      "ups":2,
      "downs":2,
      "postUrl":"https://m.foolcdn.com/media/dubs/images/how-blockchain-works-infographic.width-880.png"
    },
    {
      "time":DateTime(2000),
      "pfp":"",
      "by":"Zeeshan",
      "comments":[
        {
          "by":"Zeeshan",
          "time": DateTime(2002),
          "message":"This is Comment",
          "senderPicUrl": "",
          "replies":[
            {
              "by":"User1",
              "reply":"Reply Message1",
            },
            {
              "by":"User2",
              "reply":"Reply Message2",
            },
            {
              "by":"User3",
              "reply":"Reply Message3",
            },
          ],
        },
        {
          "by":"Zeeshan",
          "time": DateTime(2002),
          "message":"This is Comment",
          "senderPicUrl": "",
          "replies":[
            {
              "by":"User1",
              "reply":"Reply Message1",
            },
            {
              "by":"User2",
              "reply":"Reply Message2",
            },
            {
              "by":"User3",
              "reply":"Reply Message3",
            },
          ],
        },
      ],
      "title":"Post Title",
      "descr":"This is the Description of Post",
      "ups":2,
      "downs":2,
      "postUrl":"https://m.foolcdn.com/media/dubs/images/how-blockchain-works-infographic.width-880.png"
    },
    {
      "time":DateTime(2000),
      "pfp":"",
      "by":"Zeeshan",
      "comments":[
        {
          "by":"Zeeshan",
          "time": DateTime(2002),
          "message":"This is Comment",
          "senderPicUrl": "",
          "replies":[
            {
              "by":"User1",
              "reply":"Reply Message1",
            },
            {
              "by":"User2",
              "reply":"Reply Message2",
            },
            {
              "by":"User3",
              "reply":"Reply Message3",
            },
          ],
        },
        {
          "by":"Zeeshan",
          "time": DateTime(2002),
          "message":"This is Comment",
          "senderPicUrl": "",
          "replies":[
            {
              "by":"User1",
              "reply":"Reply Message1",
            },
            {
              "by":"User2",
              "reply":"Reply Message2",
            },
            {
              "by":"User3",
              "reply":"Reply Message3",
            },
          ],
        },
      ],
      "title":"Post Title",
      "descr":"This is the Description of Post",
      "ups":2,
      "downs":2,
      "postUrl":"https://m.foolcdn.com/media/dubs/images/how-blockchain-works-infographic.width-880.png"
    },
  ];*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Community"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Posts")
                .doc("Posts")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final data = snapshot.data!.data()!["posts"];
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final postData = data[index];
                    Timestamp t = postData['time'];
                    return InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailedComm(
                              data: postData,
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.04,
                              ),
                              CircleAvatar(
                                radius: size.width * 0.055,
                                child: postData['pfp'] == ""
                                    ? const Icon(Icons.person)
                                    : Image.network(
                                        postData['pfp'],
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              SizedBox(
                                width: size.width * 0.035,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    postData['title'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "Posted by ${postData['by']}",
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                timeago.format(postData['time'].toDate()),
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.3,
                            child: postData['postUrl'] == ''
                                ? const Placeholder()
                                : Hero(
                                    tag: postData["postUrl"],
                                    child: Image.network(
                                      postData['postUrl'],
                                      fit: BoxFit.cover,
                                    )),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03),
                            child: Text(
                              postData["descr"],
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: size.width * 0.04,
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: () async {
                                  final get = await FirebaseFirestore.instance
                                      .collection("Posts")
                                      .doc("Posts")
                                      .get();
                                  List posts = get.data()!["posts"];
                                  final post = posts[index];
                                  post['ups'] += 1;
                                  posts.removeAt(index);
                                  posts.insert(index, post);
                                  await FirebaseFirestore.instance
                                      .collection("Posts")
                                      .doc("Posts")
                                      .update({"posts": posts});
                                },
                                child: const Icon(Icons.arrow_upward),
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Text(
                                postData['ups'].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: () async {
                                  final get = await FirebaseFirestore.instance
                                      .collection("Posts")
                                      .doc("Posts")
                                      .get();
                                  List posts = get.data()!["posts"];
                                  final post = posts[index];
                                  if (post['ups'] == 0) {
                                    return;
                                  }
                                  post['ups'] -= 1;
                                  posts.removeAt(index);
                                  posts.insert(index, post);
                                  await FirebaseFirestore.instance
                                      .collection("Posts")
                                      .doc("Posts")
                                      .update({"posts": posts});
                                },
                                child: const Icon(Icons.arrow_downward),
                              ),
                              SizedBox(
                                width: size.width * 0.06,
                              ),
                              const Icon(Icons.message),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Text(
                                postData['comments'].length.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: size.width * 0.06,
                              ),
                              const Icon(Icons.share),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              const Text(
                                "Share",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: size.width * 0.04,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          const Divider(),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                        ],
                      ),
                    );
                  });
            }));
  }
}
