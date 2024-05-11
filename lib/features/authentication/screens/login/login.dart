import 'package:fashion_star_shop/features/authentication/screens/signup.widgets/signup.dart';
import 'package:fashion_star_shop/naviagation_menu.dart';
import 'package:fashion_star_shop/services/sign_service.dart';
import 'package:fashion_star_shop/utils/constants/image_string.dart';
import 'package:fashion_star_shop/utils/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion_star_shop/features/authentication/screens/signup.widgets/signup.dart';
import 'package:fashion_star_shop/utils/constants/image_string.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/constants/text_string.dart';
import 'package:fashion_star_shop/common/styles/spacing_styles.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _checkboxValue = false;
  bool _isLoading = false;

  final signInService = SignInService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginWithEmail() async {
    setState(() => _isLoading = true);
    try {
      String token = await signInService.loginWebAccount(emailController.text, passwordController.text);
      if (token.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.snackbar("Login Error", "Login failed, no token received.");
      }
    } catch (exception) {
      print(exception);
      Get.snackbar("Login Error", "Failed to login");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.poddingwithAppBorHeight,
          child: Column(
            children: [
              Image(height: 150, image: AssetImage(TImages.onBoardingImage1)),
              Text(TTexts.loginTitle1, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.sm),
              Text(TTexts.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium),
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: 'Email'),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputField),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          labelText: 'Password',
                          suffixIcon: Icon(Iconsax.eye_slash),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputField / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _checkboxValue,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _checkboxValue = value ?? false;
                                  });
                                },
                              ),
                              const Text(TTexts.rememberMe),
                            ],
                          ),
                          TextButton(
                            onPressed: () {}, // Add functionality if needed
                            child: const Text(TTexts.forgetPassword),
                          )
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : loginWithEmail,
                          child: _isLoading ? const CircularProgressIndicator() : const Text(TTexts.signIn),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _isLoading ? null : () => Get.to(() => const SignupScreen()),
                          child: const Text(TTexts.createAccount),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                    ],
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
