import 'package:flutter/material.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/widgets/all_widgets.dart';

import '../Functions_and_Vars/functions.dart';
import '../models/faq.dart';

class FaqPopUp extends StatelessWidget {
  FaqPopUp(
      {Key? key,
      required this.question,
      required this.answer,
      required this.tittle,
      this.faqId,
      this.updateFaq,
      this.addFaq})
      : super(key: key);

  final String question;
  final String answer;
  final String tittle;
  final String? faqId;
  final Function(String, Faq)? updateFaq;
  final Function(Faq)? addFaq;
  final _formKey = GlobalKey<FormState>();

  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  onSavePressed(question, answer, context) {
    if (_formKey.currentState!.validate()) {
      if (updateFaq != null) {
        updateFaq!(faqId!, Faq(question: question, answer: answer));
        Navigator.of(context).pop();
      }
      if (addFaq != null) {
        addFaq!(Faq(question: question, answer: answer));
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    questionController.text = question;
    answerController.text = answer;

    return AlertDialog(
      title: Text(tittle),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Question',
                labelText: 'Question',
              ),
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 2,
              validator: Validators.otherValidator,
              controller: questionController,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Answer',
                labelText: 'Answer',
              ),
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
              validator: Validators.otherValidator,
              controller: answerController,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        RoundedRectangleButton(
            width: 70,
            onPressed: () {
              onSavePressed(
                  questionController.text, answerController.text, context);
            },
            text: "Save",
            buttoncolor: Pallete.buttonGreen,
            height: 40),
      ],
    );
  }
}
