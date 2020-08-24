import 'package:responsiveApp/api/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:responsiveApp/utils/responsiveExtra.dart';
import 'package:responsiveApp/widgets/circle.dart';
import 'package:responsiveApp/widgets/input.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _email = '', _password = '';
  var _isFeching = false;
  final _auth = Auth();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsive = ResponsiveDesignExtra(context);

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
                    : Container()
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
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _logo(size, responsive),
              Column(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: responsive.widthMultiplier(350.0),
                        minWidth: responsive.widthMultiplier(350.0)
                    ),
                    child: _form(responsive),
                  ),
                  SizedBox(height: responsive.heightMultiplier(10.0)),
                  _bottom(responsive),
                  SizedBox(height: responsive.heightMultiplier(10.0)),
                  _link(responsive),
                  SizedBox(height: responsive.heightMultiplier(10.0)),
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
          width: responsive.widthMultiplier(100.0),
          height: responsive.widthMultiplier(100.0),
          margin: EdgeInsets.only(top: size.width * 0.3),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25,
                ),
              ]),
        ),
        SizedBox(height: responsive.heightMultiplier(10.0)),
        Text(
          'Hello again. \n Welcome back',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: responsive.textMultiplier(14.0),
          ),
        ),
      ],
    );
  }

  Widget _form(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          InputText(
            label: "EMAIL ADDRESS",
            fontSize: responsive.textMultiplier(12.6),
            textInputType: TextInputType.emailAddress,
            validator: (String text) {
              if (text.contains('@')) {
                _email = text;
                return null;
              }
              return 'Invalid Email';
            },
          ),
          SizedBox(height: responsive.heightMultiplier(10.0)),
          InputText(
              isSecure: true,
              fontSize: responsive.textMultiplier(12.6),
              label: "PASSWORD",
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
      constraints: BoxConstraints(
          maxWidth: responsive.widthMultiplier(350.0),
          minWidth: responsive.widthMultiplier(350.0)
      ),
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(vertical: responsive.inchPercent(2.0)),
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(4),
        child: Text(
          "Sign in",
          style: TextStyle(
              fontSize: responsive.textMultiplier(17.5)
          ),
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
          "New to Friendly Desi?",
          style: TextStyle(
            fontSize: responsive.textMultiplier(14.0),
            color: Colors.black54,
          ),
        ),
        CupertinoButton(
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: responsive.textMultiplier(14.0),
              color: Colors.pinkAccent,
            ),
          ),
          onPressed: () => Navigator.pushNamed(context, 'signup'),
        )
      ],
    );
  }

  _submit() async {
    if (_isFeching) return;

    // Validacion del formulario
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      // Mostramos un loading mientras se hace la peticion
      // al servidor
      setState(() => _isFeching = true);

      // Hacemos la peticion
      final responseOK = await _auth.login(
        context,
        email: _email,
        password: _password,
      );

      // Quitamos el loading cuando se obtiene respuesta
      // del servidor
      setState(() => _isFeching = false);

      if (responseOK) {
        print('Loggead');
        // Redireccionamos al Home Page
        Navigator.pushNamedAndRemoveUntil(context, 'splash', (route) => false);
      }
    }
  }
}
