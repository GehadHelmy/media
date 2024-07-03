import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:media_module/assignments_details/bottomsheet.dart';

class AssignmentDetails extends StatefulWidget {
  final data;
  const AssignmentDetails({super.key, this.data});
  @override
  State<AssignmentDetails> createState() => _AssignmentDetailsState();
}

class _AssignmentDetailsState extends State<AssignmentDetails> {
  FilePickerResult? result;
  String? _filName;
  PlatformFile?pickfile;
  bool isLoading = false;
  File?fileToDisplay;

  void pickFile()async{
    try{
      setState(() {
        isLoading=true;
      });
      result= await FilePicker.platform.pickFiles(
        type:FileType.any,
        allowMultiple: false );
        if(result!=null){
        _filName=result!.files.first.name;
        pickfile=result!.files.first;
        fileToDisplay= File(pickfile!.path.toString());
        print('file name: $_filName');
                }
 
      setState(() {
        isLoading=false;
      });
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:Stack(
          children: [
          Column(
            children: [
              Text(widget.data['title'],style:const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.end,),
              const SizedBox(height: 15,),
               Padding(padding:const EdgeInsets.only(left: 8),
               child:Text(widget.data['description'], style:const TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),)
            ],
          ),
           DraggableSheet(
        child:Column(
          children: [
            Text(widget.data['dueDate'].toString(),style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
            const SizedBox(height: 15,),
            isLoading?const CircularProgressIndicator():TextButton(onPressed: (){pickFile();},
             child:const Text('upload your file',style: TextStyle(backgroundColor: Colors.green), ),),
            
          ],)),
          ],
        )
      );
  }
}