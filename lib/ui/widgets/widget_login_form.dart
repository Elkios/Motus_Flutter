import 'package:flutter/material.dart';
import 'widget_register_form.dart';

class MyLoginForm extends StatefulWidget {
  const MyLoginForm({Key? key}) : super(key: key);

  @override
  State<MyLoginForm> createState() => _MyLoginFormState();
}

class _MyLoginFormState extends State<MyLoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Connexion'),
            Padding(padding: const EdgeInsets.symmetric(vertical: 15)),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Votre login',
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
                onPressed: () {
                },
                child: Text('Vous êtes toujours pas inscrit ?')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // Foreground color
                onPrimary: Theme.of(context).colorScheme.onPrimary,
                // Background color
                primary: Theme.of(context).colorScheme.primary,
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Connexion'),
            ),
          ],
        ),
      ),
    );
  }
}
