import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/screens/courses/quiz/quiz.dart';
import 'package:blockchain_upi/screens/courses/yt_player.dart';
import 'package:flutter/material.dart';

class BNBCourses extends StatelessWidget
{
  final introTopics1 = [
    {
      'videoUrl':"https://youtu.be/mkh3PNbf-08",
      "topic":"Understanding Basics of Blockchain",
    },
    {
      'videoUrl':"https://youtu.be/ZunsbfbCs1c",
      "topic":"Use Trust Wallet with BNB Smart Chain",
    },
  ];
  final introTopics2 = [
    {
      'videoUrl':"https://youtu.be/tZz4-c8tDa4",
      "topic":"Solidity Course | Introduction",
    },
    {
      'videoUrl':"https://youtu.be/BYyCP0lohX8",
      "topic":"Call and Interacting Contracts",
    },
  ];

  List<Map<String, dynamic>> questions = [
    {
      'question':
      'What is the primary purpose of Binance Coin (BNB)?',
      'answers': [
        {'answerText': 'Decentralized storage', 'score': false},
        {'answerText': 'Smart contract execution', 'score': false},
        {'answerText': 'Payment for transaction fees on Binance', 'score': true},
        {'answerText': 'Identity verification', 'score': false},
      ],
    },
    {
      'question':
      'On which blockchain was Binance Coin originally launched?',
      'answers': [
        {'answerText': 'Ethereum ', 'score': true},
        {'answerText': 'Bitcoin ', 'score': false},
        {'answerText': 'Binance Smart Chain', 'score': false},
        {'answerText': 'Cardano', 'score': false},
      ],
    },
    {
      'question': 'What consensus mechanism does Binance Smart Chain (BSC) use?',
      'answers': [
        {'answerText': 'Proof of Work (PoW)', 'score': false},
        {
          'answerText':
          'Proof of Stake (PoS)',
          'score': false
        },
        {'answerText': 'Delegated Proof of Stake (DPoS)', 'score': true},
        {'answerText': 'Proof of Authority (PoA).', 'score': false},
      ],
    },
    {
      'question': 'Who is the founder and CEO of Binance, the company behind Binance Coin (BNB)?',
      'answers': [
        {'answerText': 'Vitalik Buterin', 'score': false},
        {'answerText': 'Charles Hoskinson', 'score': false},
        {'answerText': 'Changpeng Zhao (CZ) ', 'score': true},
        {'answerText': 'Gavin Wood', 'score': false},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("BNB Courses"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height*0.2,
              child: Hero(tag: "bnb",child: Image.network("https://d14b9ctw0m6fid.cloudfront.net/ugblog/wp-content/uploads/2020/09/shutterstock_435613807.jpg",fit: BoxFit.contain,)),
            ),
            SizedBox(
              height: size.height*0.02,
            ),
            Card(
              child: ExpansionTile(
                title: Row(
                  children: [
                    SizedBox(width: size.width*0.01,),
                    SizedBox(
                      width: size.width*0.4,
                      height: size.height*0.145,
                      child: Image.network("https://risein-prod.s3.eu-central-1.amazonaws.com/courses/blockchain-basics.png",fit: BoxFit.cover,),
                    ),
                    SizedBox(width: size.width*0.03,),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text("Build on Solana",maxLines: 2,style: TextStyle(fontWeight: FontWeight.w600),),
                            Text("1 Section ${introTopics1.length} Tasks",style: TextStyle(fontSize: size.width*0.035),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width*0.03),
                    child: Text("We will start with the fundamentals of blockchain technology, and understand what a blockchain is and how it works."),
                  ),
                  ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: introTopics1.length,itemBuilder: (context,index){
                    return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> YouTubePlayer(videoUrl: introTopics1[index]['videoUrl'].toString(), videoTitle:  introTopics1[index]['topic'].toString(), videoDescription: "")));
                      },
                      title: Text(introTopics1[index]['topic'].toString()),
                      trailing: Icon(Icons.picture_as_pdf),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: (){}, child: Text("Start Course"),style: ElevatedButton.styleFrom(backgroundColor: purple1,foregroundColor: Colors.white),),
                      SizedBox(width: size.width*0.03,),
                    ],
                  ),
                  SizedBox(height: size.height*0.01,),
                ],
              ),
            ),
            Card(
              child: ExpansionTile(
                title: Row(
                  children: [
                    SizedBox(width: size.width*0.01,),
                    SizedBox(
                      width: size.width*0.4,
                      height: size.height*0.145,
                      child: Image.network("https://risein-prod.s3.eu-central-1.amazonaws.com/courses/transactions-and-bitcoin.png",fit: BoxFit.cover,),
                    ),
                    SizedBox(width: size.width*0.03,),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text("Build on BNB Chain - Course 1 | BNB Chain Fundamentals",maxLines: 2,style: TextStyle(fontWeight: FontWeight.w600),),
                            Text("1 Section ${introTopics1.length} Tasks",style: TextStyle(fontSize: size.width*0.035),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width*0.03),
                    child: Text("We will start with Satoshi Nakamoto’s introduction to bitcoin and understand how transactions work on a blockchain."),
                  ),
                  ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: introTopics2.length,itemBuilder: (context,index){
                    return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> YouTubePlayer(videoUrl: introTopics2[index]['videoUrl'].toString(), videoTitle:  introTopics2[index]['topic'].toString(), videoDescription: "")));
                      },
                      title: Text(introTopics2[index]['topic'].toString()),
                      trailing: Icon(Icons.picture_as_pdf),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: (){}, child: Text("Start Course"),style: ElevatedButton.styleFrom(backgroundColor: purple1,foregroundColor: Colors.white),),
                      SizedBox(width: size.width*0.03,),
                    ],
                  ),
                  SizedBox(height: size.height*0.01,),
                ],
              ),
            ),

            SizedBox(
              height: size.height*0.02,
            ),

            SizedBox(
              height: size.height*0.06,
              width: size.width*0.85,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Quiz(questions: questions)));
                },
                child: Text("Start Quiz"),
                style: ElevatedButton.styleFrom(backgroundColor: purple1,foregroundColor: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

}