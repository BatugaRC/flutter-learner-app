// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:learner_app/views/home/update_form.dart';

void showSettingsPanel(context, docId, creator) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 60.0,
        ),
        child: UpdateForm(
          docId: docId,
          creator: creator,
        ),
      );
    },
  );
}
