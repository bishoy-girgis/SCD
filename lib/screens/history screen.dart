import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, dynamic>> historyItems = [
    {
      'date': 'July 23',
      'events': ['-------', '------', '------']
    },
    {
      'date': 'July 22',
      'events': ['-------', '------', '-----']
    },
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('History',style: textTheme.bodyLarge),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
           Padding(
            padding: EdgeInsets.all(10.sp),
            child: const TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(historyItems[index]['date']),
                  children: historyItems[index]['events'].map<Widget>((event) {
                    return ListTile(
                      title: Text(event),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
