class UserData {
  final String uid;
  final String? profileImage;
  final String email;
  final String phoneNumber;
  final String displayName;

  UserData({
    required this.uid,
    this.profileImage,
    required this.email,
    required this.phoneNumber,
    required this.displayName,
  });
}
