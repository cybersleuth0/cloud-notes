import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notes_firebase_app/Bloc/notes_bloc.dart';
import 'package:notes_firebase_app/Bloc/notes_event.dart';
import 'package:notes_firebase_app/Constants/appConstants.dart';
import 'package:notes_firebase_app/Model/Models.dart';

import '../Bloc/notes_state.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  final List<Map<String, dynamic>> _colorsAndbordercolor = [
    {
      //"backcolor": Color(0xfff8a44c),
      "backcolor": Color(0xffffab91),
    },
    {"backcolor": Color(0xffffcc80)},
    {"backcolor": Color(0xffe7ed9b)},
    {"backcolor": Color(0xffcf94da)},
    {"backcolor": Color(0xff81deea)},
    {"backcolor": Color(0xfff48fb1)},
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  // FirebaseFirestore? firebaseFirestore;
  // CollectionReference? collRef;

  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(GetInitialNotesEvent());
    // firebaseFirestore = FirebaseFirestore.instance;
    // collRef = firebaseFirestore!.collection("notes");
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }

  DateFormat df = DateFormat.yMMMEd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Notes",
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black38,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade800.withOpacity(0.7),
            //     borderRadius: BorderRadius.circular(15),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.3),
            //         spreadRadius: 1,
            //         blurRadius: 5,
            //         offset: const Offset(0, 3),
            //       ),
            //     ],
            //   ),
            //   child: const Icon(Icons.search, size: 28, color: Colors.white),
            // ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff252525), Color(0xff353535)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is NoteFailureState) {
              return Center(child: Text(state.errorMessage));
            }
            if (state is NoteSuccessState) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: state.notes.length,
                itemBuilder: (contex, index) {
                  var date = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(state.notes[index].createdAT),
                  );
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          contex, App_Routes.ROUTE_DETAILSPAGE, arguments: {
                        "note": state.notes[index]
                      });
                      // Navigator.pushNamed(
                      //   context,
                      //   "/detailspage",
                      //   arguments: {
                      //     "title": allnotes[index].nTitle,
                      //     "desc": allnotes[index].nDesc,
                      //     "id": allnotes[index].nId,
                      //     "date": allnotes[index].nCreatedat,
                      //   },
                      // );
                      // setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:
                            _colorsAndbordercolor[Random().nextInt(
                              _colorsAndbordercolor.length,
                            )]["backcolor"],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              state.notes[index].title,
                              maxLines: 2,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            flex: 2,
                            child: Text(
                              state.notes[index].desc,
                              maxLines: 4,
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              df.format(date),
                              style: GoogleFonts.sourceSans3(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
            // : Center(
            // child: Text(
            // "No Notes Found. Tap '+' to add one!",
            // style: GoogleFonts.lato(
            // textStyle: const TextStyle(
            // color: Colors.white70,
            // fontSize: 18,
            // ),
            // ),
            // ),
            // );
          },
        ),
      ),
      floatingActionButton: StatefulBuilder(
        builder: (ctx, ss) {
          return FloatingActionButton(
            backgroundColor: _colorsAndbordercolor[1]["backcolor"],
            onPressed: () async {
              showModalBottomSheet(
                context: ctx,
                isScrollControlled: true,
                backgroundColor: Color(0xff252525),
                builder: (_) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Container(
                              height: 8,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Add Notes",
                            style: GoogleFonts.pacifico(
                              textStyle: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: titleController,
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            decoration: InputDecoration(
                              hintText: "Notes Title",
                              hintStyle: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              //enabledBorder Means when we don't click on the input field
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              //focusedBorder Means when we click on the input field
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightGreenAccent,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextField(
                            controller: descController,
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Notes Description",
                              hintStyle: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              //enabledBorder Means when we don't click on the input field
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              //focusedBorder Means when we click on the input field
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightGreenAccent,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent
                                      .withOpacity(0.7),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  side: const BorderSide(
                                    color: Colors.greenAccent,
                                    width: 2,
                                  ),
                                ),
                                onPressed: () async {
                                  if (titleController.text.isNotEmpty &&
                                      descController.text.isNotEmpty) {
                                    context.read<NoteBloc>().add(
                                      AddNoteEvent(
                                        noteModel: NoteModel(
                                          title: titleController.text.trim(),
                                          desc: descController.text.trim(),
                                          createdAT: DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString(),
                                        ),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Note Added Successfully!",
                                        ),
                                      ),
                                    );
                                    titleController.clear();
                                    descController.clear();
                                  }

                                  // Close the bottom sheet after adding the note
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Add Notes",
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.redAccent.withOpacity(
                                    0.7,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  side: const BorderSide(
                                    color: Colors.redAccent,
                                    width: 2,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.add, size: 30, color: Colors.black),
          );
        },
      ),
    );
  }
}
