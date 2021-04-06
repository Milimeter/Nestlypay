import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investment_app/utils/colors.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _descriptionTextEditingController =
      TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget proceed() => Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(14)),
        child: Center(
            child: AutoSizeText(
          "Next",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        )),
      );
  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  void validateAndSubmit() async {
    if (_validateAndSave()) {
      setState(() {
        _isLoading = true;
      });
      try {
        FirebaseFirestore.instance.collection("posts").doc().set({
          "Title": _titleTextEditingController.text,
          "Description": _descriptionTextEditingController.text,
          "timeStamp": DateTime.now(),
        });
        Get.snackbar(
        "Success",
        "Post Uploaded",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        duration: Duration(seconds: 5),
      );
      } catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: UniversalColors.whiteColor,
        leading: Container(
          margin: EdgeInsets.only(left: 9),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue[800]),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title:
            AutoSizeText("Create Post", style: TextStyle(color: Colors.black)),
      ),
      body: Stack(
        children: [
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset("assets/images/post.png"),
                      SizedBox(height: 20),
                      AutoSizeText(
                        "What is your post title",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextFormField(
                        controller: _titleTextEditingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Post Title",
                          labelText: "Post Title",
                        ),
                      ),
                      SizedBox(height: 20),
                      AutoSizeText(
                        "Briefly describe your post",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextFormField(
                        controller: _descriptionTextEditingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "e.g advert"),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => validateAndSubmit(),
                        child: proceed(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
