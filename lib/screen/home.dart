import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:http/http.dart' as http;
class home extends StatefulWidget {
  // const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String str = 'https://coderbyte.com/api/challenges/json/json-cleaning';

  var headers = {
    ''
  };

  Future FetchJson()async{
    var resp = await http.get(Uri.parse(str));
    var resposne = jsonDecode(resp.body);
    print(resposne);
    // print(cleanResp(resposne));
    print(cleanResp2(resposne));
  }


  cleanResp(Map json){
    var toRemove;
    for (var item in json.entries) {
      var value = item.value;
      if (value is Map) {
        cleanResp(value);
      }
      else if (value is List) {
        value.removeWhere((element) => element=='N/A' || element==' '  || element=='-');
      }
      else{
        if (value=='N/A' || value==''  || value=='-' ) {
          toRemove = item.key;
        }
      }
    }
    json.remove(toRemove);
    return(json);
  }

  //second way to implement it in a shorter way
  cleanResp2(Map js){
    js.removeWhere((key, value) => value == '' || value == '-' || value == 'N/A');
    for (var item in js.values) {
      if (item is Map) {
        cleanResp2(item);
      }
      else if (item is List) {
        item.removeWhere((element) => element=='N/A' || element==' '  || element=='-');
      }
    }
  return js;
  }


  @override
  void initState() {
    super.initState();
    FetchJson();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Json'),),
      // body: ,
    );
  }
}