import 'package:flutter/material.dart';
import 'add.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("tasksBox");

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      appBar: AppBar(
        backgroundColor: const Color(0xff1E2A44),
        title: Text(
          "Tasks",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Add()),
            ).then((value) {
              setState(() {});
            });
          },
          backgroundColor: Color(0xff1E2A44),
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ),

      body: ListView.builder(
        itemCount: box.length,

        itemBuilder: (context, index) {
          var task = box.getAt(index);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),

            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task["task"] ?? "",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1E2A44),
                            ),
                          ),

                          SizedBox(height: 7),

                          Text(
                            task["description"] ?? "",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff596579),
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Add(index: index),
                          ),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                      icon: Icon(Icons.edit, color: Color(0xff4F6D8A)),
                    ),

                    IconButton(
                      onPressed: () {
                        box.deleteAt(index);

                        setState(() {});
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        color: Color(0xffD95C5C),
                      ),
                    ),
                  ],
                ),

                Divider(thickness: 1, color: Color(0xffD9DEE8)),
              ],
            ),
          );
        },
      ),
    );
  }
}
