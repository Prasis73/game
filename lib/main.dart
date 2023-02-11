
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get_storage/get_storage.dart';
import 'arrow.dart';
import 'getStorage.dart';
import 'numberModels.dart';
import 'fortuneStyle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roulette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const AppWrite(),
      // home: const FirebasePage(),
      home: const HomePage(),
    );
  }
}

class MyRoulette extends StatefulWidget {
  const MyRoulette({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final StreamController controller;

  @override
  State<MyRoulette> createState() => _MyRouletteState();
}

class _MyRouletteState extends State<MyRoulette> {
   final box = GetStorage();
   String no = "";
    String prev = "";
  @override
  Widget build(BuildContext context) {
    
void hit(){
   Future.delayed(const Duration(milliseconds: 5000), () {

// Here you can write your code

 LoginGetStorage.getToken()!=LoginGetStorage.getNumber()?  setState(() {
      prev=no;
         box.write("Token", LoginGetStorage.getNumber());
         hit();
    // Here you can write your code for open new view
   }):(){
    setState(() {
       hit();
    });
   
   };

});

}


    StreamController<int> controller = StreamController<int>();
    return Column(
      children: [
        // Text("Random Number Generating Test"),
        SizedBox(
          height: 200,
          width: 800,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('randomNumber')
                .snapshots(),
            builder: (ctx, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final _blogs = streamSnapshot.data?.docs as List ?? [];

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _blogs.length,
                itemBuilder: (ctx, index) {
                  final RandomNumber _myBlogs = RandomNumber.fromJson(
                      Map<String, dynamic>.from(_blogs[index].data()));
                  // no= _myBlogs.body.toString();
                  // print(no);
                  box.write("Number", _myBlogs.body.toString()).then((value) {hit();});
                 
               
                
  

                  no = _myBlogs.body.toString();
                 

                  return Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          child: Text("roll")),
                      // Text("RANDOM NUMBER"),
                      // Text(_myBlogs.body.toString()),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          SizedBox(
                            width: 260,
                            height: 260,
                            child: Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: FortuneBar(
                                  onFling: () {
                                    setState(() {});
                                  },
                                  // selected: controller.stream,
                                  selected: Stream.value(int.parse(no)),
                                  // styleStrategy: const AlternatingStyleStrategy(),
                                  items: [
                                    /*  FortuneItem(child: FortuneCustomStyle(text:"Han Solo",color:Colors.green),
               /*  style: const FortuneItemStyle(
                color: Colors.red, // <-- custom circle slice fill color
                borderColor: Colors.green, // <-- custom circle slice stroke color
                borderWidth: 3, // <-- custom circle slice stroke width
              ), */), */
                                    /* FortuneItem(child: FortuneCustomStyle(text:"Yoda",color:Colors.red),),
                    FortuneItem(child: FortuneCustomStyle(text:"Obi-Wan Kenobi",color:Colors.yellow),),
                    FortuneItem(child: FortuneCustomStyle(text:"1",color:Colors.red),), */
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "14", color: Colors.indigo),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "2", color: Colors.red),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "13", color: Colors.indigo),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "3", color: Colors.red),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "12", color: Colors.indigo),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "4", color: Colors.red),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "100", color: Colors.yellow),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "11", color: Colors.indigo),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "5", color: Colors.red),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "10", color: Colors.indigo),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "6", color: Colors.red),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "9", color: Colors.indigo),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "7", color: Colors.red),
                                    ),
                                    FortuneItem(
                                      child: FortuneCustomStyle(
                                          text: "8", color: Colors.indigo),
                                    ),
                                    /*   FortuneItem(child: Text('Yoda')),
                    FortuneItem(child: Text('Obi-Wan Kenobi')), */
                                  ],
                                )),
                          ),
                          const Arrow(),
                        ],
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // late RouletteController _controller;
  StreamController<int> _controller = StreamController<int>();
  final colors = <Color>[
    Colors.red,
    Colors.grey,
    Colors.red,
    Colors.grey,
    Colors.red,
    Colors.grey,
    Colors.red,
    Colors.grey,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roulette'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.1),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyRoulette(controller: _controller),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
}
