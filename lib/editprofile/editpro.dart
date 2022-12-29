import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/homepage/bottomnav/setting/setting.dart';
import 'package:social_app/homepage/cubit/cubit.dart';
import 'package:social_app/homepage/cubit/state.dart';
import 'dart:io';
import '../component/component.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  TextEditingController changeUserNameController = TextEditingController();

  TextEditingController changeUserBioController = TextEditingController();

  TextEditingController changeUserPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, Socialstates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = SocialCubit
            .get(context)
            .userModel!;

        var coverImage = SocialCubit
            .get(context)
            .coverimage;

        var profileImage = SocialCubit
            .get(context)
            .proimage;


        changeUserNameController.text = model.fristname!;

        changeUserBioController.text = model.bio!;

        changeUserPhoneController.text = model.lastname!;

        return ConditionalBuilder(
          condition: model != null,
          builder: (context) =>
              Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0.0,
                  iconTheme: const IconThemeData(color: Colors.black),
                  title: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                  titleSpacing: 0,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: defaultTextButton(
                        function: () {
                          SocialCubit.get(context).updateUserProfile(
                              name: changeUserNameController.text,
                              lastname: changeUserPhoneController.text,
                              bio: changeUserBioController.text);
                        },
                        text: 'Save',
                      ),
                    ),
                  ],
                  automaticallyImplyLeading: true,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is UpdateUserDataLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          child: Stack(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(3),
                                          image: DecorationImage(
                                              image: coverImage != null
                                                  ? FileImage(coverImage)
                                                  : NetworkImage(model.coverr!)
                                              as ImageProvider,
                                              fit: BoxFit.cover)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 20,
                                        child: IconButton(
                                            onPressed: () {
                                              SocialCubit.get(context)
                                                  .getCoverImage();

                                              print('change personal photo');
                                            },
                                            icon: Icon(
                                              Icons.camera_alt_outlined,
                                              color: Colors.black,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 57,
                                    child: CircleAvatar(
                                      backgroundImage: profileImage != null
                                          ? FileImage(profileImage)
                                          : NetworkImage(model.image!)
                                      as ImageProvider,
                                      radius: 55,
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20,
                                    child: IconButton(
                                        onPressed: () {
                                          SocialCubit.get(context)
                                              .getProfileImage();

                                          print('change personal photo');
                                        },
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      if (SocialCubit
                          .get(context)
                          .proimage != null ||
                          SocialCubit
                              .get(context)
                              .coverimage != null)
                        Row(
                          children: [
                            if (SocialCubit
                                .get(context)
                                .proimage != null)
                              Expanded(
                                child: Column(
                                  children: [
                                    defaultTextButton(
                                      text: 'Upload profile image',
                                      function: () {
                                        SocialCubit.get(context)
                                            .uploadProfileImage(
                                            name: changeUserNameController
                                                .text,
                                            lastname:
                                            changeUserPhoneController
                                                .text,
                                            bio: changeUserBioController
                                                .text);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(width: 5),
                            if (SocialCubit
                                .get(context)
                                .coverimage != null)
                              Expanded(
                                child: Column(
                                  children: [
                                    defaultTextButton(
                                      text: 'Upload cover image',
                                      function: () {
                                        SocialCubit.get(context)
                                            .uploadCoverImage(
                                            name: changeUserNameController
                                                .text,
                                            lastname:
                                            changeUserPhoneController
                                                .text,
                                            bio: changeUserBioController
                                                .text);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.name,
                          controller: changeUserNameController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            label: Text('User Name',
                                style: TextStyle(color: Colors.black)),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Name';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.phone,
                          controller: changeUserPhoneController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            label: Text('Phone'),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.blue,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Phone';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.text,
                          controller: changeUserBioController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            label: Text('Bio...',
                                style: TextStyle(color: Colors.black)),
                            prefixIcon: Icon(
                              Icons.beenhere,
                              color: Colors.blue,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Bio...';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          fallback: (context) =>
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey.shade400,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        );
      },
    );
  }
}
