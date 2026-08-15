import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Add extends StatefulWidget {
  final int? index;

  const Add({super.key, this.index});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.index != null) {
      var box = Hive.box("tasksBox");
      var task = box.getAt(widget.index!);

      taskController.text = task["task"] ?? "";
      descriptionController.text = task["description"] ?? "";
    } else {
      taskController.text = "Enter your task";
      descriptionController.text = "Description";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F8FC),

      appBar: AppBar(
        backgroundColor: Color(0xff1E2A44),
        foregroundColor: Colors.white,
        title: Text(
          widget.index == null ? "Add Tasks" : "Edit Task",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(right: 30, top: 25, left: 15),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              onTap: () {
                if (taskController.text == "Enter your task") {
                  taskController.clear();
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xffD9DEE8)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xffD9DEE8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xff1E2A44)),
                ),
              ),
              cursorColor: Color(0xff1E2A44),
            ),

            SizedBox(height: 20),

            TextField(
              controller: descriptionController,
              onTap: () {
                if (descriptionController.text == "Description") {
                  descriptionController.clear();
                }
              },
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xffD9DEE8)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xffD9DEE8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xff1E2A44)),
                ),
              ),
              cursorColor: Color(0xff1E2A44),
            ),

            SizedBox(height: 20),

            TextButton.icon(
              onPressed: () {
                var box = Hive.box("tasksBox");

                if (widget.index == null) {
                  box.add({
                    "task": taskController.text,
                    "description": descriptionController.text,
                  });
                } else {
                  box.put(widget.index!, {
                    "task": taskController.text,
                    "description": descriptionController.text,
                  });
                }

                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff1E2A44),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: Icon(Icons.save_alt_outlined, color: Colors.white),
              label: Text(
                "save",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
