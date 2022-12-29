abstract class Socialstates {}

class SocialInitialState extends Socialstates {}

class SocialGetUserLoadingState extends Socialstates {}

class SocialGetUserSuccessState extends Socialstates
{

}

class SocialGetUserErrorState extends Socialstates
{
  final String error;

  SocialGetUserErrorState(this.error);
}
class SocialChangeBottomNav extends Socialstates{}


class SocialProfileImagePickedSuccessState extends Socialstates{}


class SocialProfileImagePickedErroState extends Socialstates{}



class ChangerCoverImageSuccessState extends Socialstates{}



class ChangerCoverImageErrorState extends Socialstates{}



class ChangerProfileImageSuccessState extends Socialstates{}



class ChangerProfileImageErrorState extends Socialstates{}



class UpdateProfileImageSuccessState extends Socialstates{}



class UpdateProfileImageErrorState extends Socialstates{}



class UpdateCoverImageSuccessState extends Socialstates{}



class UpdateCoverImageErrorState extends Socialstates{}



class UpdateUserDataLoadingState extends Socialstates{}


class UpdateUserDatasucessState extends Socialstates{}

class UpdateUserDataErrorState extends Socialstates{}



//post


class SocialCreatePostLoadingState extends Socialstates{}
class SocialCreatePostSuccessState extends Socialstates{}
class SocialCreatePostErrorState extends Socialstates{}

class SocialGetPostloadingState extends Socialstates{}

class SocialGetPostSuccessState extends Socialstates{}
class SocialGetPostErrorState extends Socialstates{}



class SocialGetLikesLoadingState extends Socialstates{}
class SocialGetLikesSuccessState extends Socialstates{}
class SocialGetLikesErrorState extends Socialstates{

  final String error;
  SocialGetLikesErrorState(this.error);
}


class SocialGetAllUserSuccessState extends Socialstates{}
class SocialGetAllUserErrorState extends Socialstates {

  final String error;

  SocialGetAllUserErrorState(this.error);
}


class ChangerPostImageSuccessState extends Socialstates{}
class ChangerPostImageErrorState extends Socialstates{}





class ChangerPostImagePickedsucessState extends Socialstates{}
class ChangerPostImagePickedErrorState extends Socialstates{}







class SocialRemovePostImageSuccessState extends Socialstates{}



//Message States

class SocialSendMessageSuccessState extends Socialstates{}

class SocialSendMessageErrorState extends Socialstates{}

class SocialGetMessageSuccessState extends Socialstates{}

class SocialGetMessageErrorState extends Socialstates{}



