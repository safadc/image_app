import 'package:flutter/material.dart';
import 'package:image_app/helper/app_colors.dart';
import 'package:image_app/pages/authentication/signup_page.dart';
import 'package:image_app/pages/home_page.dart';
import 'package:image_app/widgets/custom_button.dart';
import 'package:image_app/widgets/field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscurePassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Login Page",
                style: TextStyle(
                  color: AppColor.green,
                  fontSize: 18,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 45,
                    child: FieldWidget(
                      prefix: Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 45,
                    child: FieldWidget(
                      obscure: obscurePassword,
                      prefix: const Icon(
                        Icons.lock_outline_sharp,
                        color: Colors.grey,
                      ),
                      suffix: InkWell(
                        onTap: () {
                          obscurePassword = !obscurePassword;
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.remove_red_eye_outlined,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Button(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c) {
                          return const HomePage();
                        }));
                      },
                      height: 45,
                      width: 180,
                      color: AppColor.skyBlue,
                      name: "Login",
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c) {
                    return const SignUpPage();
                  }));
                },
                child: const Text(
                  "Signup",
                  style: TextStyle(
                    color: AppColor.skyBlue,
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
