import 'package:argeometry/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final FirebaseAuth auth = FirebaseAuth.instance;

  deleteAccount() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    DocumentReference documentReference =
        Firestore.instance.collection("users").document(uid);

    await FirebaseAuth.instance.signOut();
    return await documentReference.delete();
  }

  final CollectionReference usersCollection =
      Firestore.instance.collection("users");
  Future updateUserData(String userID, String fullName, String email,
      int userRole, dynamic pfp) async {
    return await usersCollection.document(uid).setData({
      'fullName': fullName,
      'email': email,
      'userRole': userRole,
      'userID': userID,
      'profilePic': pfp
    });
  }

  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      fullName: snapshot.data['fullName'],
      email: snapshot.data['email'],
      userRole: snapshot.data['email'],
      pfp: snapshot.data['email'],
    );
  }

  Stream<UserData> get userData {
    return Firestore.instance
        .collection('users')
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  Future<void> addQuizData(Map quizData, String quizId) async {
    await Firestore.instance
        .collection("quiz")
        .document(quizId)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addStatData(Map statData, String statId) async {
    await Firestore.instance
        .collection("stats")
        .document(statId)
        .setData(statData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    await Firestore.instance
        .collection("quiz")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addSingleStatData(Map singleStatData, String statId) async {
    await Firestore.instance
        .collection("stats")
        .document(statId)
        .collection("singleStat")
        .add(singleStatData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizDataVisibilityTrue() async {
    return await Firestore.instance
        .collection("quiz")
        .where("visibility", isEqualTo: true)
        .snapshots();
  }

  getQuizDataVisibilityFalse() async {
    return await Firestore.instance
        .collection("quiz")
        .where("visibility", isEqualTo: false)
        .snapshots();
  }

  getStatData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return await Firestore.instance
        .collection("stats")
        .where("userID", isEqualTo: uid)
        .snapshots();
  }

  getProfileData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return await Firestore.instance
        .collection("users")
        .where("userID", isEqualTo: uid)
        .snapshots();
  }

  getQuestionData(String quizId) async {
    return await Firestore.instance
        .collection("quiz")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  getStatCollection(String statId) async {
    return await Firestore.instance
        .collection("stats")
        .document(statId)
        .collection("singleStat")
        .getDocuments();
  }

  getStudentsData() async {
    return await Firestore.instance
        .collection("users")
        .where('userRole', isEqualTo: 2)
        .snapshots();
  }

  Future<List<QuizStudent>> getListOfQuizStudentData(String uid) async {
    final QuerySnapshot result =
        await Firestore.instance.collection('stats').getDocuments();

    final List<DocumentSnapshot> documents = result.documents;
    var x = await Future.wait(documents.map((element) async {
      String image = element.data['imgUrl'];
      String title = element.data['quizTitle'];
      var docs = await Firestore.instance
          .collection('stats')
          .document(element.documentID)
          .collection("singleStat")
          .where('userID', isEqualTo: uid)
          .orderBy("orderVal", descending: false)
          .getDocuments();
      return new QuizStudent(
          results: docs.documents, imgUrl: image, name: title);
    }).toList());

    return x;
  }

  getStatsData(String statId) async {
    return await Firestore.instance
        .collection("stats")
        .document(statId)
        .collection("singleStat")
        .getDocuments();
  }
}

class QuizStudent {
  String name, imgUrl;
  List<DocumentSnapshot> results;
  QuizStudent({this.name, this.imgUrl, this.results});
}
