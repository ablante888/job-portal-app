import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewerScreen extends StatefulWidget {
  final String filePath;

  PDFViewerScreen(this.filePath);

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  bool _isLoading = true;
  bool _isError = false;
  int _currentPage = 0;
  int _totalPages = 0;
  PDFViewController? _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.filePath,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageSnap: true,
            defaultPage: _currentPage,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
            onRender: (pages) {
              setState(() {
                _isLoading = false;
                _totalPages = pages;
              });
            },
            onError: (error) {
              setState(() {
                _isLoading = false;
                _isError = true;
              });
            },
            onPageError: (page, error) {
              setState(() {
                _isLoading = false;
                _isError = true;
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
              setState(() {
                _pdfViewController = pdfViewController;
              });
            },
            // onPageChanged: (int page, int total) {
            //   setState(() {
            //     _currentPage = page;
            //     _totalPages = total;
            //   });
            // },
          ),
          if (_isLoading) Center(child: CircularProgressIndicator()),
          if (_isError) Center(child: Text('Error loading PDF')),
          Positioned(
            bottom: 10,
            right: 10,
            child: Text('Page ${_currentPage + 1} of $_totalPages'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pdfViewController?.dispose();
    super.dispose();
  }
}
