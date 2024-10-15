import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/base/routes/app_route_const.dart';

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  String? selectedClass;
  String? selectedDivision;
  String? selectedFile;

  // Dummy data for dropdowns
  List<String> classList = ['V', 'VI', 'VII', 'VIII', 'IX', 'X'];
  List<String> divisionList = ['A', 'B', 'C'];

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.single.name;
      });
    } else {
      print('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.pushReplacementNamed(AppRouteConst.AdminstudentRouteName);
          },
        ),
        centerTitle: true,
        title: Text(
          'Add Student',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                _sectionTitle('Student Details'),
                SizedBox(height: 10),

                // Name Input
                CustomTextfield(
                  hintText: 'Name',
                  iconData: Icon(Icons.person),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Roll Number Input
                CustomTextfield(
                  hintText: 'Roll Number',
                  iconData: Icon(Icons.badge),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Roll Number Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Class and Division dropdowns
                Row(
                  children: [
                    // Class Dropdown
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        style: TextStyle(
                          fontSize: 14, // Text size for dropdown items
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Class',
                          labelStyle: TextStyle(
                            fontSize: 12, // Make the label text smaller
                            color: Colors
                                .black54, // Optional: Adjust label text color
                          ),
                          errorStyle: TextStyle(
                            fontSize:
                                10, // Smaller font size for error messages
                            color: Colors.red, // Error message color
                          ),
                          border: OutlineInputBorder(),
                        ),
                        value: selectedClass,
                        items: classList
                            .map((classValue) => DropdownMenuItem<String>(
                                  value: classValue,
                                  child: Text(classValue),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedClass = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Class is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),

                    // Division Dropdown
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        style: TextStyle(
                          fontSize: 14, // Text size for dropdown items
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Division',
                          labelStyle: TextStyle(
                            fontSize: 12, // Make the label text smaller
                            color: Colors.black54,
                            // Optional: Adjust label text color
                          ),
                          errorStyle: TextStyle(
                            fontSize:
                                10, // Smaller font size for error messages
                            color: Colors.red, // Error message color
                          ),
                          border: OutlineInputBorder(),
                        ),
                        value: selectedDivision,
                        items: divisionList
                            .map((divisionValue) => DropdownMenuItem<String>(
                                  value: divisionValue,
                                  child: Text(divisionValue),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedDivision = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Division is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Date of Joining Input
                CustomTextfield(
                  hintText: 'Date of joining',
                  iconData: Icon(Icons.calendar_today),
                  keyBoardtype: TextInputType.datetime,
                ),
                SizedBox(height: 20),

                // Date of Birth Input
                CustomTextfield(
                  hintText: 'Date of Birth',
                  iconData: Icon(Icons.calendar_today),
                  keyBoardtype: TextInputType.datetime,
                ),
                SizedBox(height: 20),

                // Address Input
                CustomTextfield(
                  hintText: 'Address',
                  iconData: Icon(Icons.location_on),
                  keyBoardtype: TextInputType.streetAddress,
                ),
                SizedBox(height: 20),

                // Admission Number and Aadhar Number Input
                CustomTextfield(
                  hintText: 'Admission Number',
                  iconData: Icon(Icons.credit_card),
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Aadhar Number',
                  iconData: Icon(Icons.account_box_outlined),
                ),
                SizedBox(height: 20),

                // Blood Group, Email, Previous School Inputs
                CustomTextfield(
                  hintText: 'Blood Group',
                  iconData: Icon(Icons.bloodtype),
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Email',
                  iconData: Icon(Icons.email),
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Previous School',
                  iconData: Icon(Icons.school_rounded),
                ),
                SizedBox(height: 20),

                _sectionTitle('Parent Details'),
                SizedBox(height: 10),

                // Parent Details
                CustomTextfield(
                  hintText: 'Father\'s Name',
                  iconData: Icon(Icons.person_outline),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Father\'s Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Father\'s Phone Number',
                  iconData: Icon(Icons.phone),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Father\'s Phone Number is required';
                    }
                    return null;
                  },
                  keyBoardtype: TextInputType.phone,
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Mother\'s Name',
                  iconData: Icon(Icons.person_outline),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mother\'s Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Mother\'s Phone Number',
                  iconData: Icon(Icons.phone),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mother\'s Phone Number is required';
                    }
                    return null;
                  },
                  keyBoardtype: TextInputType.phone,
                ),
                SizedBox(height: 20),

                // Guardian, Parent Email, Occupation Inputs
                CustomTextfield(
                  hintText: 'Guardian Fullname',
                  iconData: Icon(Icons.person_2_outlined),
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Parent Email',
                  iconData: Icon(Icons.email),
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Occupation',
                  iconData: Icon(Icons.work),
                ),
                SizedBox(height: 20),

                // Father's and Mother's Aadhar Number
                CustomTextfield(
                  hintText: 'Father\'s Aadhar Number',
                  iconData: Icon(Icons.account_box),
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Mother\'s Aadhar Number',
                  iconData: Icon(Icons.account_box),
                ),
                SizedBox(height: 20),

                _sectionTitle('Pervious School Details'),
                SizedBox(height: 10),

                CustomTextfield(
                  hintText: 'Category',
                  iconData: Icon(Icons.category),
                ),
                SizedBox(height: 20),

                CustomTextfield(
                  hintText: 'Sibblings Name',
                  iconData: Icon(Icons.group),
                ),

                SizedBox(height: 20),

                CustomTextfield(
                  hintText: 'Transportation Required',
                  iconData: Icon(Icons.car_crash_rounded),
                ),

                SizedBox(height: 20),

                CustomTextfield(
                  hintText: 'Hostel Required',
                  iconData: Icon(Icons.house_rounded),
                ),
                SizedBox(height: 20),

                _sectionTitle('Documents'),
                SizedBox(height: 10),

                GestureDetector(
                  onTap: pickFile,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12.0),
                    child: Row(
                      children: [
                        Icon(Icons.attachment_rounded, color: Colors.black),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            selectedFile ?? 'Student Photo',
                            style: TextStyle(
                                color: selectedFile != null
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                GestureDetector(
                  onTap: pickFile,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12.0),
                    child: Row(
                      children: [
                        Icon(Icons.attachment_rounded, color: Colors.black),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            selectedFile ?? 'father Or Mother Photo',
                            style: TextStyle(
                                color: selectedFile != null
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                GestureDetector(
                  onTap: pickFile,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12.0),
                    child: Row(
                      children: [
                        Icon(Icons.attachment_rounded, color: Colors.black),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            selectedFile ?? 'Aadhar Photo',
                            style: TextStyle(
                                color: selectedFile != null
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                GestureDetector(
                  onTap: pickFile,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12.0),
                    child: Row(
                      children: [
                        Icon(Icons.attachment_rounded, color: Colors.black),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            selectedFile ??
                                'Previous School Transfer Certificate',
                            style: TextStyle(
                                color: selectedFile != null
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 40),
                // Submit Button
                Center(
                  child: CustomButton(
                    text: 'Submit',
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Handle form submission logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Form successfully submitted!')),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper to create section titles
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Helper to create consistent input decoration
  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey),
      ),
      hintText: hint,
      prefixIcon: Icon(icon),
    );
  }
}
