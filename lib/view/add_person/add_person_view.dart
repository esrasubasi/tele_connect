// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tele_connect/view/add_person/add_person_view_model.dart';


void main() {
  runApp(PersonView());
}

class PersonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PersonApp(),
    );
  }
}

class PersonApp extends StatefulWidget {
  @override
  State<PersonApp> createState() => _PersonAppState();
}

class _PersonAppState extends State<PersonApp> {
  final PersonAddViewModel viewModel = PersonAddViewModel();
  AddPersonViewModel personViewModel = AddPersonViewModel();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Kişi Ekle", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              TextField(
                controller: personViewModel.textName,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      personViewModel.textName.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: personViewModel.textPhone,
                keyboardType: TextInputType.phone, 
                decoration: InputDecoration(
                  hintText: "Phone",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      personViewModel.textPhone.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: personViewModel.textEmail,
                keyboardType: TextInputType.emailAddress, 
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      personViewModel.textEmail.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: () async {
                  String addName = personViewModel.textName.text;
                  String addNumber = personViewModel.textPhone.text;
                  String addEmail = personViewModel.textEmail.text;

                  await viewModel.addPerson(addName, addNumber, addEmail);

                  Navigator.pop(context); 
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 140),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.green[700],
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}