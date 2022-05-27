import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motus_flutter/data/entities/word/word.dart';

class WordFireStore {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static WordFireStore? _instance;

  static late final CollectionReference<Word> _wordRef;

  static WordFireStore? getInstance() {
    if(_instance == null) {
      _wordRef = _firestore.collection('words').withConverter<Word>(
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
    return _wordRef.doc(id).set(word,SetOptions(merge: true));
  }

  Future<void> updateWord(Word word, String id) async {
    _wordRef.doc(id).update(word.toJson());
  }

  Future<QuerySnapshot<Word>> searchWords(Word word) async {
    return _wordRef.where('word',isEqualTo: word).get();
  }

  Future<void> deleteWord(String id) async {
    return _wordRef.doc(id).delete();
  }

  Future<QuerySnapshot<Word>> getAll() async {
    return _wordRef.get();
  }
}