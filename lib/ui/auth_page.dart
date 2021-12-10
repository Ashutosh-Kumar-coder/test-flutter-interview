import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/state/app_state.dart';
import 'package:flutter_assignment/ui/home_page.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var name = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: size.height * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Register Here !!",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),),
                  CupertinoTextField(
                    placeholder: 'Enter your Name',
                    keyboardType: TextInputType.name,
                    controller: name,
                  ),
                  CupertinoTextField(
                    placeholder: 'Enter your Mobile',
                    keyboardType: TextInputType.phone,
                    controller: mobile,
                  ),
                  CupertinoTextField(
                    placeholder: 'Enter your Email',
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                  ),
                  CupertinoTextField(
                    placeholder: '********',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: password,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: CupertinoButton(
                  color: Colors.grey,
                  child: Text("Register"),
                  onPressed: () {
                    if (name.text.isNotEmpty && mobile.text.isNotEmpty &&
                        email.text.isNotEmpty && password.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Registered Successfully"),
                        duration: Duration(seconds: 2),
                        elevation: 5,
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),));
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => HomePage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Fill the Details First"),
                        duration: Duration(seconds: 2),
                        elevation: 5,
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
