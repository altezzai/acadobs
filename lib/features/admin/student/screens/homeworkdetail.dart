import 'package:flutter/material.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';

class HomeworkDetails extends StatelessWidget {
  final String title;

  const HomeworkDetails({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHomeworkCard(),
            const SizedBox(height: 20),
            _buildResultSection(),
            const Spacer(),
            _buildReplySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeworkCard() {
    return Card(
      color: Colors.pink[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.assignment, size: 80, color: Colors.pink[300]),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Complete the registration of 12th class students before 2022",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Result",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _buildUserReview(),
      ],
    );
  }

  Widget _buildUserReview() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/staff1.png'),
      ),
      title: Row(
        children: [
          const Expanded(
            child: Text(
              "Khalid Mustafa",
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < 3 ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              );
            }),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          const Text(
            "Improve your handwriting",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            "9 minutes ago",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildReplySection() {
    return Row(
      children: [
        Expanded(
          child: CustomTextfield(
            hintText: "Write a reply",
            iconData: Icon(Icons.message), // You can customize the icon
            isPasswordField: false,
            onChanged: (value) {
              // Handle the text input
              print("Reply: $value");
            },
            onTap: () {
              // Add additional actions if needed
            },
            borderRadius: 20.0,
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 24,
          child: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Add send action here
            },
          ),
        ),
      ],
    );
  }
}
