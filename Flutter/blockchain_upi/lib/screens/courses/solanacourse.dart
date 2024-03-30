import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/screens/courses/quiz/quiz.dart';
import 'package:blockchain_upi/screens/courses/yt_player.dart';
import 'package:flutter/material.dart';

class SolanaCourses extends StatelessWidget
{
  final introTopics1 = [
    {
      'videoUrl':"https://youtu.be/iXlxLZBzVHI",
      "topic":"Solana Introduction",
    },
    {
      'videoUrl':"https://youtu.be/oTl8AwUkM-8",
      "topic":"Review VI - Frontend",
    },
  ];

  List<Map<String, dynamic>> questions = [
    {
      'question': 'What consensus mechanism does Solana primarily use?',
      'answers': [
        {'answerText': 'Proof of Work (PoW)', 'score': false},
        {'answerText': 'Proof of Stake (PoS) ', 'score': false},
        {'answerText': ' Proof of Authority (PoA) ', 'score': false},
        {'answerText': 'Proof of History (PoH)', 'score': true},
      ],
    },
    {
      'question': 'Which programming language is commonly used for developing smart contracts on Solana?',
      'answers': [
        {'answerText': 'JavaScript', 'score': false},
        {'answerText': 'Python', 'score': false},
        {'answerText': 'Rust', 'score': true},
        {'answerText': 'Solidity', 'score': false},
      ],
    },
    {
      'question': "What is the primary advantage of Solana's architecture compared to some other blockchain platforms?",
      'answers': [
        {'answerText': 'Low transaction fees', 'score': false},
        {'answerText': 'High scalability', 'score': true},
        {'answerText': 'Enhanced privacy', 'score': false},
        {'answerText': 'Centralized governance', 'score': false},
      ],
    },
    {
      'question': 'What is the native cryptocurrency of the Solana blockchain?',
      'answers': [
        {'answerText': 'Ethereum', 'score': false},
        {'answerText': 'Bitcoin ', 'score': false},
        {'answerText': 'Cardano ', 'score': false},
        {'answerText': 'SOL', 'score': true},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Solana"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height*0.2,
              child: Hero(tag: "solana",child: Image.network("https://patika-dev.s3-eu-central-1.amazonaws.com/content/tags/kjEPawYNqBMh7GZHn/solanaLogo%201.png",fit: BoxFit.contain,)),
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