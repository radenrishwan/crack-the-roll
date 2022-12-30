import 'package:crack_the_roll/common/constant.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final FocusNode passwordNode;
  const RegisterWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.passwordNode,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: kPrimaryColor,
                ),
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              fillColor: kPrimaryColor,
              focusColor: kPrimaryColor,
              hoverColor: kPrimaryColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: kLargeBorderRadius,
                borderSide: const BorderSide(
                  width: 2,
                  color: kPrimaryColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: kLargeBorderRadius,
                borderSide: const BorderSide(
                  width: 2,
                  color: kPrimaryColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: kLargeBorderRadius,
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red.shade700,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: kLargeBorderRadius,
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red.shade700,
                ),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(passwordNode);
            },
            validator: (value) {
              if (value!.length < 3) {
                return 'Email must be at least 3 characters';
              }

              return null;
            },
          ),
          SizedBox(height: kDefaultPadding.top),
          TextFormField(
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: kPrimaryColor,
                ),
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Password',
              fillColor: kPrimaryColor,
              focusColor: kPrimaryColor,
              hoverColor: kPrimaryColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: kLargeBorderRadius,
                borderSide: const BorderSide(
                  width: 2,
                  color: kPrimaryColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: kLargeBorderRadius,
                borderSide: const BorderSide(
                  width: 2,
                  color: kPrimaryColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: kLargeBorderRadius,
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red.shade700,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: kLargeBorderRadius,
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red.shade700,
                ),
              ),
            ),
            obscureText: true,
            autofocus: true,
            focusNode: passwordNode,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.length < 8) {
                return 'Password must be at least 8 characters';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}/// A form that takes in email and password and validates them.
