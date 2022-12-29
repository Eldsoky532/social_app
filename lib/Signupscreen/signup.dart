import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Signupscreen/cubit/cubit.dart';
import 'package:social_app/Signupscreen/cubit/state.dart';
import 'package:social_app/homepage/homescreen.dart';

import '../Loginscreen/loggin.dart';
import '../component/component.dart';

class SignupScreen extends StatelessWidget {
  TextEditingController fristnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>SocialRegisterCubit(),
        child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
          listener: (context,state){
            if(state is SocialCreateUserSucessstate){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen()),
              );
            }
          },
          builder: (context,state){
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image(
                            height: 200,
                            width: 380,
                            image: AssetImage('assets/images/ccc.png')),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Sign up  now to browser our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.grey, fontSize: 18),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            defaultFormField(
                              controller: fristnamecontroller,
                              type: TextInputType.name,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter your Frist Name';
                                }
                              },
                              label: 'Frist Name',
                              prefix: Icons.account_box_outlined,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            defaultFormField(
                              controller: lastnamecontroller,
                              type: TextInputType.name,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter your Last Name';
                                }
                              },
                              label: 'Last Name',
                              prefix: Icons.account_box_outlined,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            defaultFormField(
                              controller: emailcontroller,
                              type: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter your email address';
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email,
                            ),
                            SizedBox(height: 15.0),
                            defaultFormField(
                              controller: passwordcontroller,
                              type: TextInputType.number,
                              suffix: Icons.visibility,
                              suffixPressed: () {},
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter your password';
                                }
                              },
                              label: 'Password',
                              prefix: Icons.lock_outline,
                            ),
                            SizedBox(height: 30.0),
                            defaultButton(
                                function: () {
                                  if (formkey.currentState!.validate())
                                  {
                                  SocialRegisterCubit.get(context).userRegister(
                                      FristName:fristnamecontroller.text ,
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text,
                                      SecondName: lastnamecontroller.text);
                                  }

                                },
                                text: 'Register',
                                isUpperCase: true),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Have  an Account ?',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Spacer(),
                                SizedBox(
                                  height: 25,
                                  width: 27,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
