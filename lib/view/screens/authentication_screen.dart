import 'package:flutter/material.dart';

import 'package:tiktok_clone/config.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/view/screens/forget_password_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  bool isLoginPage = true;
  bool isPasswordShow = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgrouncolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isLoginPage
                  ? const SizedBox(
                      height: 30,
                    )
                  : const SizedBox(
                      height: 15,
                    ),
              isLoginPage
                  ? Image.asset(
                      "assets/tiktok.png",
                      height: 190,
                      width: 190,
                    )
                  : Image.asset(
                      "assets/tiktok.png",
                      height: 170,
                      width: 170,
                    ),
              const SizedBox(
                height: 50,
                width: double.infinity,
              ),
              isLoginPage
                  ? Container()
                  : Stack(
                      children: [
                        ClipOval(
                            child: authController.ProfilePhoto != null
                                ? Image.file(authController.ProfilePhoto!)
                                : Image.network(
                                    "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png")),
                        Positioned(
                            bottom: -10,
                            left: 60,
                            child: IconButton(
                                onPressed: () {
                                  authController.selectImage();
                                },
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.deepOrange,
                                )))
                      ],
                    ),
              const SizedBox(
                height: 10,
              ),
              isLoginPage
                  ? Container()
                  : TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _userController,
                      decoration: InputDecoration(
                          hintText: "Enter Your Name",
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          labelText: "Username",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.deepOrange)),
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
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _emailController,
                decoration: InputDecoration(
                    helperStyle: TextStyle(color: Colors.white),
                    hintText: "Enter Your Email",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    labelText: "Email",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.deepOrange)),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
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
              TextFormField(
                obscureText: isPasswordShow,
                style: TextStyle(color: Colors.white),
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    labelText: "Password",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.deepOrange)),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.deepOrange,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordShow = !isPasswordShow;
                          });
                        },
                        icon: Icon(
                          isPasswordShow
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.deepOrange,
                        )),
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
                  isLoginPage
                      ? authController.loginUser(
                          _emailController.text, _passwordController.text)
                      : authController.registerUser(
                          _userController.text,
                          _emailController.text,
                          _passwordController.text,
                          authController.ProfilePhoto);
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 17,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.deepOrange),
                  child: Center(
                    child: Text(
                      isLoginPage ? "SIGN IN" : "SIGN UP",
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLoginPage
                        ? "Don't Have Account ?"
                        : "All Ready Have Account? ",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 253, 254, 255),
                        fontSize: 17),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isLoginPage = !isLoginPage;
                      });
                    },
                    child: Text(
                      isLoginPage ? " SignUp Now!" : " Login Now!",
                      style: const TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPasswordScreen(),
                        ));
                  },
                  child: Text(
                    isLoginPage ? "Forget Password?" : "",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
