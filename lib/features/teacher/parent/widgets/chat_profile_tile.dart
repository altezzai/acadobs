import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatProfileTile extends StatelessWidget {
  final String name;
  final String subject;
  final String imageUrl;
  final VoidCallback onTap;
  final bool isNewMessage;

  const ChatProfileTile({
    Key? key,
    required this.name,
    required this.subject,
    required this.imageUrl,
    required this.onTap,
    this.isNewMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: SizedBox(
        width: 48,
        height: 48,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subject),
      trailing: isNewMessage
          ? Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                ),
                const Text(
                  '1', // Replace with dynamic count if available
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : null,
      onTap: onTap,
    );
  }
}
