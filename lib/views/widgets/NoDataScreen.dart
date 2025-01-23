import 'package:flutter/material.dart';

class NoDataFoundCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon or Illustration
              Icon(
                Icons.folder_open,
                size: 80,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 16),

              // Message Title
              Text(
                'No Data Found!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),

              // Subtitle Message
              Text(
                'We tried our best to find some data but couldn\'t find any!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
