import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

void main() => runApp(MaterialApp(home: BiasGuardApp()));

class BiasGuardApp extends StatefulWidget {
  @override
  _BiasGuardAppState createState() => _BiasGuardAppState();
}

class _BiasGuardAppState extends State<BiasGuardApp> {
  String result = "Upload a CSV to check for bias";

  Future<void> uploadFile() async {
    FilePickerResult? pick = await FilePicker.platform.pickFiles();
    if (pick != null) {
      setState(() { result = "Analyzing..."; });
      // Replace with your Cloud Run URL
      var request = http.MultipartRequest('POST', Uri.parse('https://your-cloud-run-url/analyze'));
      // ... Add file logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BiasGuard")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: uploadFile, child: Text("Upload Dataset")),
            Text(result),
          ],
        ),
      ),
    );
  }
}
