import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_list/models/User.dart';
import 'package:user_list/provider/Users.dart';

class UserForm extends StatefulWidget {

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user){

    if(user != null){

    _formData['id'] = user.id ;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;

    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final User user = ModalRoute.of(context).settings.arguments;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar estudiante PPP"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () { 
              final isValid = _form.currentState.validate();
              
              if(isValid){
                _form.currentState.save();
                Provider.of<Users>(context, listen: false).put(User(
                  id: _formData['id'],
                  name: _formData['name'],
                  email: _formData['email'],
                  avatarUrl: _formData['avatarUrl'],
                ));
                Navigator.of(context).pop();
              }

            },
          )
        ],
      ),
      body: Padding(padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Include your name';
                  }

                  if (value.trim().length < 3){
                    return 'Name too small';
                  }
                },
                onSaved: (value) => _formData['name'] = value,
                decoration: InputDecoration(labelText: 'Nombres y Apellidos: '),
              ),
              TextFormField(
                initialValue: _formData['email'],
                onSaved: (value) => _formData['email'] = value,                
                decoration: InputDecoration(labelText: 'Correo Institucional: '),
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                onSaved: (value) => _formData['avatarUrl'] = value,
                decoration: InputDecoration(labelText: 'Link Documentos Drive: '),
              ),
            ],
          )
        ),
      ),
      
    );
  }
}