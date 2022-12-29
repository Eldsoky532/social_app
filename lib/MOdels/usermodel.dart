class SocialUserModel {
  String? fristname;
  String? lastname;
  String? email;
  String? uid;
  bool? isEmailverify;
  String? image;
  String? bio;
  String? coverr;

  SocialUserModel(
      {required this.fristname,
      required this.lastname,
      required this.email,
      required this.uid,
      required this.isEmailverify,
      required this.image,
      required this.bio,
      required this.coverr});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    fristname = json['fristname'];
    lastname = json['lastname'];
    email = json['email'];
    uid = json['uid'];
    isEmailverify = json['isEmailverify'];
    image = json['image'];
    bio = json['bio'];
    coverr = json['cover'];
  }

  Map<String, dynamic> toMap() {
    return {
      'fristname': fristname,
      'lastname': lastname,
      'email': email,
      'uid': uid,
      'isEmailverify': isEmailverify,
      'image': image,
      'bio': bio,
      'cover': coverr
    };
  }
}
