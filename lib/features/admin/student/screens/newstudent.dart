import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
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
  String? selectedTransportation;
  String? selectedHostel;
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
  // final TextEditingController _contactNumberController =
  //     TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fatherFullNameController =
      TextEditingController();
  final TextEditingController _motherFullNameController =
      TextEditingController();
  final TextEditingController _guardianNameController = TextEditingController();

  final TextEditingController parentEmailController = TextEditingController();
  final TextEditingController _fatherContactNumberController =
      TextEditingController();
  final TextEditingController _motherContactNumberController =
      TextEditingController();
  late DropdownProvider dropdownProvider;

  late FilePickerProvider filePickerProvider;
  @override
  void initState() {
    super.initState();
    filePickerProvider = context.read<FilePickerProvider>();
    dropdownProvider = context.read<DropdownProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      filePickerProvider.clearFile('student photo');
      filePickerProvider.clearFile('parent photo');

      dropdownProvider.clearSelectedItem('gender');
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');
      dropdownProvider.clearSelectedItem('blood-group');
      dropdownProvider.clearSelectedItem('transportation');
      dropdownProvider.clearSelectedItem('hostel');
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

    parentEmailController.dispose();
    _fatherContactNumberController.dispose();
    _motherContactNumberController.dispose();

    super.dispose();
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
            Navigator.pop(context);
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
                      return 'This field is required';
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
                      return 'This field is required';
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
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

                SizedBox(height: 20),

                // Date of Joining Input
                CustomDatePicker(
                  label: "Date of Joining",
                  dateController:
                      _dateOfJoiningController, // Unique controller for end date
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

                SizedBox(height: 20),

                // Date of Birth Input
                CustomDatePicker(
                  label: "Date of Birth",
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
                SizedBox(height: 20),

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
                SizedBox(height: 20),

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
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Aadhar Number',
                  controller: _aadhaarNumberController,
                  iconData: Icon(Icons.account_box_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

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
                // CustomTextfield(
                //   hintText: 'Blood Group',
                //   controller: _bloodgroupController,
                //   iconData: Icon(Icons.bloodtype),
                //    validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'This field is required';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Email',
                  controller: _emailController,
                  iconData: Icon(Icons.email),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    // Enhanced email validation regex
                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
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
                  controller: _fatherContactNumberController,
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
                  controller: _motherContactNumberController,
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
                  controller: _guardianNameController,
                  iconData: Icon(Icons.person_2_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  controller: parentEmailController,
                  hintText: 'Parent Email',
                  iconData: Icon(Icons.email),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      // Enhanced email validation regex
                      final emailRegex = RegExp(
                          r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                    }
                    return null; // No validation error if empty
                  },
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

                _sectionTitle('Previous School Details'),
                SizedBox(height: 10),
                CustomDropdown(
                  dropdownKey: 'category',
                  label: 'Category',
                  items: ['private', 'Public'],
                  icon: Icons.category,
                ),
               
                SizedBox(height: 20),

                CustomTextfield(
                  hintText: 'Siblings Name',
                  iconData: Icon(Icons.group),
                ),

                SizedBox(height: 20),
                CustomDropdown(
                  dropdownKey: 'transportation',
                  label: 'Transportation Required',
                  items: ['Yes', 'No'],
                  icon: Icons.car_crash_rounded,
                ),

                SizedBox(height: 20),
                CustomDropdown(
                  dropdownKey: 'hostel',
                  label: 'Hostel Required',
                  items: ['Yes', 'No'],
                  icon: Icons.house_rounded,
                ),

                SizedBox(height: 20),

                _sectionTitle('Documents'),
                SizedBox(height: 10),

                CustomFilePicker(
                  label: 'student Photo',
                  fieldName: 'student photo',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),
                CustomFilePicker(
                  label: 'Aadhar Photo',
                  fieldName: 'aadhar photo',
                ),

                SizedBox(height: 20),

                CustomFilePicker(
                    label: 'Parent Photo', fieldName: 'parent photo',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },),

                SizedBox(height: 40),

                Center(child: Consumer<StudentController>(
                        builder: (context, value, child) {
                  return CommonButton(
                    onPressed: () {
                      _submitForm(context);
                    },
                    widget: value.isloading ? ButtonLoading() : Text('Submit'),
                  );
                })
                    //  CustomButton(
                    //   text: 'Submit',
                    //   onPressed: () {
                    //     _submitForm(context);
                    //   },
                    // ),
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
        final selectedStudentPhoto =
            context.read<FilePickerProvider>().getFile('student photo');
        final selectedAadharPhoto =
            context.read<FilePickerProvider>().getFile('aadhar photo');
        final parentPhoto =
            context.read<FilePickerProvider>().getFile('parent photo');
        final studentPhotoPath = selectedStudentPhoto?.path;
        final aadharPhotoPath = selectedAadharPhoto?.path;
        final parentPhotoPath = parentPhoto?.path;

        // Call the controller method to add the student
        context.read<StudentController>().addNewStudent(
              context,
              fullName: _fullNameController.text,
              dateOfBirth: _dateOfBirthController.text,
              gender: selectedGender,
              studentClass: selectedClass,
              section: selectedDivision,
              rollNumber: _rollNumberController.text,
              admissionNumber: _admissionNumberController.text,
              aadhaarNumber: _aadhaarNumberController.text,
              residentialAddress: _addressController.text,
              contactNumber: _fatherContactNumberController.text,
              email: _emailController.text,
              fatherFullName: _fatherFullNameController.text,
              motherFullName: _motherFullNameController.text,
              guardianFullName: _guardianNameController.text,
              bloodGroup: selectedBloodGroup,
              parentEmail: parentEmailController.text,
              fatherContactNumber: _fatherContactNumberController.text,
              motherContactNumber: _motherContactNumberController.text,
              studentPhoto: studentPhotoPath!,
              aadharPhoto: aadharPhotoPath,
              fatherMotherPhoto: parentPhotoPath!,
            );

        // Clear the form fields upon success
        _clearFormFields();
      } catch (e) {
        // Handle any errors and show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add student. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      // Highlight missing fields if the form is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please complete all required fields.'),
          backgroundColor: Colors.orange,
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
    // _contactNumberController.clear();
    _emailController.clear();
    _fatherFullNameController.clear();
    _motherFullNameController.clear();
    _fatherContactNumberController.clear();
    _motherContactNumberController.clear();

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
