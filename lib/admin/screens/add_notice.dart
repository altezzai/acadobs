import 'package:flutter/material.dart';


class AddNoticePage extends StatefulWidget {
  @override
  _AddNoticePageState createState() => _AddNoticePageState();
}

class _AddNoticePageState extends State<AddNoticePage> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _dateController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notice'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:SingleChildScrollView( // Use SingleChildScrollView here
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Text(
                'Target audience',
                style: TextStyle(
                  fontSize: 16,
                  
                ),
              ),
              SizedBox(height: 20),
            // Target Audience Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Audience',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
                prefixIcon: Icon(Icons.person),
              ),
              items: [
                DropdownMenuItem(
                  child: Text('All Students'),
                  value: 'All Students',
                ),
                DropdownMenuItem(
                  child: Text('All Teachers'),
                  value: 'All Teachers',
                ),
                // Add more items as needed
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: 16),

            // Class Dropdown
           Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.school),
                      labelText: 'Class',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    items: ['Class 1', 'Class 2', 'Class 3']
                        .map((className) => DropdownMenuItem(
                              value: className,
                              child: Text(className),
                            ))
                        .toList(),
                    onChanged: (value) {
                      // Handle class selection
                    },
                  ),
                ),
                const SizedBox(width: 16), // Space between Class and Division
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                       Icons.class_, // You can use other letter icons as needed
                        // Adjust the size
                      ),
                      labelText: 'Division',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    items: ['Division A', 'Division B', 'Division C']
                        .map((divisionName) => DropdownMenuItem(
                              value: divisionName,
                              child: Text(divisionName),
                            ))
                        .toList(),
                    onChanged: (value) {
                      // Handle division selection
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Date Picker
            TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                 labelStyle: TextStyle(
                    color: Colors.grey, // Change label text color here
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true, // To prevent manual editing
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"; // Format the date as per your requirement
                    });
                  }
                },
              ),
            SizedBox(height: 16),
            Text(
                'Notice Details',
                style: TextStyle(
                  fontSize: 16,
                  
                ),
              ),
              SizedBox(height: 16),

            // Title Input
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
                 labelStyle: TextStyle(
                    color: Colors.grey, // Change label text color here
                  ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
                prefixIcon: Icon(Icons.title),
              ),
            ),
            SizedBox(height: 16),

            // Description Input
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Description',
                 labelStyle: TextStyle(
                    color: Colors.grey, // Change label text color here
                  ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
                prefixIcon: Icon(Icons.description),
              ),
            ),
            SizedBox(height: 16),

            // Document Upload Button
           TextField(
                decoration: InputDecoration(
                  labelText: 'Document',
                   labelStyle: TextStyle(
                    color: Colors.grey, // Change label text color here
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: Icon(Icons.attach_file),
                ),
                onTap: () {
                  // Add document picker action
                },
              ),
           
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Submit action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    ));
  }
}