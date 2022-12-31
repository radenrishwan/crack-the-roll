import 'dart:developer';

import 'package:crack_the_roll/common/constant.dart';
import 'package:crack_the_roll/common/route.dart';
import 'package:crack_the_roll/data/model/short_movie.dart';
import 'package:crack_the_roll/data/service/movie_service.dart';
import 'package:crack_the_roll/widget/register_widget.dart';
import 'package:crack_the_roll/widget/default_alert.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    'assets/icon.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: kSmallPadding.top),
                  Text(
                    'Crack The Roll',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontFamily: kTitleFontFamily.fontFamily,
                          color: Colors.black,
                          letterSpacing: 1.4,
                        ),
                  ),
                  SizedBox(height: kDefaultPadding.top),
                  Padding(
                    padding: kLargePadding.copyWith(top: 0, bottom: 0),
                    child: FutureBuilder<List<ShortMovie>>(
                      future: MovieService().getTrending(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          log(snapshot.error.toString());
                          return SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                              child: Text('Something went wrong'),
                            ),
                          );
                        }

                        if (snapshot.connectionState != ConnectionState.done) {
                          return SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final result = snapshot.data!;

                        return SizedBox(
                          height: 160,
                          child: ListView.builder(
                            itemCount: 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: kSmallPadding.copyWith(top: 0, bottom: 0),
                                child: ClipRRect(
                                  borderRadius: kDefaultBorderRadius,
                                  child: FancyShimmerImage(
                                    imageUrl: 'https://image.tmdb.org/t/p/w200/${result[index].posterPath}',
                                    boxFit: BoxFit.cover,
                                    width: 120,
                                    shimmerBaseColor: kPrimaryColor,
                                    shimmerHighlightColor: kSecondaryColor,
                                    shimmerBackColor: kLightBackgroundColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(flex: 2),
                  Padding(
                      padding: kLargePadding,
                      child: RegisterWidget(
                        emailController: emailController,
                        passwordController: passwordController,
                        passwordNode: passwordNode,
                      )),
                  SizedBox(height: kDefaultPadding.top),
                  Padding(
                    padding: kLargePadding.copyWith(top: 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (passwordController.text.isEmpty || emailController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const DefaultAlert(
                                        title: 'Error occured', content: 'Email or password must not be empty');
                                  },
                                );

                                return;
                              }

                              if (emailController.text.length < 3) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const DefaultAlert(
                                        title: 'Error occured', content: 'Email must be at least 3 characters');
                                  },
                                );

                                return;
                              }

                              if (passwordController.text.length < 8) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const DefaultAlert(
                                        title: 'Error occured', content: 'Password must be at least 8 characters');
                                  },
                                );

                                return;
                              }

                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                )
                                    .then((value) {
                                  GoRouter.of(context).go(IRouteConfig.initial);
                                });
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const DefaultAlert(
                                      title: 'Error occured',
                                      content: 'User may be not verified or email or password is wrong',
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text('Login'),
                          ),
                        ),
                        SizedBox(width: kDefaultPadding.top),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              GoRouter.of(context).push(IRouteConfig.register);
                            },
                            child: const Text('Register'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 3),
                  const Text(
                    'Crack The Roll v0.0.1-alpha',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  SizedBox(height: kLargePadding.top),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
