import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:motus_flutter/ui/screens/signin_and_signup/sign_in_and_sign_up_page_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

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
        backgroundColor: Colors.blue,
        body: Consumer<SignInAndSignUpPageViewModel>(
            builder: (context, viewModel, child) {
          viewModel.addListener(() {
            if (viewModel.user != null) {
              context.beamToNamed('/home');
            }
          });
          if (viewModel.user == null) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElasticIn(
                      duration: const Duration(milliseconds: 2000),
                      child: Image.asset('assets/images/motus&bouche.png'),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                    ElasticIn(
                      duration: const Duration(milliseconds: 2000),
                      child: const Text('Connexion',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    ElasticIn(
                      duration: const Duration(milliseconds: 2000),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.login,
                              color: Colors.black,
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
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    ElasticIn(
                      duration: const Duration(milliseconds: 2000),
                      child: TextFormField(
                        enableSuggestions: true,
                        autocorrect: false,
                        obscuringCharacter: "*",
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Mot de passe',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.password,
                              color: Colors.black,
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
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    ElasticIn(
                      duration: const Duration(milliseconds: 2000),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // Foreground color
                          onPrimary: Theme.of(context).colorScheme.onPrimary,
                          // Background color
                          primary: Theme.of(context).colorScheme.primary,
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                        onPressed: () {
                          try {
                            viewModel.signIn(
                                email: emailController.value.text,
                                password: passwordController.value.text);
                          } on Exception catch (_) {
                            print("throwing new error");
                            throw Exception("Error on server");
                          }
/*                          String? encodeQueryParameters(Map<String, String> params){
                            return params.entries
                                .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                .join('&');
                          }
                          String mapsUrl = 'https://www.google.com/maps/search/?api=1&query=47.866617,2.669932';
                          Uri mapsUri = Uri.parse(mapsUrl);
                          Uri emailLaunchUri = Uri(
                            scheme : 'mailto',
                            path: 'eddyweber80@gmail.com',
                            query: encodeQueryParameters(<String, String>{
                              'subject': 'Example Subject & Symbols are allowed!'
                            }),
                          );
                          if(await canLaunchUrl(mapsUri)){
                          launchUrl(mapsUri);
                          }*/
                        },
                        child: const Text('Jouer'),
                      ),
                    ),
                  ]),
            );
          }
          return const Text('Bienveue');
        }));
  }
}
