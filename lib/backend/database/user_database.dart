import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urjaa/models/user_data.dart';

class UserDatabase {
  final String uid;
  UserDatabase({required this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(
    'users',
  );

  UserData _userDataParser(DocumentSnapshot doc) {
    final userData = doc.data() as Map<String, dynamic>;
    return UserData(
      displayName: userData['display_name'],
      email: userData['email'],
      phoneNumber: userData['phone_number'],
      uid: uid,
      profileImage: userData['profile_image_url'],
    );
  }

  Stream<UserData> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataParser);
  }
}
