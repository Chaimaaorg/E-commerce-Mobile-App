// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../models/Language.dart';
// import '../../providers/language_provider.dart';
// import '../../services/translation_service.dart';
//
//
// class Languages extends StatefulWidget {
//   const Languages({super.key});
//   static String routeName = "/languages";
//
//   @override
//   State<Languages> createState() => _LanguagesState();
// }
//
// class _LanguagesState extends State<Languages> {
//   TextEditingController controller = TextEditingController(text: 'How are you?');
//   final formkey = GlobalKey<FormState>();
//   bool isloading = false;
//
//   Future<void> translate(Language from, Language to) async {
//     try {
//       if (formkey.currentState!.validate()) {
//         setState(() {
//           isloading = true;
//         });
//
//         TranslationService translationService = TranslationService();
//
//         String translatedText = await translationService.translate(
//           controller.text,
//           from.code,
//           to.code,
//         );
//
//         setState(() {
//           isloading = false;
//           controller.text = translatedText;
//         });
//       }
//     } catch (e) {
//       // Handle any other exceptions or errors here
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     LanguageProvider languageProvider = context.read<LanguageProvider>();
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             color: Color.fromARGB(255, 50, 46, 165),
//           ),
//         ),
//         title: const Text(
//           'Translator App',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 28,
//           ),
//         ),
//       ),
//       backgroundColor: const Color.fromARGB(255, 87, 104, 254),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 30,
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 40),
//               decoration: BoxDecoration(
//                 color: Colors.indigo.shade100,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('From'),
//                   const SizedBox(
//                     width: 100,
//                   ),
//                   DropdownButton<Language>(
//                     value: languageProvider.fromLanguage,
//                     focusColor: Colors.transparent,
//                     items: languageProvider.languages.map((lang) {
//                       return DropdownMenuItem<Language>(
//                         value: lang,
//                         child: Text(lang.name),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         languageProvider.setFromLanguage(value!);
//                       });
//                     },
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(20),
//               margin: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.blueGrey.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.black),
//               ),
//               child: Form(
//                 key: formkey,
//                 child: TextFormField(
//                   controller: controller,
//                   maxLines: null,
//                   minLines: null,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                   textInputAction: TextInputAction.done,
//                   decoration: const InputDecoration(
//                     enabledBorder: InputBorder.none,
//                     border: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     errorStyle: TextStyle(color: Colors.white),
//                   ),
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 40),
//               decoration: BoxDecoration(
//                 color: Colors.indigo.shade100,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('To'),
//                   const SizedBox(
//                     width: 100,
//                   ),
//                   DropdownButton<Language>(
//                     value: languageProvider.toLanguage,
//                     focusColor: Colors.transparent,
//                     items: languageProvider.languages.map((lang) {
//                       return DropdownMenuItem<Language>(
//                         value: lang,
//                         child: Text(lang.name),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         languageProvider.setToLanguage(value!);
//                       });
//                     },
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(20),
//               margin: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.blueGrey.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.black),
//               ),
//               child: Center(
//                 child: SelectableText(
//                   controller.text,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () => translate(languageProvider.fromLanguage, languageProvider.toLanguage),
//               style: ButtonStyle(
//                 backgroundColor: MaterialStatePropertyAll(Colors.indigo.shade900),
//                 fixedSize: MaterialStatePropertyAll(Size(300, 45)),
//               ),
//               child: isloading
//                   ? const SizedBox.square(
//                 dimension: 20,
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                 ),
//               )
//                   : const Text('Translate'),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
