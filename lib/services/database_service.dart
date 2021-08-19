import 'package:bebkeler/models/game_data.dart';
import 'package:bebkeler/models/setting_data.dart';
import 'package:bebkeler/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // !MATH NINJA
  final CollectionReference mnSettingsCollection =
      FirebaseFirestore.instance.collection('mathNinjaSettings');

  final CollectionReference mnGameDataCollection =
      FirebaseFirestore.instance.collection('mathNinjaGameData');

  Future<void> updateMnSettings(
      int difficulty,
      int numberOfQuestions,
      bool isAddition,
      bool isSubtraction,
      bool isMultiplication,
      bool isDivision) async {
    return await mnSettingsCollection.doc(uid).set({
      'mn_difficulty': difficulty,
      'mn_number_of_questions': numberOfQuestions,
      'mn_is_addition': isAddition,
      'mn_is_subtraction': isSubtraction,
      'mn_is_multiplication': isMultiplication,
      'mn_is_division': isDivision,
    });
  }

  Future<void> updateMnGameData(
      String username, int gamesPlayed, int points, double ratio) async {
    return await mnGameDataCollection.doc(uid).set({
      'mn_username': username,
      'mn_games_played': gamesPlayed,
      'mn_points': points,
      'mn_ratio': ratio,
    });
  }

  MNUserSettings _mnUserSettingsFromSnapshot(DocumentSnapshot snapshot) {
    return MNUserSettings(
      uid: uid,
      mnDifficulty: snapshot.get('mn_difficulty'),
      mnNumberOfQuestions: snapshot.get('mn_number_of_questions'),
      mnIsAddition: snapshot.get('mn_is_addition'),
      mnIsSubtraction: snapshot.get('mn_is_subtraction'),
      mnIsMultiplication: snapshot.get('mn_is_multiplication'),
      mnIsDivision: snapshot.get('mn_is_division'),
    );
  }

  MNUserGameData _mnUserGameDataFromSnapshot(DocumentSnapshot snapshot) {
    return MNUserGameData(
        uid: uid,
        mnGamesPlayed: snapshot.get('mn_games_played'),
        mnPoints: snapshot.get('mn_points'),
        mnRatio: snapshot.get('mn_ratio'));
  }

  Stream<MNUserSettings> get getMnUserSettings {
    return mnSettingsCollection
        .doc(uid)
        .snapshots()
        .map(_mnUserSettingsFromSnapshot);
  }

  Stream<MNUserGameData> get getMnUserGameData {
    return mnGameDataCollection
        .doc(uid)
        .snapshots()
        .map(_mnUserGameDataFromSnapshot);
  }

  List<MNSettings> _mnSettingsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MNSettings(
        mnDifficulty: doc.get('mn_difficulty') ?? 1,
        mnNumberOfQuestions: doc.get('mn_number_of_questions') ?? 5,
        mnIsAddition: doc.get('mn_is_addition') ?? true,
        mnIsSubtraction: doc.get('mn_is_subtraction') ?? false,
        mnIsMultiplication: doc.get('mn_is_multiplication') ?? false,
        mnIsDivision: doc.get('mn_is_division') ?? false,
      );
    }).toList();
  }

  List<MNGameData> _mnGameDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MNGameData(
        mnGamesPlayed: doc.get('mn_games_played') ?? 0,
        mnPoints: doc.get('mn_points') ?? 0,
        mnRatio: doc.get('mn_ratio') ?? 0,
      );
    }).toList();
  }

  Stream<List<MNSettings>> get getMnSettings {
    return mnSettingsCollection.snapshots().map(_mnSettingsFromSnapshot);
  }

  Stream<List<MNGameData>> get getMnGameData {
    return mnGameDataCollection.snapshots().map(_mnGameDataFromSnapshot);
  }

  getMnLeaderboardData() {
    return FirebaseFirestore.instance
        .collection('mathNinjaGameData')
        .orderBy('mn_points', descending: true)
        .limit(10)
        .get();
  }

  // !SPELLING BEE
  final CollectionReference sbSettingsCollection =
      FirebaseFirestore.instance.collection('spellingBeeSettings');

  final CollectionReference sbGameDataCollection =
      FirebaseFirestore.instance.collection('spellingBeeGameData');

  Future<void> updateSBSettings(int difficulty, int numberOfQuestions) async {
    return await sbSettingsCollection.doc(uid).set({
      'sb_difficulty': difficulty,
      'sb_number_of_questions': numberOfQuestions,
    });
  }

  Future<void> updateSbGameData(
      String username, int gamesPlayed, int points, double ratio) async {
    return await sbGameDataCollection.doc(uid).set({
      'sb_username': username,
      'sb_games_played': gamesPlayed,
      'sb_points': points,
      'sb_ratio': ratio,
    });
  }

  SBUserSettings _sbUserSettingsFromSnapshot(DocumentSnapshot snapshot) {
    return SBUserSettings(
      uid: uid,
      sbDifficulty: snapshot.get('sb_difficulty'),
      sbNumberOfQuestions: snapshot.get('sb_number_of_questions'),
    );
  }

  SBUserGameData _sbUserGameDataFromSnapshot(DocumentSnapshot snapshot) {
    return SBUserGameData(
        uid: uid,
        sbGamesPlayed: snapshot.get('sb_games_played'),
        sbPoints: snapshot.get('sb_points'),
        sbRatio: snapshot.get('sb_ratio'));
  }

  Stream<SBUserSettings> get getSbUserSettings {
    return sbSettingsCollection
        .doc(uid)
        .snapshots()
        .map(_sbUserSettingsFromSnapshot);
  }

  Stream<SBUserGameData> get getSbUserGameData {
    return sbGameDataCollection
        .doc(uid)
        .snapshots()
        .map(_sbUserGameDataFromSnapshot);
  }

  List<SBSettings> _sbSettingsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SBSettings(
        sbDifficulty: doc.get('sb_difficulty') ?? 1,
        sbNumberOfQuestions: doc.get('sb_number_of_questions') ?? 10,
      );
    }).toList();
  }

  List<SBGameData> _sbGameDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SBGameData(
        sbGamesPlayed: doc.get('sb_games_played') ?? 0,
        sbPoints: doc.get('sb_points') ?? 0,
        sbRatio: doc.get('sb_ratio') ?? 0,
      );
    }).toList();
  }

  Stream<List<SBSettings>> get getSbSettings {
    return sbSettingsCollection.snapshots().map(_sbSettingsFromSnapshot);
  }

  Stream<List<SBGameData>> get getSbGameData {
    return sbGameDataCollection.snapshots().map(_sbGameDataFromSnapshot);
  }

  getSbLeaderboardData() {
    return FirebaseFirestore.instance
        .collection('spellingBeeGameData')
        .orderBy('sb_points', descending: true)
        .limit(10)
        .get();
  }
}
