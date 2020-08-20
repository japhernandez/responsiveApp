import 'package:responsiveApp/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:responsiveApp/api/auth.dart';
import 'package:responsiveApp/widgets/circle.dart';
import 'package:responsiveApp/widgets/input.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _username = '', _email = '', _password = '';
  final _formKey = GlobalKey<FormState>();
  final _auth = Auth();
  var _isFeching = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsive = ResponsiveDesign(context);

    return Container(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: <Widget>[
                // Circulo grande
                Positioned(
                    right: -size.width * 0.22,
                    top: -size.width * 0.36,
                    child: Circle(
                      radius: size.width * 0.45,
                      colors: [
                        Colors.pink,
                        Colors.pinkAccent,
                      ],
                    )),
                // Circulo pequeño
                Positioned(
                    left: -size.width * 0.15,
                    top: -size.width * 0.34,
                    child: Circle(
                      radius: size.width * 0.35,
                      colors: [
                        Colors.orange,
                        Colors.deepOrange,
                      ],
                    )),
                _singleChildScrollView(size, responsive),
                _isFeching
                    ? Positioned.fill(
                        child: Container(
                          color: Colors.black45,
                          child: Center(
                            child: CupertinoActivityIndicator(radius: 15),
                          ),
                        ),
                      )
                    : Container(),
                // Boton para regresar
                Positioned(
                    left: 15,
                    top: 5,
                    child: SafeArea(
                        child: CupertinoButton(
                      padding: EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black12,
                      child: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    )))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _singleChildScrollView(size, responsive) {
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _logo(size, responsive),
              Column(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 350, minWidth: 350),
                    child: _form(responsive),
                  ),
                  SizedBox(height: responsive.heightPercent(5.0)),
                  _bottom(responsive),
                  SizedBox(height: responsive.heightPercent(1.0)),
                  _link(responsive),
                  SizedBox(height: responsive.heightPercent(5.0)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo(size, responsive) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: size.width * 0.1),
          child: Text(
            'Hello. \n Sign up to get started',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: responsive.inchPercent(2.0),
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: size.width * 0.1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 25,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(110.0),
            child: FadeInImage(
              placeholder: NetworkImage(
                  'https://us.123rf.com/450wm/thesomeday123/thesomeday1231709/thesomeday123170900022/85622929-icono-de-perfil-de-avatar-predeterminado-marcador-de-posici%C3%B3n-de-foto-gris-vectores-de-ilustraciones.jpg?ver=6'),
              image: NetworkImage(
                  'https://cdn.ticbeat.com/src/uploads/2017/05/joven-programador--e1496051049973-1140x729.jpg'),
              fit: BoxFit.cover,
              height: responsive.widthPercent(20.0),
              width: responsive.widthPercent(20.0),
            ),
          ),
        )
      ],
    );
  }

  Widget _form(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          InputText(
            label: "USERNAME",
            fontSize: responsive.inchPercent(1.8),
            validator: (String text) {
              if (RegExp(r'^[a-zA-Z0-9]+$').hasMatch(text)) {
                _username = text;
                return null;
              }
              return 'Invalid username';
            },
          ),
          SizedBox(height: responsive.heightPercent(2.0)),
          InputText(
            label: "EMAIL ADDRESS",
            fontSize: responsive.inchPercent(1.8),
            textInputType: TextInputType.emailAddress,
            validator: (String text) {
              if (text.contains('@')) {
                _email = text;
                return null;
              }
              return 'Invalid Email';
            },
          ),
          SizedBox(height: responsive.heightPercent(2.0)),
          InputText(
              isSecure: true,
              label: "PASSWORD",
              fontSize: responsive.inchPercent(1.8),
              validator: (String text) {
                if (text.isNotEmpty && text.length > 5) {
                  _password = text;
                  return null;
                }
                return 'Invalid password';
              }),
        ],
      ),
    );
  }

  Widget _bottom(responsive) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 350, minWidth: 350),
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(vertical: responsive.inchPercent(2.0)),
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(4),
        child: Text(
          "Sign up",
          style: TextStyle(fontSize: responsive.inchPercent(2.5)),
        ),
        onPressed: () => _submit(),
      ),
    );
  }

  Widget _link(responsive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Already have an account ?",
          style: TextStyle(
            fontSize: responsive.inchPercent(1.8),
            color: Colors.black54,
          ),
        ),
        CupertinoButton(
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: responsive.inchPercent(1.8),
              color: Colors.pinkAccent,
            ),
          ),
          onPressed: () => Navigator.pushNamed(context, 'login'),
        )
      ],
    );
  }

  _submit() async {
    if (_isFeching) return;

    final isValid = _formKey.currentState.validate();
    if (isValid) {
      setState(() => _isFeching = true);

      final responseOK = await _auth.register(
        context,
        username: _username,
        email: _email,
        password: _password,
      );

      setState(() => _isFeching = false);

      if (responseOK) {
        print('Register ok');
        Navigator.pushNamedAndRemoveUntil(context, 'splash', (route) => false);
      }
    }
  }
}
