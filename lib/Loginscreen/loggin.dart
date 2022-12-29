import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/Loginscreen/cubit/cubit.dart';
import 'package:social_app/Loginscreen/cubit/state.dart';
import 'package:social_app/Signupscreen/signup.dart';

import '../component/component.dart';
import '../homepage/homescreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);


  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context,state){

          if(state is SocialLoginErrorState){
            print('Error');
            Fluttertoast.showToast(msg: state.error);
          }
          if(state is SocialLoginSuccessState)
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen()),
              );

            }


        },
        builder:(context,state){
          return Scaffold(
            body: Padding(
              padding:  EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Image(image: AssetImage('assets/images/c.png'))),
                    SizedBox(height: 20,),
                    Text('LOGIN',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text('login now to browser our hot offers',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.grey,fontSize: 18
                      ),

                    ),
                    SizedBox(height: 30,),
                    defaultFormField(
                      controller: emailcontroller,
                      type: TextInputType.emailAddress,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                        {
                          return 'please enter your email address';
                        }

                      },
                      label: 'Email Address',
                      prefix: Icons.email,

                    ),
                    SizedBox(height: 15.0),
                    defaultFormField(
                      controller: passwordcontroller,
                      type: TextInputType.emailAddress,
                      suffix: Icons.visibility,
                      suffixPressed: (){},
                      validate: (String value)
                      {
                        if(value.isEmpty)
                        {
                          return 'please enter your password';
                        }

                      },
                      label: 'Password',
                      prefix: Icons.lock_outline,

                    ),
                    SizedBox(height: 30.0),
                    defaultButton(
                        function: (){
                          if (formkey.currentState!.validate())
                          {
                            SocialLoginCubit.get(context).userLogin(

                                email: emailcontroller.text,
                                password: passwordcontroller.text,);



                        }

                    }, text: 'Login',isUpperCase: true),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Text('Dont Have anAccount ?',style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 25,
                          width: 27,
                          child: FloatingActionButton(

                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>SignupScreen()),
                              );
                            },
                            child: Icon(Icons.arrow_forward_ios,size: 14,),
                          ),
                        ),


                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
