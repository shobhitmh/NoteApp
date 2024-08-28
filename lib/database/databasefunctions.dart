import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';

create(String notes) async {
  await FirebaseFirestore.instance
      .collection('Usernotes')
      .add({'Notes': notes});
}

delete(String collname, String docid) async {
  await FirebaseFirestore.instance.collection(collname).doc(docid).delete();
  print('Deleted');
}

updat(String docid, var fielsname, String text) async {
  await FirebaseFirestore.instance
      .collection('Usernotes')
      .doc(docid)
      .update({fielsname: text});
  print("///Updated///");
}
