import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:motus_flutter/ui/screens/signin_and_signup/sign_in_and_sign_up_page_viewmodel.dart';
import 'package:provider/provider.dart';

class SignInAndSignUpPage extends StatefulWidget {
  const SignInAndSignUpPage({Key? key}) : super(key: key);

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
          if (viewModel.user != null) {
            context.beamToNamed('/home');
          }
        });
        if (viewModel.user == null) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: const EdgeInsets.symmetric(vertical: 15)),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.login,
                        color: Colors.grey,
                      ), // icon is 48px widget.
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrer un texte';
                    }
                    return null;
                  },
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 5)),
                TextFormField(
                  enableSuggestions: false,
                  autocorrect: false,
                  obscuringCharacter: "*",
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Votre password',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.password,
                        color: Colors.grey,
                      ), // icon is 48px widget.
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrer votre mot de passe';
                    }
                    return null;
                  },
                ),
                TextButton(
                    onPressed: () {},
                    child: Text('Vous êtes toujours pas inscrit ?')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // Foreground color
                    onPrimary: Theme.of(context).colorScheme.onPrimary,
                    // Background color
                    primary: Theme.of(context).colorScheme.primary,
                  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  onPressed: () {
                    viewModel.signIn(
                        email: emailController.value.text,
                        password: passwordController.value.text);
                  },
                  child: const Text('Connexion'),
                ),
              ],
            ),
          );
        }
        return const Text('Bienvenue');
      }),
    );
  }
}
