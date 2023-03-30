import 'package:flutter/material.dart';
import 'package:image_app/helper/app_colors.dart';
import 'package:image_app/pages/authentication/login_page.dart';
import 'package:image_app/widgets/custom_button.dart';
import 'package:image_app/widgets/field_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                "Sign up Page",
                style: TextStyle(
                  color: AppColor.green,
                  fontSize: 16,
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
                      onTap: () {},
                      height: 45,
                      width: 180,
                      color: AppColor.skyBlue,
                      name: "Signup",
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) {
                    return const LoginPage();
                  }));
                },
                child: const Text(
                  "Log in",
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
