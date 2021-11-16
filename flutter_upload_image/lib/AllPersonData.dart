// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//class ini untuk menampilkan semua data yang ada pada database
//serta menampilkan image yang telah diupload
class AllPersonData extends StatefulWidget {
  @override
  _AllPersonDataState createState() => _AllPersonDataState();
}

class _AllPersonDataState extends State<AllPersonData> {
  int count = 0;
  Future allPerson() async {
    var url = Uri.parse("http://10.0.2.2/image_upload_php_mysql/viewAll.php");
    var response = await http.get(url);
    var list = json.decode(response.body);
    setState(() {
      count = list.length;
    });
    return list;
  }

  @override
  void initState() {
    super.initState();
    allPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person All Data'),
      ),
      body: FutureBuilder(
        future: allPerson(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    dynamic list = snapshot.data;
                    return Card(
                      child: ListTile(
                        title: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                              "http://10.0.2.2/image_upload_php_mysql/uploads/${list[index]['image']}"),
                        ),
                        subtitle: Center(child: Text(list[index]['name'])),
                      ),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
