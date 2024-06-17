import 'dart:io';

import 'package:flutter/material.dart';

class ScanResult extends StatelessWidget {
  const ScanResult({super.key, this.image});
  final File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Scan Result'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image == null
                ? const Text('No Image Bicked')
                : Center(
                    child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(image!.path)),
                            fit: BoxFit.cover)),
                  )),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Diagnose',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'lukimia',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.green.shade300),
              ),
            ),
          ],
        ),
      ),
      // image == null ? Text('no image is selected') : Image.file(image!),
    );
  }
}
