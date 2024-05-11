import 'package:fashion_star_shop/features/authentication/screens/login/login.dart';
import 'package:fashion_star_shop/features/authentication/screens/signup.widgets/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fashion_star_shop/utils/constants/image_string.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/constants/text_string.dart';

class VerifyMailScreen extends StatelessWidget {
  final String email;

  const VerifyMailScreen({Key? key, required this.email}) : super(key: key);

  Future<void> verifyEmail() async {
    // Replace <TOKEN_FROM_EMAIL> with the token retrieved from email
    String token = "<TOKEN_FROM_EMAIL>";
    String url = "http://10.0.2.2:5454/register/confirmation";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Get.to(() => SuccessScreen(
          image: TImages.staticSuccessIllustration,
          title: TTexts.yourAccountCreatedTitle,
          subTitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () => Get.offAll(() => LoginScreen()),
        ));
      } else {
        throw Exception('Failed to verify email');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify email: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> resendEmail() async {
    // This should hit the API endpoint that resends the verification email
    // Assuming the resend API URL and method are known and appropriate headers/body are set
    String url = "http://yourapi.com/resend-verification";
    try {
      var response = await http.post(Uri.parse(url), body: {
        'email': email, // Assuming API needs an email field
      });
      if (response.statusCode == 200) {
        Get.snackbar('Email Sent', 'Verification email has been resent',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to resend email');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to resend email: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            Image(
              image: AssetImage(TImages.verifyIllustration),
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text(
              TTexts.confirmEmail,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              email,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              TTexts.confirmEmailSubTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: verifyEmail,
                child: const Text('Continue'),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: resendEmail,
                child: const Text('Resend Email'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
