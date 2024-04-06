import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:translateapp/Apidata.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart'as http;

import 'Temperaturescreen.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();
  var output;
  String ?dropdownValue;

  static const Map<String, String> lang = {
    "Hindi": "hi",
    "English": "en",
    "Gujarati": "gu",
  };

  void trans() {
    translator
        .translate(textEditingController.text, to: "$dropdownValue")
        .then((value) {
      setState(() {
        output = value;
      });
    });
  }
  void getData() async {
    var request = http.Request(
      'GET',
      Uri.parse('https://google-translate1.p.rapidapi.com/language/translate/v2/detect'),
    );

    request.headers.addAll({
      'Accept-Encoding': 'application/gzip',
      'X-RapidAPI-Key': '7fe81acec7msh16a543f46ef6bfcp1b8be1jsn950af51625dd',
      'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
    });

    request.bodyFields = {
      'q': 'English is hard, but detectably so',
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi Language Translator"),backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              style: TextStyle(fontSize: 24),
              controller: textEditingController,
              onTap: () {
                trans();
              },
              decoration: InputDecoration(
                labelText: 'Type Here',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Select Language",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(fontSize: 18),
                  underline: Container(
                    height: 2,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      trans();
                    });
                  },
                  items: lang.map((string, value) {
                    return MapEntry(
                      string,
                      DropdownMenuItem<String>(
                        value: value,
                        child: Text(string, style: TextStyle(fontSize: 18, color: Colors.black)), // Change text color here
                      ),
                    );
                  }).values.toList(),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Translated Text',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                output == null ? "Translated Text" : output.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.normal,

                ),
              ),
            ),
            ElevatedButton(onPressed: ()async{
              getData();
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Apidata()));
             // try {
              //   var response = await http.get(Uri.parse(
              //       "https://rapidapi.com/googlecloud/api/google-translate1/"),
              //     headers: {
              //       'content-type': 'application/json',
              //       'x-rapidapi-host': 'google-translate1.p.rapidapi.com',
              //       'x-rapidapi-key': 'YOUR_API_KEY_HERE', // Replace with your RapidAPI Key
              //     },
              //   );
              //   if (response.statusCode == 200) {
              //     var mydata = await jsonDecode(response.body);
              //     print(response.body);
              //     Navigator.push(context, MaterialPageRoute(
              //         builder: (context) => Apidata(mydata: mydata)));
              //   } else {
              //     print('Something went wrong');
              //   }
              // }catch(e){
              //   print('Error while fetching data: $e');
              // }

            },
    child: Text('Get Api'),
            style:ElevatedButton.styleFrom(primary: Colors.deepPurple) ,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Temperaturescreen()));
            }, child: Text('Start Temperature Stream'),
                style:ElevatedButton.styleFrom(primary: Colors.deepPurple))
          ],
        ),
      ),
    );
  }
}