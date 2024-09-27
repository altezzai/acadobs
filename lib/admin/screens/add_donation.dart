import 'package:flutter/material.dart';

class AddDonationPage extends StatelessWidget {
  const AddDonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Match background with the design
        elevation: 0, // Remove shadow to match design
        title: const Text(
          'Add Donation',
          style: TextStyle(color: Colors.black), // Match text color to design
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // Circle background color
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Colors.black), // Icon styling
              onPressed: () {
                // Handle back action
              },
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.school), // Flutter icon for Class
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
                      prefixIcon:
                          const Icon(Icons.group), // Flutter icon for Division
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
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon:
                    const Icon(Icons.person), // Flutter icon for Student
                labelText: 'Select Student',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              items: ['Student 1', 'Student 2', 'Student 3']
                  .map((studentName) => DropdownMenuItem(
                        value: studentName,
                        child: Text(studentName),
                      ))
                  .toList(),
              onChanged: (value) {
                // Handle student selection
              },
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title field
                Text(
                  'Donation details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.title), // Flutter icon for Title
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),

                SizedBox(height: 16), // Space between the two fields

                // Amount field

                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.currency_rupee), // Flutter icon for Currency
                    labelText: 'Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            TextFormField(
              readOnly:
                  true, // Prevents user input, making it act like a button
              onTap: () {
                // Action for adding receipt (e.g., opening a file picker)
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.receipt), // Flutter icon for Receipt
                suffixIcon:
                    Icon(Icons.attach_file), // Flutter icon for Attachment
                labelText: 'Add Receipt', // Label for the field
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
              ),
            ),
            Spacer(),

            // Submit button
            Container(
              width: double.infinity, // Full width
              child: ElevatedButton(
                onPressed: () {
                  // Submit action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color black
                  foregroundColor: Colors.white, // Text color white
                  minimumSize: Size(double.infinity, 60), // Full width button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
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
    );
  }
}
