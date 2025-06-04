import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PhotoPreviewPage extends StatelessWidget {
  final Uint8List imageBytes;

  const PhotoPreviewPage({super.key, required this.imageBytes});

  Future<void> _saveImage(BuildContext context) async {
    final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/glasses_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await file.writeAsBytes(imageBytes);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saved to ${file.path}")));
    Navigator.pop(context, true); // return to previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview")),
      body: Column(
        children: [
          Expanded(child: Image.memory(imageBytes)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => _saveImage(context), child: const Text("OK")),
              ElevatedButton(onPressed: () => Navigator.pop(context, false), child: const Text("Retake")),
            ],
          )
        ],
      ),
    );
  }
}
