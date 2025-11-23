import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo/Screen/addtaskscrn.dart';
import 'package:todo/Screen/homescrn.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Provider/home_screen_provider.dart';
import '../models/task.dart';
import '../service/local_db/database_helper.dart';

DatabaseHelper _databaseService = DatabaseHelper();

class EditScreen extends StatefulWidget {

  final int taskId;
  final String title;
  final String taskDes;
  final String date;
  const EditScreen({super.key, required this.taskId, required this.title, required this.taskDes, required this.date});


  @override
  State<EditScreen> createState() => _EditscrnState();
}

class _EditscrnState extends State<EditScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController =  TextEditingController(text: widget.title);
    desController = TextEditingController(text: widget.taskDes);
    dateController = TextEditingController(text: widget.date);
  }

  Future<void> updateUser({required BuildContext context, required int taskId, required String title, required String date,required String taskDes}) async {
    try {
      await _databaseService.updateTask(
          Task(taskId: taskId, title: title, date: date, taskDes: taskDes));
          context.read<HomeScreenProvider>().fetchAllTask();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task Added Sucessfully")));
    } catch (e,stackTrace) {
      print("exception is $e $stackTrace");
    }
  }

  Future<void> deleteUser({required BuildContext context,required int taskId}) async {
    try {
      await _databaseService.deleteTask(
          Task(taskId: taskId, title: '', date: '', taskDes: ''));
      context.read<HomeScreenProvider>().fetchAllTask();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task Deleted Sucessfully")));
    } catch (e,stackTrace) {
      print("exception is $e $stackTrace");
    }
  }


  @override
  Widget build(BuildContext context) {

    print("Id is ${widget.taskId}");
    print("Title is ${widget.title}");
    print("Description is ${widget.taskDes}");
    print("Date is ${widget.date}");
    return Scaffold(

      appBar: AppBar(
        title: const Text('Edit Task',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1AB8DB),
        elevation: 2,
      ),
      body: Container(

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.0,
              
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 45.0, left: 150.0),
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: SvgPicture.asset("asset/images/mainlogo.svg")
                    ),
                  ),
              
                  Text("Title", style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600)),
              
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Enter Task Title',
                      hintText: 'Enter Task Title',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
              
                  Text("Description", style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600)),
              
                  TextField(
                    controller: desController,
                    decoration: InputDecoration(
                      labelText: 'Enter Task Description',
                      hintText: 'Enter Task Description',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
              
                  Text("Date End", style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600)),
              
                  TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: 'Click here to choose date',
                      hintText: 'Click here to choose date',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 44.0),
                    child: Row(
                        children:[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                updateUser(context: context,taskId: widget.taskId, title: titleController.text, date: dateController.text, taskDes: desController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Done!',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
              
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                deleteUser(context: context,taskId: widget.taskId);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD71414),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}

//Navigotor ma methods
//Title add
