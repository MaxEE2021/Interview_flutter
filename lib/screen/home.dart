import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
class home extends StatefulWidget {
  // const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String url = 'https://coderbyte.com/api/challenges/json/json-cleaning';



  Future fetchJson()async{
    try{
    http.get(Uri.parse(url)).then((response){
      if (response.statusCode == 200) {
        var resp = json.decode(response.body);
        print(resp);
        print(cleanResp2(resp));
        // print(cleanResp(resp));
      }
      
    }).catchError((e){
      print("error");
      print(e);
    });
  }
  catch(e){
    print(e);
  }
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
    // FetchJson();
    fetchJson();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Json'),),
      // body: ,
    );
  }
}