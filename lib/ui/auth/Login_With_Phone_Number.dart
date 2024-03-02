import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/Utils/utils.dart';
import 'package:firebase_login/ui/auth/Verify_Code.dart';
import 'package:firebase_login/widgets/round_button.dart';
import 'package:flutter/material.dart';

/*
FİREBASE telefon numarası doğrulaması için kullandığın işletim sisteminin kodunu düzenleyip
proje dosyanda çalıştırman gerekir bilgisarında java jdk kurulu olması gerekir verilen sefiticate fingerprints Sha1 Sha26 numaralarını firebasede android veye ios kısmına
kaydetmrn gerekir.
Mac command:  keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

Windows command:  keytool -list -v -keystore "C:\Users\bilal\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

Linux keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
 */
class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final phoneController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: " 555-565-2323 ",
              ),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
                title: "Login",
                loading: loading,
                ontap: () {
                  setState(() {
                    loading = true;
                  });
                  _auth.verifyPhoneNumber (
                      phoneNumber: "+90"+phoneController.text,
                      verificationCompleted: (_) {
                        // Doğrulama tamamlandığında yapılacak işlemler
                        setState(() {
                          loading = false;
                        });

                      },
                      verificationFailed: (e) {
                        // Doğrulama başarısız olduğunda yapılacak işlemler
                        Utils().toastMessage(e.toString());
                        setState(() {
                          loading = false;
                        });
                      },
                      codeSent: (String verificationId, int? token) {
                        // Doğrulama kodu gönderildiğinde yapılacak işlemler
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyCodeScreen(
                                verificationId: verificationId,
                              ),
                            ));
                        setState(() {
                          loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        // Zaman aşımı durumunda yapılacak işlemler
                        Utils().toastMessage(e.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                })
          ],
        ),
      ),
    );
  }
}
