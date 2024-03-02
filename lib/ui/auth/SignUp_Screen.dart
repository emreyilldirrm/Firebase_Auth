import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/Utils/utils.dart';
import 'package:firebase_login/ui/auth/Login_Screen.dart';
import 'package:firebase_login/widgets/round_button.dart';
import 'package:flutter/material.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  void signup() {
    setState(() {
      loading = true;

      _auth
          .createUserWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passController.text.toString())
          .then((value) {
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Text(
          "Sign",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        helperText: "Enter Email : emre@yandex.com",
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter password";
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 50,
            ),
            RoundButton(
                title: "Sign Up",
                loading: loading,
                ontap: () {
                  if (_formKey.currentState!.validate()) {
                    signup();
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Alread have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Text("Login"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
