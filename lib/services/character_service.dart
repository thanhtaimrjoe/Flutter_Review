import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:yamabi_admin/modal/character.dart';

class CharacterService {
  Stream<QuerySnapshot> fetchRealtimeCharacters(String productID) {
    return FirebaseFirestore.instance
        .collection('character')
        .where('productID', isEqualTo: productID)
        .snapshots();
  }

  Future<String> addNewCharacter(Character character, String docID) async {
    try {
      await FirebaseFirestore.instance.collection("character").doc(docID).set({
        'characterID': character.characterID,
        'productID': character.productID,
        'image': character.image,
        'name': character.name,
      });
      return 'Add New Character successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }

  Future<int> getCharactersLength(String productID) {
    return FirebaseFirestore.instance
        .collection('character')
        .where('productID', isEqualTo: productID)
        .get()
        .then((events) => events.docs.length);
  }

  Future<String> deleteCharacter(String characterID, String imageURL) async {
    try {
      await FirebaseFirestore.instance
          .collection("character")
          .where('characterID', isEqualTo: characterID)
          .get()
          .then((events) => events.docs[0].reference.delete());
      FirebaseStorage.instance.refFromURL(imageURL).delete();
      return 'Delete character successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }

  Future<String> updateCharacter(String name, String docID) async {
    try {
      await FirebaseFirestore.instance
          .collection("character")
          .doc(docID)
          .update({
        'name': name,
      });
      return 'Update successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }
}
