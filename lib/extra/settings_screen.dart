import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:yahya_project/utils/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ///Cupertino Switch
  bool isSwitchOn = false;
  ///Slider
  double currentValue = 20;
  ///DropDown
  List<String> genderList = [
    "Male", "Female", "Others"
  ];
  String? selectedGender;
  ///Check Box
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings "),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(isSwitchOn ? Icons.wifi : Icons.wifi_1_bar),
            title: Text("WIFI"),
            subtitle: Text(isSwitchOn ? "ON" : "OFF"),
            trailing: CupertinoSwitch(
                value: isSwitchOn,
                onChanged: (val){
                  setState(() {
                    isSwitchOn = val;
                  });
                }),
          ),
          if(isSwitchOn == true)
          Text("Sharp Visions 5G"),

          ///SlideR
          Slider(
              value: currentValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: currentValue.round().toString(),
              onChanged: (val){
                setState(() {
                  currentValue = val;
                });
              }),

          DropdownButton(
            hint: Text("Select Gender"),
            value: selectedGender,
              items: genderList.map((gender){
                return DropdownMenuItem(
                  value: gender,
                    child: Text(gender));
              }).toList(),
              onChanged: (val){
              setState(() {
                selectedGender = val;
              });
              }),
          Pinput(
            length: 6,
            showCursor: true,
            onCompleted: (value){
              print(value);
            },
            defaultPinTheme: PinTheme(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: .circular(10),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1
                )
              ),
              textStyle: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: AppColors.primaryColor
              )
            ),
          ),
          Checkbox(
              value: isChecked,
              onChanged: (val){
                setState(() {
                  isChecked = val!;
                });
              })
        ],
      ),
    );
  }
}
