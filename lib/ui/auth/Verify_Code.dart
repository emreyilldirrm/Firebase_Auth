import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/Utils/utils.dart';
import 'package:firebase_login/ui/post/post_screen.dart';
import 'package:firebase_login/widgets/round_button.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;

  VerifyCodeScreen({required this.verificationId});

  /*const VerifyCodeScreen({Key? key,
    required this.verificationId,
  }) : super(key: key);
*/

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  bool loading = false;
  final verifyController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: verifyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: " 6 digit code",
              ),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
                title: "Verify",
                loading: loading,
                ontap: () async {

                  setState(() {
                    loading =true;
                  });

                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verifyController.text.toString());

                  try {
                    await auth.signInWithCredential(credential);

                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(),));


                  }catch(e)
                  {
                    setState(() {
                      loading =false;
                      Utils().toastMessage(e.toString());
                    });

                  }

                })
          ],
        ),
      ),
    );
  }
}
