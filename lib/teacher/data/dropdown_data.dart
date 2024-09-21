import 'package:flutter/material.dart';

class DropdownData {

  //selecting class 
  static List<DropdownMenuItem<String>> allClasses = const [
    DropdownMenuItem(value: 'class1', child: Text('5')),
    DropdownMenuItem(value: 'class2', child: Text('6')),
    DropdownMenuItem(value: 'class3', child: Text('7')),
    DropdownMenuItem(value: 'class4', child: Text('8')),
    DropdownMenuItem(value: 'class5', child: Text('9')),
    DropdownMenuItem(value: 'class6', child: Text('10')),
  ];

  //selecting Division
  static List<DropdownMenuItem<String>> allDivisions = const [
    DropdownMenuItem(value: 'div1', child: Text('A')),
    DropdownMenuItem(value: 'div2', child: Text('B')),
    DropdownMenuItem(value: 'div3', child: Text('C')),
    DropdownMenuItem(value: 'div4', child: Text('D')),
    DropdownMenuItem(value: 'div5', child: Text('E')),
    DropdownMenuItem(value: 'div6', child: Text('F')),
  ];

  //selecting Leavetype
  static List<DropdownMenuItem<String>> leaveTypes = const [
    DropdownMenuItem(value: 'casual', child: Text('Casual Leave')),
    DropdownMenuItem(value: 'sick', child: Text('Sick Leave')),
    DropdownMenuItem(value: 'paid', child: Text('Paid Leave')),
    DropdownMenuItem(value: 'unpaid', child: Text('Unpaid Leave')),
    DropdownMenuItem(value: 'maternity', child: Text('Maternity Leave')),
    DropdownMenuItem(value: 'paternity', child: Text('Paternity Leave')),
  ];

  // Define the static list of dropdown items for subjects
  static List<DropdownMenuItem<String>> subjects = const [
    DropdownMenuItem(value: 'math', child: Text('Mathematics')),
    DropdownMenuItem(value: 'science', child: Text('Science')),
    DropdownMenuItem(value: 'english', child: Text('English')),
    DropdownMenuItem(value: 'history', child: Text('History')),
    DropdownMenuItem(value: 'geography', child: Text('Geography')),
    DropdownMenuItem(value: 'physics', child: Text('Physics')),
    DropdownMenuItem(value: 'chemistry', child: Text('Chemistry')),
    DropdownMenuItem(value: 'biology', child: Text('Biology')),
    DropdownMenuItem(value: 'computer', child: Text('Computer Science')),
    DropdownMenuItem(value: 'economics', child: Text('Economics')),
  ];

}