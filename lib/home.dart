import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class HomeScreen extends StatefulWidget{
  HomeScreen({super.key});
  @override
  _HomeScreeenState createState() => _HomeScreeenState();
}


class _HomeScreeenState extends State<HomeScreen>{

  final List<Map<String, String>> _flashcards = []; // List to store flashcard data

  final TextEditingController _frontController = TextEditingController();
  final TextEditingController _backController = TextEditingController();

  //below function is for dialog box of add new card

  void _showDialogBox(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Add New Flash Card'),
      content: Container(
        height: 100,
        width: 100,
        child: Column(
          children: [
            TextField(
              controller: _frontController,
                decoration: InputDecoration(labelText: 'Question'),
            ),
            TextField(
              controller: _backController,
              decoration: InputDecoration(labelText: 'Answer'),
            ),
          ],
        ),
      ),
      actions: [
      TextButton(
      onPressed: _addFlashcard,
      child: Text('Add'),
    ),
      ],
    ),
    );
  }

  // Method to add a new flashcard
  void _addFlashcard() {
    if (_frontController.text.isNotEmpty && _backController.text.isNotEmpty) {
      setState(() {
        _flashcards.add({
          'front': _frontController.text,
          'back': _backController.text,
        });
      });
      _frontController.clear();
      _backController.clear();
      Navigator.pop(context); // Close the dialog
    }
  }

  //below function is for delete conformation to the user for remove flashcard
  void _confirmDeleteFlashcard(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Flashcard'),
        content: Text('Are you sure you want to delete this flashcard?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel deletion
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _flashcards.removeAt(index);
              });
              Navigator.pop(context); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  //below function is created for the edit the flash card

  void _editFlashcard(int index) {
    _frontController.text = _flashcards[index]['front']!;
    _backController.text = _flashcards[index]['back']!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Flashcard'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _frontController,
              decoration: InputDecoration(labelText: 'Front Text'),
            ),
            TextField(
              controller: _backController,
              decoration: InputDecoration(labelText: 'Back Text'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _flashcards[index] = {
                  'front': _frontController.text,
                  'back': _backController.text,
                };
              });
              _frontController.clear();
              _backController.clear();
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
           GridView.builder(
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
              // mainAxisSpacing: 2,
              // crossAxisSpacing: 2,
               //childAspectRatio: 2/3,
             ),
             itemCount: _flashcards.length,
             itemBuilder: (context, index) {
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     SizedBox(
                       height: 300,
                       width: 200,
                       child: FlipCard(
                         fill: Fill.fillBack,
                         direction: FlipDirection.HORIZONTAL,
                         side: CardSide.FRONT,
                         front: Container(
                           height: 300,
                           width: 200,
                           decoration: BoxDecoration(
                             color: Colors.black12,
                             borderRadius: BorderRadius.circular(15), // Rounded corners
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                                 spreadRadius: 2,
                                 blurRadius: 5,
                                 //offset: Offset(0, 3), // Offset of shadow
                               ),
                             ],
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Center(
                               child: Text(
                                 _flashcards[index]['front'] ?? '',
                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                 textAlign: TextAlign.center,
                               ),
                             ),
                           ),
                         ),
                         back: Container(
                           decoration: BoxDecoration(
                             gradient: LinearGradient(
                               colors: [Colors.blue.shade300, Colors.blue.shade700],
                               begin: Alignment.topLeft,
                               end: Alignment.bottomRight,
                             ),
                             borderRadius: BorderRadius.circular(15),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.5),
                                 spreadRadius: 2,
                                 blurRadius: 5,
                                 offset: Offset(0, 3),
                               ),
                             ],
                           ),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text(
                                 _flashcards[index]['back'] ?? '',
                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                 textAlign: TextAlign.center,
                               ),
                               const SizedBox(height: 16),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   IconButton(
                                     icon: Icon(Icons.edit, color: Colors.white),
                                     onPressed: () => _editFlashcard(index),
                                   ),
                                   IconButton(
                                     icon: Icon(Icons.delete, color: Colors.redAccent),
                                     onPressed: () => _confirmDeleteFlashcard(index),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               );
             },
           ),

      floatingActionButton: FloatingActionButton(onPressed: _showDialogBox , child: Icon(Icons.add),),

    );


  }
}