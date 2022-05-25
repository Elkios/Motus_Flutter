import 'package:flutter/material.dart';
import 'package:motus_flutter/ui/screens/signin_and_signup/sign_in_and_sign_up_page_viewmodel.dart';
import 'package:provider/provider.dart';

class SignInAndSignUpPage extends StatefulWidget {
  @override
  _SignInAndSignUpPageState createState() => _SignInAndSignUpPageState();
}

class _SignInAndSignUpPageState extends State<SignInAndSignUpPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SignInAndSignUpPageViewModel>(
        builder: (context, viewModel, child) {
          viewModel.addListener(() {
            if(viewModel.user != null){
              print('user: ${viewModel.user}');
            }
          });
          if(viewModel.user == null) {
            return Center(
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    )
                  ),
                  TextField(
                    obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      )
                  ),
                  ElevatedButton(
                      onPressed: () {
                        viewModel.signIn(email: emailController.value.text, password: passwordController.value.text);
                        },
                      child: const Text('Valider'))
                ],
              ),
            );
          }
          return const Text('Bienvenue');
        }
      ),
    );
  }



}