import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motus_flutter/data/entities/word/word.dart';

class WordFireStore {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static WordFireStore? _instance;

  late final CollectionReference<Word> _wordRef;

  static WordFireStore? getInstance() {
    if(_instance == null) {
      _firestore.collection('words').withConverter<Word>(
          fromFirestore: (snapshot, _) => Word.fromJson(snapshot.data()!),
          toFirestore: (word, _) => word.toJson()
      );
      _instance = WordFireStore._();
    }
    return _instance!;
  }

  WordFireStore._();

  Future<void> insertWord(Word word) async {
    await _wordRef.add(word);
    return;
  }

  Future<void> insertWordWithId(Word word, String id) async {
    await _wordRef.doc(id).set(word, SetOptions(merge: true));
    return;
  }

  Future<QuerySnapshot<Word>> searchWords(String word) async {
    return await _wordRef.where('word', isEqualTo: word).get();
  }

  Future<QuerySnapshot<Word>> getAllWords() async {
    return await _wordRef.get();
  }

  Future<void> deleteWord(String id) async {
    await _wordRef.doc(id).delete();
    return;
  }
}