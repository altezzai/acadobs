import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/form_validators.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
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
  String? selectedBloodGroup;
  String? selectedCategory;
  String? selectedTransportation;
  String? selectedHostel;
  String? selectedStudentPhoto;
  String? selectedParentPhoto;
  String? selectedAadharPhoto;
  String? selectedTransferCertificate;

  final TextEditingController _dateOfJoiningController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  final TextEditingController _dateOfBirthController =
      TextEditingController(text: '2000-01-01');

  final TextEditingController _fullNameController =
      TextEditingController(text: 'John Doe');

  final TextEditingController _rollNumberController =
      TextEditingController(text: '15');

  final TextEditingController _admissionNumberController =
      TextEditingController(text: 'ADM12345');

  final TextEditingController _aadhaarNumberController =
      TextEditingController(text: '1234 5678 9012');

  final TextEditingController _addressController =
      TextEditingController(text: '123, Street Name, City');

  final TextEditingController _emailController =
      TextEditingController(text: 'example@email.com');

  final TextEditingController _previousSchoolController =
      TextEditingController(text: 'ABC High School');

  final TextEditingController _fatherFullNameController =
      TextEditingController(text: 'Robert Doe');

  final TextEditingController _motherFullNameController =
      TextEditingController(text: 'Jane Doe');

  final TextEditingController _guardianNameController =
      TextEditingController(text: 'Uncle Sam');

  final TextEditingController parentEmailController =
      TextEditingController(text: 'parent@email.com');

  final TextEditingController _fatherContactNumberController =
      TextEditingController(text: '9876543210');

  final TextEditingController _motherContactNumberController =
      TextEditingController(text: '9876543211');

  final TextEditingController _occupationController =
      TextEditingController(text: 'Engineer');

  final TextEditingController _motherAadharNumberController =
      TextEditingController(text: '2345 6789 0123');

  final TextEditingController _fatherAadharNumberController =
      TextEditingController(text: '3456 7890 1234');

  final TextEditingController _alternateNumberController =
      TextEditingController(text: '9123456789');

  final TextEditingController _siblingNameController =
      TextEditingController(text: 'Emily Doe');

  late DropdownProvider dropdownProvider;

  late FilePickerProvider filePickerProvider;
  late StudentController studentController;
  @override
  void initState() {
    super.initState();
    filePickerProvider = context.read<FilePickerProvider>();
    dropdownProvider = context.read<DropdownProvider>();
    // studentController = context.read<StudentController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // studentController.checkParentEmailUsage(email: "parents1@example.com");
      filePickerProvider.clearFile('student photo');
      filePickerProvider.clearFile('parent photo');

      dropdownProvider.clearSelectedItem('gender');
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');
      dropdownProvider.clearSelectedItem('blood-group');
      dropdownProvider.clearSelectedItem('category');
      dropdownProvider.clearSelectedItem('transportation');
      dropdownProvider.clearSelectedItem('hostel');
      context.read<StudentController>().resetParentEmailCheckData();
    });
  }

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
    // _contactNumberController.dispose();
    _fatherFullNameController.dispose();
    _motherFullNameController.dispose();
    _emailController.dispose();
    _guardianNameController.dispose();
    _previousSchoolController.dispose();
    parentEmailController.dispose();
    _fatherContactNumberController.dispose();
    _motherContactNumberController.dispose();
    _occupationController.dispose();
    _siblingNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.height * 1),
                CustomAppbar(
                  title: 'Add Student',
                  isProfileIcon: false,
                  onTap: () {
                    Navigator.pop(context);
                    context.read<DropdownProvider>().clearAllDropdowns();
                  },
                ),
                // SizedBox(height: Responsive.height * 2),
                _sectionTitle('Student Details'),
                SizedBox(height: 10),

                // Name Input
                CustomTextfield(
                    hintText: 'Student Name',
                    controller: _fullNameController,
                    iconData: Icon(Icons.person),
                    validator: (value) => FormValidator.validateNotEmpty(value,
                        fieldName: "Name")),
                SizedBox(height: Responsive.height * 2),

                // Roll Number Input
                CustomTextfield(
                  hintText: 'Roll Number',
                  keyBoardtype: TextInputType.number,
                  controller: _rollNumberController,
                  iconData: Icon(Icons.badge),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.height * 2),

                CustomDropdown(
                  dropdownKey: 'gender',
                  label: 'Gender',
                  icon: Icons.person_2_outlined,
                  items: ['Male', 'Female', 'Other'],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.height * 2),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Responsive.height * 2),

                // Date of Joining Input
                // CustomDatePicker(
                //   lastDate: DateTime.now(),
                //   firstDate: DateTime(2022),
                //   label: "Date of Joining",
                //   dateController:
                //       _dateOfJoiningController, // Unique controller for end date
                //   onDateSelected: (selectedDate) {
                //     print("End Date selected: $selectedDate");
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'This field is required';
                //     }
                //     return null;
                //   },
                // ),

                // SizedBox(height: Responsive.height * 2),

                // Date of Birth Input
                CustomDatePicker(
                  // hintText: "Date of Birth",
                  label: "Date of Birth",
                  firstDate: DateTime(1995),
                  lastDate: DateTime(2020),
                  // initialDate: DateTime.now(),
                  dateController:
                      _dateOfBirthController, // Unique controller for end date
                  onDateSelected: (selectedDate) {
                    print("End Date selected: $selectedDate");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.height * 2),

                // Address Input
                CustomTextfield(
                  hintText: 'Address',
                  controller: _addressController,
                  iconData: Icon(Icons.location_on),
                  keyBoardtype: TextInputType.streetAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.height * 2),

                // Admission Number and Aadhar Number Input
                CustomTextfield(
                  hintText: 'Admission Number',
                  controller: _admissionNumberController,
                  iconData: Icon(Icons.credit_card),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.height * 2),
                CustomTextfield(
                  hintText: 'Aadhar Number',
                  controller: _aadhaarNumberController,
                  keyBoardtype: TextInputType.number,
                  iconData: Icon(Icons.account_box_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.height * 2),

                // Blood Group, Email, Previous School Inputs
                CustomDropdown(
                  dropdownKey: 'blood-group',
                  label: 'Blood Group',
                  items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
                  icon: Icons.bloodtype,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.height * 2),
                // ******EMAIL VALIDATION************//
                CustomTextfield(
                    hintText: 'Email',
                    controller: _emailController,
                    iconData: Icon(Icons.email),
                    validator: (value) => FormValidator.validateEmail(value)),
                SizedBox(height: Responsive.height * 2),
                CustomTextfield(
                  hintText: 'Previous School',
                  controller: _previousSchoolController,
                  iconData: Icon(Icons.school_rounded),
                ),
                SizedBox(height: Responsive.height * 2),
                // Parent Details
                _sectionTitle('Parent Details'),
                SizedBox(height: 10),
                CustomTextfield(
                  controller: parentEmailController,
                  hintText: 'Parent Email',
                  iconData: Icon(Icons.email),
                  validator: (value) => FormValidator.validateEmail(value),
                ),
                SizedBox(height: 10),
                Consumer<StudentController>(
                  builder: (context, studentController, child) {
                    // Check if email check data is available
                    if (studentController.parentEmailCheckData != null &&
                        studentController
                                .parentEmailCheckData!.previousStudentData !=
                            null &&
                        studentController.parentEmailCheckData!
                            .previousStudentData!.isNotEmpty) {
                      var studentParentData = studentController
                          .parentEmailCheckData!.previousStudentData![0];

                      // Autofill fields with the data
                      _fullNameController.text =
                          studentParentData.studentName ?? '';
                      _fatherFullNameController.text =
                          studentParentData.fatherFullName ?? '';
                      _motherFullNameController.text =
                          studentParentData.motherFullName ?? '';
                      _guardianNameController.text =
                          studentParentData.guardianFullName ?? '';
                      _fatherContactNumberController.text =
                          studentParentData.fatherContactNumber ?? '';
                      _motherContactNumberController.text =
                          studentParentData.motherContactNumber ?? '';
                      parentEmailController.text =
                          studentParentData.parentEmail ?? '';
                      _occupationController.text =
                          studentParentData.occupation ?? '';
                      _motherAadharNumberController.text =
                          studentParentData.motherAadhaarNumber ?? '';
                      _fatherAadharNumberController.text =
                          studentParentData.fatherAadhaarNumber ?? '';
                      _alternateNumberController.text =
                          studentParentData.alternateEmergencyContact ?? '';

                      // Other fields...
                    }

                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (parentEmailController.text.isNotEmpty) {
                              context
                                  .read<StudentController>()
                                  .checkParentEmailUsage(
                                      email: parentEmailController.text);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "Check Email",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            parentEmailController.text.isEmpty
                                ? "Please enter a valid email"
                                : (studentController
                                        .parentEmailCheckData?.message ??
                                    ""),
                            style: TextStyle(
                              color: parentEmailController.text.isEmpty
                                  ? Colors.red
                                  : Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: Responsive.height * 2),
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
                SizedBox(height: Responsive.height * 2),
                // **********PHONE NUMBER VALIDATION************//
                CustomTextfield(
                  hintText: 'Father\'s Phone Number',
                  controller: _fatherContactNumberController,
                  iconData: Icon(Icons.phone),
                  validator: (value) => FormValidator.validatePassword(value),
                  keyBoardtype: TextInputType.phone,
                ),
                SizedBox(height: Responsive.height * 2),
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
                SizedBox(height: Responsive.height * 2),
                CustomTextfield(
                  hintText: 'Mother\'s Phone Number',
                  iconData: Icon(Icons.phone),
                  controller: _motherContactNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mother\'s Phone Number is required';
                    }
                    return null;
                  },
                  keyBoardtype: TextInputType.phone,
                ),
                SizedBox(height: Responsive.height * 2),

                // Guardian, Parent Email, Occupation Inputs
                CustomTextfield(
                  hintText: 'Guardian Fullname',
                  controller: _guardianNameController,
                  iconData: Icon(Icons.person_2_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.height * 2),

                CustomTextfield(
                  hintText: 'Occupation',
                  iconData: Icon(Icons.work),
                  controller: _occupationController,
                ),
                SizedBox(height: Responsive.height * 2),
                _sectionTitle('Previous School Details'),
                SizedBox(height: 10),
                CustomDropdown(
                  dropdownKey: 'category',
                  label: 'Category',
                  items: ['private', 'Public'],
                  icon: Icons.category,
                ),

                SizedBox(height: Responsive.height * 2),

                CustomTextfield(
                  hintText: 'Siblings Name',
                  controller: _siblingNameController,
                  iconData: Icon(Icons.group),
                ),

                SizedBox(height: Responsive.height * 2),
                CustomDropdown(
                  dropdownKey: 'transportation',
                  label: 'Transportation Required',
                  items: ['Yes', 'No'],
                  icon: Icons.car_crash_rounded,
                ),

                SizedBox(height: Responsive.height * 2),
                CustomDropdown(
                  dropdownKey: 'hostel',
                  label: 'Hostel Required',
                  items: ['Yes', 'No'],
                  icon: Icons.house_rounded,
                ),

                SizedBox(height: Responsive.height * 2),

                _sectionTitle('Documents'),
                SizedBox(height: 10),

                CustomFilePicker(
                  label: 'student Photo',
                  fieldName: 'student photo',
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'This field is required';
                  //   }
                  //   return null;
                  // },
                ),

                SizedBox(height: Responsive.height * 2),
                // CustomFilePicker(
                //   label: 'Aadhar Photo',
                //   fieldName: 'aadhar photo',
                // ),

                SizedBox(height: Responsive.height * 2),

                CustomFilePicker(
                  label: 'Parent Photo',
                  fieldName: 'parent photo',
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'This field is required';
                  //   }
                  //   return null;
                  // },
                ),

                SizedBox(height: 40),

                Center(child: Consumer<StudentController>(
                    builder: (context, value, child) {
                  return CommonButton(
                    onPressed: () {
                      _submitForm(context);
                      // context.read<StudentController>().addNewStudentTesting();
                    },
                    widget:
                        value.isLoadingTwo ? ButtonLoading() : Text('Submit'),
                  );
                })),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    // Validate the form first
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Fetch data from dropdowns and file pickers
        final selectedGender =
            context.read<DropdownProvider>().getSelectedItem('gender');
        final selectedClass =
            context.read<DropdownProvider>().getSelectedItem('class');
        final selectedDivision =
            context.read<DropdownProvider>().getSelectedItem('division');
        final selectedBloodGroup =
            context.read<DropdownProvider>().getSelectedItem('blood-group');
        final selectedCategory =
            context.read<DropdownProvider>().getSelectedItem('category');

        final selectedTransportation = context
                .read<DropdownProvider>()
                .getSelectedItem('transportation') ==
            "Yes";
        final selectedHostel =
            context.read<DropdownProvider>().getSelectedItem('hostel') == "Yes";

        // final selectedStudentPhoto =
        context.read<FilePickerProvider>().getFile('student photo');
        // final selectedAadharPhoto =
        //     context.read<FilePickerProvider>().getFile('aadhar photo');
        // final parentPhoto =
        context.read<FilePickerProvider>().getFile('parent photo');
        // final studentPhotoPath = selectedStudentPhoto?.path;
        // final aadharPhotoPath = selectedAadharPhoto?.path;
        // final parentPhotoPath = parentPhoto?.path;

        // Call the controller method to add the student
        context.read<StudentController>().addNewStudent(
              context,
              fullName: _fullNameController.text,
              dateOfBirth: _dateOfBirthController.text,
              gender: selectedGender,
              studentClass: selectedClass,
              section: selectedDivision,
              rollNumber: int.tryParse(_rollNumberController.text) ?? 0,
              admissionNumber: _admissionNumberController.text,
              aadhaarNumber: _aadhaarNumberController.text,
              residentialAddress: _addressController.text,
              contactNumber: _fatherContactNumberController.text,
              email: _emailController.text,
              previousSchool: _previousSchoolController.text,
              fatherFullName: _fatherFullNameController.text,
              motherFullName: _motherFullNameController.text,
              guardianFullName: _guardianNameController.text,
              bloodGroup: selectedBloodGroup,
              parentEmail: parentEmailController.text,
              fatherContactNumber: _fatherContactNumberController.text,
              motherContactNumber: _motherContactNumberController.text,
              occupation: _occupationController.text,
              category: selectedCategory,
              siblingInformation: _siblingNameController.text,
              transportRequirement: selectedTransportation,
              hostelRequirement: selectedHostel,
              // studentPhoto: studentPhotoPath!,
              // aadharPhoto: aadharPhotoPath,
              // fatherMotherPhoto: parentPhotoPath!,
            );

        // Clear the form fields upon success
        // context.read<DropdownProvider>().clearAllDropdowns();
        // _clearFormFields();
      } catch (e) {
        // Handle any errors and show an error message
        CustomSnackbar.show(context,
            message: "Failed to add student.Please try again",
            type: SnackbarType.failure);
      }
    } else {
      // Highlight missing fields if the form is invalid
      CustomSnackbar.show(context,
          message: "Please complete all required fields",
          type: SnackbarType.warning);
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
    // _contactNumberController.clear();
    _emailController.clear();
    _fatherFullNameController.clear();
    _motherFullNameController.clear();
    _fatherContactNumberController.clear();
    _motherContactNumberController.clear();
    _siblingNameController.clear();
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
  // InputDecoration _inputDecoration(String hint, IconData icon) {
  //   return InputDecoration(
  //     contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
  //     border: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       borderSide: BorderSide(color: Colors.grey),
  //     ),
  //     hintText: hint,
  //     prefixIcon: Icon(icon),
  //   );
  // }
}
