import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String mail;
  late String pass;
  late String tokens;
  String  id="connecting..";
  bool check=false;
  get_token(String email,String password)async{
    String url = "https://helping-hands-app.com/api/login";
   http.Response response= await http.post(Uri.parse(url),body: ({
     'email':email,
     'password':password,
   })) as http.Response;

   var token=jsonDecode(response.body)['success']['token'];

   setState(() {
      tokens=token;
     check=true;
   });
  }
  get_details(String token)async{
    String url ="https://helping-hands-app.com/api/details";
       http.Response response= await http.post(Uri.parse(url),headers: ({
        'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
       })) as http.Response;

      print(response.body);
       var to=jsonDecode(response.body)['success']['id'];
       setState(() {
         id=to.toString();
       });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text("custom url post and post"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Center(
                child: Container(
                  decoration:BoxDecoration(border: Border.all(color:Colors.black,width:1)),
              child: Column(children: [
                Container(
                  decoration:BoxDecoration(border: Border.all(color:Colors.black,width:1)),
                  margin:EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: TextField(
                    onChanged: (value){
                      mail=value.toString();
                    },
                            decoration: InputDecoration(
                              contentPadding:EdgeInsets.all(10),
                              hintText: "User Name"),
                ),),
                Container(
                  decoration:BoxDecoration(border: Border.all(color:Colors.black,width:1)),
                  margin:EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: TextField(
                    onChanged: (value){
                      pass=value.toString();
                    },
                            decoration: InputDecoration(
                              contentPadding:EdgeInsets.all(10),
                              hintText: "Password "),
                ),),
                InkWell(
                  onTap: ()=>get_token(mail, pass),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.blueAccent),child: Text("post",style: TextStyle(fontSize: 20),),),
                ),
              ],),
            )),
                Center(
                  child: InkWell(
                    onTap: ()=>get_details(tokens),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:(check==false)?Colors.white:Colors.blueAccent),child: Text("get detalis",style: TextStyle(fontSize: 20,color:(check==false)?Colors.white:Colors.black),),),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: ()=>get_details(tokens),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:(check==false)?Colors.white:Colors.white),child: Text("your id is $id",style: TextStyle(fontSize: 20,color:(check==false)?Colors.white:Colors.black),),),
                  ),
                ),
          ]),
        ),
      ),
    ));
  }
}
