import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:paycron/utils/color_constants.dart';

class FileViewerPage extends StatefulWidget {
  final String fileUrl;

  const FileViewerPage({Key? key, required this.fileUrl}) : super(key: key);

  @override
  _FileViewerPageState createState() => _FileViewerPageState();
}

class _FileViewerPageState extends State<FileViewerPage> {
  String? _pdfPath; // Path to store downloaded PDF
  bool isPdf = false;

  @override
  void initState() {
    super.initState();
    _initializeViewer();
  }

  // Initialize viewer based on file type
  void _initializeViewer() async {
    final fileExtension = widget.fileUrl.split('.').last.toLowerCase();

    if (fileExtension == 'pdf') {
      setState(() => isPdf = true);

      try {
        final response = await http.get(Uri.parse(widget.fileUrl));
        if (response.statusCode == 200) {
          final document = response.bodyBytes;
          final dir = await getTemporaryDirectory();
          final file = File('${dir.path}/pdf_file.pdf');
          await file.writeAsBytes(document);

          setState(() {
            _pdfPath =
                file.path; // Initialize _pdfPath after file is downloaded
          });
        } else {
          throw Exception("Failed to load PDF file.");
        }
      } catch (e) {
        debugPrint("Error loading PDF: $e");
      }
    } else {
      setState(() => isPdf = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          color: AppColors.appBlackColor,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.close, color: AppColors.appBlackColor, size: 30),
              onPressed: () {
                Navigator.pop(context); // Close the viewer
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: isPdf ? _buildPdfViewer() : _buildImageViewer(),
          ),
        ),
      ),
    );
  }

  Widget _buildPdfViewer() {
    return _pdfPath != null
        ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 0,
                  offset: Offset(0, 0), // Shadow position
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: PDFView(
                filePath: _pdfPath,
              ),
            ),
          )
        : Center(child: CircularProgressIndicator()); // Loading state
  }

  Widget _buildImageViewer() {
    return CachedNetworkImage(
      imageUrl: widget.fileUrl,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      // Loading indicator
      errorWidget: (context, url, error) =>
          Center(child: Icon(Icons.error, size: 40, color: Colors.red)),
      fadeInDuration: Duration(milliseconds: 300),
      // Smooth fade-in effect
      fit: BoxFit.contain,
      // Fit the image inside the viewer
      width: double.infinity,
      height: double.infinity,
      fadeInCurve: Curves.easeIn, // Smooth animation
    );
  }
}
