import 'package:flutter/material.dart';
import 'package:tiktok_clone/config.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgrouncolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                "assets/tiktok.png",
                height: 190,
                width: 190,
              ),
              const SizedBox(
                height: 35,
              ),
              const Center(
                child: Text(
                  "Enter your register email so we can send you a reset password link",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                style: TextStyle(),
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "Enter Your Register Email",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    labelText: "Email",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.deepOrange)),
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Colors.deepOrange,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.deepOrange))),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  authController.forgetPassword(_emailController.text, context);
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 17,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.deepOrange),
                  child: const Center(
                    child: Text(
                      "Send Reset Password Link",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 17,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.deepOrange),
                  child: const Center(
                    child: Text(
                      "Back To Login Page",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
