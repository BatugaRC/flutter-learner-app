class FirestoreData {
  final String title;
  final int length;
  final String? creator;
  final String docId;

  FirestoreData({this.creator, required this.docId, required this.title, required this.length});
}
