import 'package:flutter/material.dart';
import 'package:mvc_mvvm_mobx/controllers/signup.controller.dart';
import 'package:mvc_mvvm_mobx/stores/app.store.dart';
import 'package:mvc_mvvm_mobx/view-models/signup.viewmodel.dart';
import 'package:mvc_mvvm_mobx/views/home.view.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = new SignupController();
  var model = new SignupViewModel();

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(40),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text("Cadastre-se!"),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nome",
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Este campo é necessário!";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        model.name = val;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Este campo é necessário!";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        model.email = val;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Este campo é necessário!";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        model.password = val;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    model.busy
                        ? Center(
                            child: Container(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.black,
                              ),
                            ),
                          )
                        : FlatButton(
                            color: Theme.of(context).primaryColor,
                            child: Text("Cadastrar"),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                              }
                              setState(() {});
                              _controller.create(model).then((data) {
                                setState(() {});
                                store.setUser(
                                  data.name,
                                  data.email,
                                  data.picture,
                                  data.token,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeView(),
                                  ),
                                );
                              });
                            },
                          )
                  ],
                ))),
      ),
    );
  }
}
