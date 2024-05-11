import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_string.dart';
import './verify_email.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form Data
  String name = '';
  String password = '';
  String email = '';
  String confirmPassword = '';
  bool termsAccepted = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return; // Validation failed
    }
    _formKey.currentState!.save();

    if (!termsAccepted) {
      Get.snackbar('Error', 'You must accept the terms and conditions.');
      return;
    }
    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match.');
      return;
    }

    var response = await http.post(
      Uri.parse('http://10.0.2.2:5454/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'clientName': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      Get.to(() => VerifyMailScreen(email: email));
    } else {
      Get.snackbar('Error', 'Failed to sign up: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(TTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium),
                // Define each TextFormField with a controller and validator
                TextFormField(
                  decoration: const InputDecoration(labelText: "Name", prefixIcon: const Icon(Iconsax.user)),
                  onSaved: (value) => name = value ?? '',
                  validator: (value) => value!.isEmpty ? 'Name is required' : null,
                ),
                const SizedBox(height: TSizes.spaceBtwInputField),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                  onSaved: (value) => email = value ?? '',
                  validator: (value) => value!.isEmpty ? 'Email is required' : null,
                ),
                const SizedBox(height: TSizes.spaceBtwInputField),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password", prefixIcon: Icon(Iconsax.lock)),
                  onSaved: (value) => password = value ?? '',
                  validator: (value) => value!.isEmpty ? 'Password is required' : null,
                ),
                const SizedBox(height: TSizes.spaceBtwInputField),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Confirm Password", prefixIcon: Icon(Iconsax.lock)),
                  onSaved: (value) => confirmPassword = value ?? '',
                  validator: (value) => value!.isEmpty ? 'Confirm password is required' : null,
                ),
                const SizedBox(height: TSizes.spaceBtwInputField),
                Row(
                  children: [
                    Checkbox(
                      value: termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          termsAccepted = value!;
                        });
                      },
                    ),
                    const Text("I agree to the Terms and Conditions"),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Create Account"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
