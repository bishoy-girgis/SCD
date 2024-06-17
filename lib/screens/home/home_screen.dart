import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                  color: Colors.green.shade600,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Tony',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 250,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sc',
                    style: TextStyle(
                        color: Colors.green.shade600,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Detect',
                    style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(
                height: 200,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'images/722422_spa_06.jpg',
                    fit: BoxFit.fill,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
