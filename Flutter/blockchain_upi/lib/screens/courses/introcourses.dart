import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/screens/courses/quiz/quiz.dart';
import 'package:blockchain_upi/screens/courses/yt_player.dart';
import 'package:flutter/material.dart';

class IntroCourses extends StatelessWidget
{
  final introTopics1 = [
    {
      'videoUrl':"https://youtu.be/Y-8QWW83erU",
      "topic":"Single chains",
    },
    {
      'videoUrl':"https://youtu.be/3yUuXY7WBbM",
      "topic":"Which chain represents the truth?",
    },
    {
      'videoUrl':"https://youtu.be/-Ae9h31XhhE",
      "topic":"A time-consuming puzzle",
    },
    {
      'videoUrl':"https://youtu.be/lWgnfT2_2o4",
      "topic":"They solve puzzles faster",
    },
    {
      'videoUrl':"https://youtu.be/WZ6Sn2vvFOw",
      "topic":"They can also cooperate to falsify",
    },
  ];
  final introTopics2 = [
    {
      'videoUrl':"https://youtu.be/nvvnJpCUpLY",
      "topic":"Introduction",
    },
    {
      'videoUrl':"https://youtu.be/nXcQRCCg1MM",
      "topic":"The Middleman",
    },
    {
      'videoUrl':"https://youtu.be/deMCsh6Ua6I",
      "topic":"Web3 Use Cases",
    },
    {
      'videoUrl':"https://youtu.be/kMCyt1xXi-c",
      "topic":"The Architecture of Web2 Apps",
    },
    {
      'videoUrl':"https://youtu.be/jZSxJLdeMCQ",
      "topic":"Use Cases from Enterprise Companies",
    },
  ];

  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the term applied for splits in a blockchain network?',
      'answers': [
        {'answerText': 'Mergers', 'score': false},
        {'answerText': 'Divisions ', 'score': false},
        {'answerText': 'Forks ', 'score': true},
        {'answerText': 'None of the above', 'score': false},
      ],
    },
    {
      'question': 'Which trees are responsible for storing all transactions in a black through digital signatures of the complete set of transactions?',
      'answers': [
        {'answerText': 'Binary', 'score': false},
        {'answerText': 'Merkle', 'score': true},
        {'answerText': 'Red Black', 'score': false},
        {'answerText': 'AVL', 'score': false},
      ],
    },
    {
      'question': 'Which of the following choices is a type of blockchain?',
      'answers': [
        {'answerText': 'Restricted blockchain network', 'score': false},
        {'answerText': 'Private blockchain network standard deviation of the portfolio', 'score': true},
        {'answerText': 'Constraint blockchain network', 'score': false},
        {'answerText': 'Open blockchain network', 'score': false},
      ],
    },
    {
      'question': 'What are the important traits of blockchain technology?',
      'answers': [
        {'answerText': 'Decentralization', 'score': false},
        {'answerText': 'Immutability ', 'score': false},
        {'answerText': 'Transparency ', 'score': false},
        {'answerText': 'All of the above', 'score': true},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Introduction"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height*0.2,
              child: Hero(tag: "intro",child: Image.network("https://thumbs.dreamstime.com/b/introduction-text-note-pad-office-desk-computer-technol-written-electronic-devices-paper-wood-table-above-concept-85304190.jpg?w=768",fit: BoxFit.cover,)),
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
                            Text("Transition to Web3 - Course 1 | Blockchain Basics",maxLines: 2,style: TextStyle(fontWeight: FontWeight.w600),),
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
                            Text("Transition to Web3 - Course 2 | Transactions and Bitcoin",maxLines: 2,style: TextStyle(fontWeight: FontWeight.w600),),
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