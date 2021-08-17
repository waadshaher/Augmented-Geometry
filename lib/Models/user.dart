class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String fullName;
  final String email;
  final int userRole;
  dynamic pfp;

  UserData({this.uid, this.email, this.fullName, this.pfp, this.userRole});
}
