import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yahya_project/utils/app_colors.dart';
import 'package:yahya_project/widgets/custom_appbar.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppbar(
            leading: Icon(Icons.arrow_back),
            title: "Create Event",
          )),
      body: Column(
        children: [
          Text("Date",style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),),
          Container(
            decoration: BoxDecoration(
              borderRadius: .circular(12),
              border: Border.all(
                color: Colors.grey,
                width: 1
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(DateFormat.yMMMd().format(selectedDate)),
                  IconButton(onPressed: (){
                    showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2126))
                        .then((value){
                          setState(() {
                            selectedDate = value!;
                          });
                    });
                  }, icon: Icon((Icons.date_range))
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Text("Time",style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),),
          Container(
            decoration: BoxDecoration(
              borderRadius: .circular(12),
              border: Border.all(
                color: Colors.grey,
                width: 1
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  if(selectedTime != null)
                  Text(selectedTime!.format(context).toString())
                  else
                    Text("No Time Selected"),
                  IconButton(onPressed: (){
                    showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now())
                        .then((val){
                          setState(() {
                            selectedTime = val;
                          });
                    });
                  }, icon: Icon((Icons.timelapse))
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
