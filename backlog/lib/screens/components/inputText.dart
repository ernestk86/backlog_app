import '../../packages.dart';

String title, genre, notes;

//Save input text
Flexible inputText(String field, int flexValue) {
  return Flexible(
    flex: flexValue,
    child: TextFormField(                   
      autofocus: true,
      decoration: InputDecoration(labelText: field),
      onSaved: (value) {
        if (value.isNotEmpty) {
          if (field == 'Title') {
            title = value;
          } else if (field == 'Genre') {
            genre = value;
          } else if (field == 'Notes') {
            notes = value;
          }
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          if (field == 'Title') {
            return 'Title';
          } else if (field == 'Genre') {
            return 'Genre';
          } else if (field == 'Notes') {
            return 'Notes';
          }
        } else {
          return null;
        }
      },
    ),
  );    
}