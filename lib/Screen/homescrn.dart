import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/home_screen_provider.dart';
import 'package:todo/Screen/addtaskscrn.dart';
import 'package:todo/Screen/editscrn.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/models/task.dart';
import 'package:todo/service/local_db/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int counter = 0;

  @override
  void initState() {
    super.initState();
  }

  void providerCalled(BuildContext cnt){

    cnt.read<HomeScreenProvider>().fetchAllTask();
  }

  @override
  Widget build(BuildContext context) {

    if(counter == 0){
      providerCalled(context);
      counter = counter + 1;
    }

   return Consumer<HomeScreenProvider>(
     builder: (context, value, child){
       print("Consumer Refreshed");
       return Scaffold(
         resizeToAvoidBottomInset: false,
         appBar: AppBar(
           backgroundColor: Colors.black,
           title: SvgPicture.asset("asset/images/mainlogo.svg", height: 70,),
           automaticallyImplyLeading: false,
           centerTitle: true,
           toolbarHeight: 70,

         ),
         body: Container(
           child: Padding(

             padding: const EdgeInsets.only(top: 41.0,left: 15.0, right: 15.0),
             child: Column(
               spacing: 20.0,

               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("8 TODOS "),
                     Text("View All"),
                   ],
                 ),
                 Container(
                   height: 50,
                   width: double.infinity,
                   decoration: BoxDecoration(
                     color: Color(0xFFD9D9D9),
                     borderRadius: BorderRadius.circular(4),
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Checkbox(value: false, onChanged: (k){
                       }),
                       Expanded(child: Text("Title")),
                       Expanded(child: Text("Date")),
                       Expanded(child: Text("Task")),
                     ],
                   ),
                 ),
                 SizedBox(
                   height: 550,
                   child: ListView.builder(
                       shrinkWrap: true,
                       itemCount: value.myTaskList.length,
                       itemBuilder: (context, index) {
                         print("HomeScreen TaskId is: ${value.myTaskList[index]["taskId"]}");
                         return Padding(
                           padding: const EdgeInsets.only(top: 5.0),
                           child: InkWell(
                             onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditScreen(taskId: value.myTaskList[index]["taskId"], title: value.myTaskList[index]["title"] ?? '', taskDes: value.myTaskList[index]["task_des"] ?? '', date: value.myTaskList[index]["date"] ?? '',)));
                             },
                             child: Container(
                               height: 50,
                               width: double.infinity,
                               decoration: BoxDecoration(
                                 color: Color(0xFFD9D9D9),
                                 borderRadius: BorderRadius.circular(4),
                               ),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   Checkbox(value: true, onChanged: (k){
                                   }),
                                   Expanded(child: Text(value.myTaskList[index]["title"] ?? '')),
                                   Expanded(child: Text(value.myTaskList[index]["date"] ?? '')),
                                   Expanded(child: Text(value.myTaskList[index]["task_des"] ?? '')),
                                 ],
                               ),
                             ),
                           ),
                         );
                       }),
                 )

               ],

             ),
           ),
         ),
         floatingActionButton: FloatingActionButton
           (onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => Addtaskscrn()));

         },
           child: Icon(Icons.add),
         ),
       );
     }

   );
  }
}
