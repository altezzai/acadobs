import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  String? selectedClass;
  String? selectedDivision;
  String? selectedGender;
  String? selectedStudentPhoto;
  String? selectedParentPhoto;
  String? selectedAadharPhoto;
  String? selectedTransferCertificate;

  final TextEditingController _dateOfJoiningController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _admissionNumberController =
      TextEditingController();
  final TextEditingController _aadhaarNumberController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fatherFullNameController =
      TextEditingController();
  final TextEditingController _motherFullNameController =
      TextEditingController();
  final TextEditingController _bloodgroupController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _fullNameController.dispose();
    _dateOfBirthController.dispose();
    _dateOfJoiningController.dispose();
    _rollNumberController.dispose();
    _admissionNumberController.dispose();
    _addressController.dispose();
    _aadhaarNumberController.dispose();
    _contactNumberController.dispose();
    _fatherFullNameController.dispose();
    _motherFullNameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  Future<void> pickFile(Function(String) onFilePicked) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        onFilePicked(result.files.single.name);
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
                  controller: _fullNameController,
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
                  controller: _rollNumberController,
                  iconData: Icon(Icons.badge),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Roll Number Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                CustomDropdown(
                  dropdownKey: 'gender',
                  label: 'Gender',
                  icon: Icons.person_2_outlined,
                  items: ['Male', 'Female', 'Other'],
                ),
                SizedBox(height: 20),
                // Class and Division dropdowns
                Row(
                  children: [
                    // Class Dropdown
                    Expanded(
                      child: CustomDropdown(
                        dropdownKey: 'class',
                        label: 'Class',
                        items: ['5', '6', '7', '8', '9', '10'],
                        icon: Icons.school,
                      ),
                    ),
                    SizedBox(width: 10),

                    // Division Dropdown
                    Expanded(
                      child: CustomDropdown(
                        dropdownKey: 'division',
                        label: 'Division',
                        items: ['A', 'B', 'C'],
                        icon: Icons.group,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Date of Joining Input
                CustomDatePicker(
                  label: "Date of Joining",
                  dateController:
                      _dateOfJoiningController, // Unique controller for end date
                  onDateSelected: (selectedDate) {
                    print("End Date selected: $selectedDate");
                  },
                ),

                SizedBox(height: 20),

                // Date of Birth Input
                CustomDatePicker(
                  label: "Date of Birth",
                  dateController:
                      _dateOfBirthController, // Unique controller for end date
                  onDateSelected: (selectedDate) {
                    print("End Date selected: $selectedDate");
                  },
                ),
                SizedBox(height: 20),

                // Address Input
                CustomTextfield(
                  hintText: 'Address',
                  controller: _addressController,
                  iconData: Icon(Icons.location_on),
                  keyBoardtype: TextInputType.streetAddress,
                ),
                SizedBox(height: 20),

                // Admission Number and Aadhar Number Input
                CustomTextfield(
                  hintText: 'Admission Number',
                  controller: _admissionNumberController,
                  iconData: Icon(Icons.credit_card),
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Aadhar Number',
                  controller: _aadhaarNumberController,
                  iconData: Icon(Icons.account_box_outlined),
                ),
                SizedBox(height: 20),

                // Blood Group, Email, Previous School Inputs
                CustomTextfield(
                  hintText: 'Blood Group',
                  controller: _bloodgroupController,
                  iconData: Icon(Icons.bloodtype),
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Email',
                  controller: _emailController,
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
                  controller: _fatherFullNameController,
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
                  controller: _contactNumberController,
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
                  controller: _motherFullNameController,
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
                  hintText: 'Siblings Name',
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
                    onTap: () async {
                      await pickFile((fileName) {
                        setState(() {
                          selectedStudentPhoto = fileName;
                        });
                      });
                    },
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
                              selectedStudentPhoto ?? 'Student Photo',
                              style: TextStyle(
                                  color: selectedStudentPhoto != null
                                      ? Colors.black
                                      : Colors.grey,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    )),

                SizedBox(height: 20),

                GestureDetector(
                  onTap: () async {
                    await pickFile((fileName) {
                      setState(() {
                        selectedParentPhoto = fileName;
                      });
                    });
                  },
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
                            selectedParentPhoto ?? 'father Or Mother Photo',
                            style: TextStyle(
                                color: selectedParentPhoto != null
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
                  onTap: () async {
                    await pickFile((fileName) {
                      setState(() {
                        selectedAadharPhoto = fileName;
                      });
                    });
                  },
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
                            selectedAadharPhoto ?? 'Aadhar Photo',
                            style: TextStyle(
                                color: selectedAadharPhoto != null
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
                  onTap: () async {
                    await pickFile((fileName) {
                      setState(() {
                        selectedTransferCertificate = fileName;
                      });
                    });
                  },
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
                            selectedTransferCertificate ??
                                'Previous School Transfer Certificate',
                            style: TextStyle(
                                color: selectedTransferCertificate != null
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

                Center(
                  child: CustomButton(
                    text: 'Submit',
                    onPressed: () {
                      _submitForm(context);
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

  void _submitForm(BuildContext context) {
    try {
      // Create StudentData from form data
      final selectedGender =
          context.read<DropdownProvider>().getSelectedItem('gender');
      final selectedClass =
          context.read<DropdownProvider>().getSelectedItem('class');
      final selectedDivision =
          context.read<DropdownProvider>().getSelectedItem('division');

      // final student = Student(
      //   fullName: _fullNameController.text,
      //   dateOfBirth: DateTime.parse(_dateOfBirthController.text),
      //   dateOfJoining: DateTime.parse(_dateOfJoiningController.text),
      //   studentClass: selectedClass,
      //   section: selectedDivision,
      //   rollNumber: int.tryParse(_rollNumberController.text),
      //   gender: selectedGender,
      //   admissionNumber: _admissionNumberController.text,
      //   aadhaarNumber: _aadhaarNumberController.text,
      //   residentialAddress: _addressController.text,
      //   contactNumber: _contactNumberController.text,
      //   email: _emailController.text,
      //   fatherFullName: _fatherFullNameController.text,
      //   motherFullName: _motherFullNameController.text,
      //   bloodGroup: null, // Optional
      //   studentClass: '',
      //   division: '', // Optional
      // );

      context.read<StudentController>().addNewStudent(context,
          fullName: _fullNameController.text,
          dateOfBirth: _dateOfBirthController.text,
          gender: selectedGender,
          studentClass: selectedClass,
          section: selectedDivision,
          rollNumber: _rollNumberController.text,
          admissionNumber: _admissionNumberController.text,
          aadhaarNumber: _aadhaarNumberController.text,
          residentialAddress: _addressController.text,
          contactNumber: _contactNumberController.text,
          email: _emailController.text,
          fatherFullName: _fatherFullNameController.text,
          motherFullName: _motherFullNameController.text,
          bloodGroup: _bloodgroupController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Student added successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      _clearFormFields();
    } catch (e) {
      // Handle any errors and show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add student complete all required fields'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

// Optional: Method to clear form fields after successful submission
  void _clearFormFields() {
    _fullNameController.clear();
    _dateOfBirthController.clear();
    _dateOfJoiningController.clear();
    _rollNumberController.clear();
    _admissionNumberController.clear();
    _aadhaarNumberController.clear();
    _addressController.clear();
    _contactNumberController.clear();
    _emailController.clear();
    _fatherFullNameController.clear();
    _motherFullNameController.clear();
    context.read<DropdownProvider>().clearAllDropdowns();
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
