import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/screens/courses/yt_player.dart';
import 'package:flutter/material.dart';

class PalkadotCourses extends StatelessWidget
{
  final introTopics1 = [
    {
      'videoUrl':"https://youtu.be/9Ge5xPBO7v4",
      "topic":"Relay chain, parachains and parathreads",
    },
    {
      'videoUrl':"https://youtu.be/nLrlOBcTqEw",
      "topic":"Smart contracts",
    },
  ];

  List<Map<String, dynamic>> questions = [
    {
      'question':
      'What is the primary function of Polkadot?',
      'answers': [
        {'answerText': 'Decentralized storage', 'score': false},
        {'answerText': 'Smart contract execution', 'score': false},
        {'answerText': 'Interoperability between blockchains', 'score': true},
        {'answerText': 'Payment for transaction fees', 'score': false},
      ],
    },
    {
      'question':
      'Who is one of the co-founders of Polkadot?',
      'answers': [
        {'answerText': ' Vitalik Buterin', 'score': false},
        {'answerText': 'Gavin Wood', 'score': true},
        {'answerText': 'Charles Hoskinson', 'score': false},
        {'answerText': 'Justin Sun', 'score': false},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Polkadot"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height*0.2,
              child: Hero(tag: "pal",child: Image.network("https://patika-dev.s3-eu-central-1.amazonaws.com/content/tags/9hGG5KJptqwovLyFL/Frame%201321316456.png",fit: BoxFit.contain,)),
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
                      child: Image.network("https://risein-prod.s3.eu-central-1.amazonaws.com/courses/polkadot-substrate.png",fit: BoxFit.cover,),
                    ),
                    SizedBox(width: size.width*0.03,),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text("Polkadot Fundamentals and Substrate Development",maxLines: 2,style: TextStyle(fontWeight: FontWeight.w600),),
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
                onPressed: (){},
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