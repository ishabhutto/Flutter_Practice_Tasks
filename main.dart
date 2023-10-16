import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Form ', home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => HomeState();
}

class HomeState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  final dob = TextEditingController();
  final gender = TextEditingController();
  final imgUrl = 'https://picsum.photos/250?image=9';
  

  String selectedGender = '';

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    email.dispose();
    dob.dispose();
    gender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FORM')),
      body: Form(
        key: formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          
          Image.network(
             imgUrl,
              height: 100,
              width: 100),

//                 Username
          TextFormField(
            controller: username,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: 'Enter Username'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter some Text!';
              }
              return null;
            },
          ),
//                 Password
          TextFormField(
              controller: password,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Enter Password'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (!value.contains(RegExp(r'[0-9]')) &&
                    !value.contains(RegExp(r'[!@#$%^&*()~<>?:"{}|+_"]'))) {
                  return 'Password must have special characters and numbers';
                } else if (value.length <= 8) {
                  return 'Pasword must have at least 8 numbers';
                } else {
                  return null;
                }
              }),
//                 Email
          TextFormField(
              controller: email,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Enter Email'),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                } else if (!value.endsWith('gmail.com')) {
                  return 'Please enter correct gmail extension';
                } else if (!value.contains(RegExp(r'[@]'))) {
                  return 'Please use @ sign';
                }
                return null;
              }),

//             Date of Birth
          TextFormField(
            controller: dob,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter a date (MM-DD-YYYY)'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (!RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(value)) {
                return 'Inavlid Date Formate';
              } else {
                return null;
              }
            },
          ),

//             Gender

          Row(children: [
            RadioMenuButton(
                value: 'Male',
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                  gender.text = value!;
                },
                child: const Text('Male')),
            RadioMenuButton(
                value: 'Female',
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                  gender.text = value!;
                },
                child: const Text('Female')),
          ]),
//

//                 Submit
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          '${username.text} ${password.text}  ${email.text} ')));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowData(
                          username: username.text,
                          email: email.text,
                          dob: dob.text,
                          gender: gender.text,
                          imageUrl : imgUrl
                        
                      ),
                    ),
                  );
                }
              },
              child: const Text('Submit')),
        ]),
      ),
    );
  }
}

class ShowData extends StatelessWidget {
  final String gender;

  final String username;
  final String email;
  final String dob;
  final String imageUrl;

  const ShowData(
      {required this.username,
      required this.email,
      required this.dob,
      required this.gender,
      required this.imageUrl,
      super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Show Data')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Received Data from Form'),
          Text('${username}'),
          Text('${email}'),
          Text('${dob}'),
          Text('${gender}'),
          Image.network(
            imageUrl,
            height :100,
            width : 100
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Form')),
        ]),
      ),
    );
  }
}
