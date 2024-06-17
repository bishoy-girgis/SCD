import 'package:flutter/material.dart';
import 'package:toni/Core/services/cache_helper.dart';
import 'package:toni/screens/change password.dart';
import 'package:toni/screens/splash/splash%20screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name, email, phone, birthday, gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Handle save action here
              }
            },
          )
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors
                  .blue, // Choose a background color that fits your app's theme
              child: Icon(
                Icons
                    .person, // This is the material design icon for a person/profile
                size: 40, // Adjust the size as needed
                color: Colors
                    .white, // Choose an icon color that contrasts well with the background
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Full Name'),
              onSaved: (value) => name = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Your Email'),
              onSaved: (value) => email = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone No.'),
              onSaved: (value) => phone = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Your Birthday'),
              onSaved: (value) => birthday = value,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Gender'),
              items: ['Male', 'Female', 'Other'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChangePasswordScreen();
                })); // Handle change password
              },
              child: Text(
                'Change Password',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showSignOutConfirmation(
                    context); // Call the sign out confirmation dialog// Handle sign out
              },
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showSignOutConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are You sure, You want to sign out'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              SharedPref.remove(key: "accessToken");
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return const SplashScreen();
                },
              ),(route) => false,);// Dismiss the dialog after handling
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}
