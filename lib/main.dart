import 'package:flutter/material.dart';
import 'package:sqll_language/Students.dart';
import 'package:sqll_language/db_Helper.dart';

void main(){

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home_Page(),
  ),
  );
}



class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  void initState() {
    super.initState();

    DBHelper.dbHelper.initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: DBHelper.dbHelper.fetchAllRecords(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<Student>? data = snapshot.data;
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, i) {
                return Card(
                  elevation: 3,
                  child: ListTile(
                    isThreeLine: true,
                    leading: Text("${data?[i].id}"),
                    title: Text("${data?[i].name}"),
                    subtitle: Text("${data?[i].age}\n ${data?[i].city}"),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            DBHelper.dbHelper.insertRecord();
          });
          print("${DBHelper.dbHelper.path}");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
