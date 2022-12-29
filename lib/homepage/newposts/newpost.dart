import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/component.dart';
import 'package:social_app/homepage/cubit/cubit.dart';
import 'package:social_app/homepage/cubit/state.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  TextEditingController postText = TextEditingController();
  TextEditingController contentText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialCubit()..getUserData(),
        child: BlocConsumer<SocialCubit, Socialstates>(
          listener: (context, state) {},
          builder: (context, state) {

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                titleSpacing: 0,
                actions: [
                  defaultTextButton(
                      function: () {
                        var now = DateTime.now();

                        if (SocialCubit.get(context).postimage == null) {
                          SocialCubit.get(context).createPost(
                              dateTime: now.toString(), text: postText.text,content: contentText.text);
                        } else {
                          SocialCubit.get(context).uploadPostImage(
                              dataname: now.toString(), text: postText.text,content: contentText.text);
                        }
                      },
                      text: 'post')
                ],
              ),
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [

                      SizedBox(
                        height: 10,
                      ),

                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: postText,
                              decoration: InputDecoration(
                                hintText: 'what is on your mind.....',
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                            SizedBox(height: 4,),
                            TextFormField(
                              controller: contentText,
                              decoration: InputDecoration(
                                hintText: 'what is on your content.....',
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (SocialCubit.get(context).postimage != null)
                        Stack(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 300,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        image: DecorationImage(
                                            image: FileImage(
                                                SocialCubit.get(context)
                                                    .postimage!),
                                            fit: BoxFit.cover)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 20,
                                      child: IconButton(
                                          onPressed: () {
                                            SocialCubit.get(context)
                                                .removePostImage();

                                            print('change personal photo');
                                          },
                                          icon: Icon(
                                            Icons.close_sharp,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextButton(
                                onPressed: () {
                                  SocialCubit.get(context).getPostImage();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera_alt),
                                    SizedBox(width: 7),
                                    Text('add photo')
                                  ],
                                )),
                          ),
                          SizedBox(
                            width: 140,
                          ),
                          TextButton(onPressed: () {}, child: Text('#Tags')),
                        ],
                      )
                    ],
                  )),
              
            );
          },
        ));
  }
}
