import 'package:blockchain_upi/screens/courses/bnbcourses.dart';
import 'package:blockchain_upi/screens/courses/introcourses.dart';
import 'package:blockchain_upi/screens/courses/palkadotcourses.dart';
import 'package:blockchain_upi/screens/courses/solanacourse.dart';
import 'package:blockchain_upi/screens/courses/techcources.dart';
import 'package:flutter/material.dart';
class CoursesCategories extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //Introduction
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroCourses(),),);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.005),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width*0.4,
                          height: size.height*0.2,
                          child: Hero(tag: "intro",child: Image.network("https://thumbs.dreamstime.com/b/introduction-text-note-pad-office-desk-computer-technol-written-electronic-devices-paper-wood-table-above-concept-85304190.jpg?w=768",fit: BoxFit.contain,)),
                        ),
                        SizedBox(width: size.width*0.04,),
                        Expanded(child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Introduction",style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold),),
                              Text("Dive into blockchain, cryptocurrencies, and decentralized applications.Gain skills to thrive in the decentralized web environment.")
                            ],
                          ),
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
              //Technical Courses
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TechCourses(),),);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.005),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width*0.4,
                          height: size.height*0.2,
                          child: Hero(tag: "tech",child: Image.network("https://d14b9ctw0m6fid.cloudfront.net/ugblog/wp-content/uploads/2020/09/shutterstock_435613807.jpg",fit: BoxFit.contain,)),
                        ),
                        SizedBox(width: size.width*0.04,),
                        Expanded(child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Technical Courses",style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold),),
                              Text("Explore cutting-edge technologies in our technical courses! Gain hands-on experience and practical skills in coding, data analysis.")
                            ],
                          ),
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
              //Solana
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SolanaCourses(),),);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.005),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width*0.4,
                          height: size.height*0.2,
                          child: Hero(tag: 'solana',child: Image.network("https://patika-dev.s3-eu-central-1.amazonaws.com/content/tags/kjEPawYNqBMh7GZHn/solanaLogo%201.png",fit: BoxFit.contain,)),
                        ),
                        SizedBox(width: size.width*0.04,),
                        Expanded(child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Solana",style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold),),
                              Text("Solana is a blockchain platform which uses a proof-of-stake mechanism to provide smart contract functionality. Its native cryptocurrency is SOL. ")
                            ],
                          ),
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
              //BNB Chain
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BNBCourses(),),);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.005),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width*0.4,
                          height: size.height*0.2,
                          child: Hero(tag: 'bnb',child: Image.network("https://patika-dev.s3-eu-central-1.amazonaws.com/content/tags/LEy5R4kfctLXGiWG8/bnb%20logo%20png%201.png",fit: BoxFit.contain,)),
                        ),
                        SizedBox(width: size.width*0.04,),
                        Expanded(child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("BNB Chain",style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold),),
                              Text("BNB Chain is a global, decentralized network with developers, validators, users, HODLers and enthusiasts.")
                            ],
                          ),
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
              //Polkadot
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PalkadotCourses(),),);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.005),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width*0.4,
                          height: size.height*0.2,
                          child: Hero(tag: 'pal',child: Image.network("https://patika-dev.s3-eu-central-1.amazonaws.com/content/tags/9hGG5KJptqwovLyFL/Frame%201321316456.png",fit: BoxFit.contain,)),
                        ),
                        SizedBox(width: size.width*0.04,),
                        Expanded(child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Polkadot",style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold),),
                              Text("Polkadot is a multi-chain blockchain platform that enables different blockchains to interact in a seamless manner.")
                            ],
                          ),
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
              //Internet Computer
              /*Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.005),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width*0.4,
                        height: size.height*0.2,
                        child: Image.network("https://patika-dev.s3-eu-central-1.amazonaws.com/content/tags/4GzAhNYhQMdwiFBsM/Frame%201321316458.png",fit: BoxFit.contain,),
                      ),
                      SizedBox(width: size.width*0.04,),
                      Expanded(child: Container(
                        child: Column(
                          children: [
                            Text("Internet Computer",style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold),),
                            Text("The Internet Computer is a blockchain that enables developers, organizations, and entrepreneurs to build and deploy secure.")
                          ],
                        ),
                      ),),
                    ],
                  ),
                ),
              ),
              //Rust
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.005),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width*0.4,
                        height: size.height*0.2,
                        child: Image.network("https://www.developer-tech.com/wp-content/uploads/sites/3/2023/08/state-of-rust-2022-global-adoption-positive-outlook-report-study-survey-research-programming-language.jpeg",fit: BoxFit.contain,),
                      ),
                      SizedBox(width: size.width*0.04,),
                      Expanded(child: Container(
                        child: Column(
                          children: [
                            Text("Rust",style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold),),
                            Text("Rust is a general-purpose programming language that emphasizes performance, type safety, and concurrency..")
                          ],
                        ),
                      ),),
                    ],
                  ),
                ),
              ),
              //Solidity
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.005),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width*0.4,
                        height: size.height*0.2,
                        child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZC-PkBmOOr45hrXNcjCb3Vg5jPnD_i-dTFcEMxFy6Tw&s",fit: BoxFit.contain,),
                      ),
                      SizedBox(width: size.width*0.04,),
                      Expanded(child: Container(
                        child: Column(
                          children: [
                            Text("Solidity",style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold),),
                            Text("Solidity is an object-oriented programming language for implementing smart contracts on various blockchain platforms,")
                          ],
                        ),
                      ),),
                    ],
                  ),
                ),
              ),
              //Chiliz
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.005),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width*0.4,
                        height: size.height*0.2,
                        child: Image.network("https://patika-dev.s3-eu-central-1.amazonaws.com/content/tags/TqzhZTRnp3nQRQsq6/Chiliz%20renkli%20logo.png",fit: BoxFit.contain,),
                      ),
                      SizedBox(width: size.width*0.04,),
                      Expanded(child: Container(
                        child: Column(
                          children: [
                            Text("Chiliz",style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold),),
                            Text("Chiliz Chain is a blockchain infrastructure designed for the sports and entertainment industry, providing a scalable ")
                          ],
                        ),
                      ),),
                    ],
                  ),
                ),
              ),
              //Sui Chain
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.005),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width*0.4,
                        height: size.height*0.2,
                        child: Image.network("https://patika-dev.s3-eu-central-1.amazonaws.com/content/tags/zNBcvL49AzJWs4kwR/Frame%201321316466.png",fit: BoxFit.contain,),
                      ),
                      SizedBox(width: size.width*0.04,),
                      Expanded(child: Container(
                        child: Column(
                          children: [
                            Text("Sui Chain",style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold),),
                            Text("Sui Chain is a dedicated blockchain for fashion, ensures secure transactions and traceable supply chains. ")
                          ],
                        ),
                      ),),
                    ],
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

}