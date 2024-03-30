import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/screens/courses/quiz/quiz.dart';
import 'package:blockchain_upi/screens/courses/yt_player.dart';
import 'package:flutter/material.dart';

class TechCourses extends StatelessWidget {
  final introTopics1 = [
    {
      'videoUrl': "https://youtu.be/UWEOVVtCgso",
      "topic": "Symmetric & Asymmetric Encryption",
    },
    {
      'videoUrl': "https://youtu.be/0yzS9ywSnpY",
      "topic": "Blockchain Workflow",
    },
  ];
  final introTopics2 = [
    {
      'videoUrl': "https://youtu.be/eiTHB9aarWs",
      "topic": "Remix IDE",
    },
    {
      'videoUrl': "https://youtu.be/BYyCP0lohX8",
      "topic": "Call and Interacting Contracts",
    },
  ];

  List<Map<String, dynamic>> questions = [
    {
      'question':
          'Who was the first individual to coin the term ‘semantic web’?',
      'answers': [
        {'answerText': 'Scott Jackson', 'score': false},
        {'answerText': 'Larry Page', 'score': false},
        {'answerText': 'Tim Berners-Lee', 'score': true},
        {'answerText': 'Fiona Martin', 'score': false},
      ],
    },
    {
      'question':
          'Which characteristic is not applicable distinctively for web3?',
      'answers': [
        {'answerText': 'Decentralization ', 'score': false},
        {'answerText': 'Contextual communication ', 'score': false},
        {'answerText': 'Data Ownership', 'score': false},
        {'answerText': 'Speed', 'score': true},
      ],
    },
    {
      'question': 'How is web3 different from web2?',
      'answers': [
        {'answerText': 'Web3 was created as the internet for big tech corporations.', 'score': false},
        {
          'answerText':
              'Web3 emphasizes allowing control and ownership over data.',
          'score': true
        },
        {'answerText': 'The objectives of web3 focus on introducing interactive content to the internet.', 'score': false},
        {'answerText': 'Web3 delivers a better user interface than web2.', 'score': false},
      ],
    },
    {
      'question': 'What is the advantage of web3 over its predecessors?',
      'answers': [
        {'answerText': 'Web3 is built for blockchain technology.', 'score': false},
        {'answerText': 'Web3 can offer flexibility for generating your own content. ', 'score': false},
        {'answerText': 'The applications of web3 would focus on personalization, intelligent search, and semantic web capabilities. ', 'score': false},
        {'answerText': 'None of the above.', 'score': true},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Technical Courses"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.2,
              child: Hero(
                  tag: "tech",
                  child: Image.network(
                    "https://d14b9ctw0m6fid.cloudfront.net/ugblog/wp-content/uploads/2020/09/shutterstock_435613807.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              height: size.height*0.02,
            ),
            Card(
              child: ExpansionTile(
                title: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.145,
                      child: Image.network(
                        "https://risein-prod.s3.eu-central-1.amazonaws.com/courses/blockchain-basics.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              "Build on Solana",
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("1 Section ${introTopics1.length} Tasks",style: TextStyle(fontSize: size.width*0.035),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.03),
                    child: Text(
                        "We will start with the fundamentals of blockchain technology, and understand what a blockchain is and how it works."),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: introTopics1.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => YouTubePlayer(
                                        videoUrl: introTopics1[index]
                                                ['videoUrl']
                                            .toString(),
                                        videoTitle: introTopics1[index]['topic']
                                            .toString(),
                                        videoDescription: "")));
                          },
                          title: Text(introTopics1[index]['topic'].toString()),
                          trailing: Icon(Icons.picture_as_pdf),
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Start Course"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: purple1,
                            foregroundColor: Colors.white),
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
            ),
            Card(
              child: ExpansionTile(
                title: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.145,
                      child: Image.network(
                        "https://risein-prod.s3.eu-central-1.amazonaws.com/courses/transactions-and-bitcoin.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              "Build on BNB Chain - Course 1 | BNB Chain Fundamentals",
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("1 Section ${introTopics1.length} Tasks",style: TextStyle(fontSize: size.width*0.035),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.03),
                    child: Text(
                        "We will start with Satoshi Nakamoto’s introduction to bitcoin and understand how transactions work on a blockchain."),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: introTopics2.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => YouTubePlayer(
                                        videoUrl: introTopics2[index]
                                                ['videoUrl']
                                            .toString(),
                                        videoTitle: introTopics2[index]['topic']
                                            .toString(),
                                        videoDescription: "")));
                          },
                          title: Text(introTopics2[index]['topic'].toString()),
                          trailing: Icon(Icons.picture_as_pdf),
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Start Course"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: purple1,
                            foregroundColor: Colors.white),
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.85,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Quiz(questions: questions)));
                },
                child: Text("Start Quiz"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: purple1, foregroundColor: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
