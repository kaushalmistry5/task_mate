import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo/Screen/addtaskscrn.dart';
import 'package:todo/Screen/editscrn.dart';
import 'package:todo/Screen/homescrn.dart';

import '../Provider/home_screen_provider.dart';
import '../models/task.dart';
import '../service/local_db/database_helper.dart';

DatabaseHelper _databaseService = DatabaseHelper();

class Addtaskscrn extends StatefulWidget {
  const Addtaskscrn({super.key});

  @override
  State<Addtaskscrn> createState() => _AddtaskscrnState();
}

class _AddtaskscrnState extends State<Addtaskscrn> {

  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Future<void> insertTask({required String title ,required String date,required String taskDes}) async {
    try {
      await _databaseService.insertUser(
          Task(title: title, date: date, taskDes: taskDes));
          context.read<HomeScreenProvider>().fetchAllTask();
      Navigator.pop(context);
    } catch (e,stackTrace) {
      print("exception is $e $stackTrace");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Task',
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
                              insertTask(title: titleController.text, date: dateController.text, taskDes: desController.text);
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
                              'Add',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print('Task Cancelled');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD71414),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
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
          )
      ),
    );
  }
}