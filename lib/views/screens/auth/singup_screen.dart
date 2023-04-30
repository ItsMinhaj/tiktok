import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import '../../../controllers/registration_controller.dart';
import '../../../routes/routes.dart';
import '../../../utilies/validation_rules.dart';
import '../../widgets/text_input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _password;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final regController = Get.find<RegistrationController>();

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tiktok Clone",
                  style: TextStyle(
                      fontSize: 35,
                      color: buttonColor,
                      fontWeight: FontWeight.w900),
                ),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 15),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await regController.pickImageFromGallery();
                      },
                      child: Obx(
                        () {
                          return Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: regController.imagePath.isNotEmpty
                                  ? Image.file(
                                      File(regController.imagePath.toString()),
                                      fit: BoxFit.fill,
                                    )
                                  : const Icon(
                                      Icons.person,
                                      size: 100,
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Positioned(
                      bottom: -2,
                      left: 70,
                      child: Icon(Icons.add_a_photo),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextInputField(
                          controller: _name,
                          icon: Icons.person,
                          isObsecure: false,
                          labelText: "Username",
                          validator: ValidationRules.regularField,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextInputField(
                          controller: _email,
                          icon: Icons.email,
                          isObsecure: false,
                          labelText: "Email",
                          validator: ValidationRules.email,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextInputField(
                          controller: _password,
                          icon: Icons.lock,
                          isObsecure: true,
                          labelText: "Password",
                          validator: ValidationRules.password,
                        ),
                      ),
                      const SizedBox(height: 35),
                      InkWell(
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            await regController.registerUser(
                                _name.text,
                                _email.text,
                                _password.text,
                                regController.imagePath.value.toString());
                          }
                        },
                        child: Ink(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Obx(() {
                              return regController.isLoading.value
                                  ? const Center(
                                      child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ))
                                  : const Text(
                                      "Register",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offNamed(loginRoute);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
