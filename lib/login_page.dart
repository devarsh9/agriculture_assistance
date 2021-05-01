import 'authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  //Controllers for e-mail and password textfields.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Handling signup and signin
  bool signUp = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xfff2f3f7),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2470c7),
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(70),
                  bottomRight: const Radius.circular(70),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLogo(),
              _buildContainer(),
              //_buildSignUpBtn(),
            ],
          )
        ],
      ),
    ));
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Agro Assistant',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    signUp
                        ? Text(
                            "REGISTER",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 30,
                            ),
                          )
                        : Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 30,
                            ),
                          )
                  ],
                ),
                _buildEmailRow(),
                _buildPasswordRow(),
                RaisedButton(
                  onPressed: () {
                    if (signUp) {
                      //Provider sign up method
                      context.read<AuthenticationProvider>().signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                    } else {
                      //Provider sign in method
                      context.read<AuthenticationProvider>().signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                    }
                  },
                  child: signUp ? Text("Sign Up") : Text("Login"),
                ),
                OutlineButton(
                  onPressed: () {
                    setState(() {
                      signUp = !signUp;
                    });
                  },
                  child: signUp
                      ? Text("Have an account? Login")
                      : Text("Create an account"),
                ),
                //_buildForgetPasswordButton(),
                //_buildLoginButton()
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: Color(0xff2470c7),
            ),
            labelText: 'E-mail'),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Color(0xff2470c7),
          ),
          labelText: 'Password',
        ),
      ),
    );
  }
}
