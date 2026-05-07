import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/edit_word_controller.dart';

class EditWordScreen extends StatelessWidget {
  EditWordScreen({super.key});

  final EditWordController editWordController = Get.put(EditWordController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Word')),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _TextInput(
                label: 'English word',
                hint: 'Enter English word',
                controller: editWordController.enWord,
                icon: Icons.language,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 16),
              _TextInput(
                label: 'Arabic word',
                hint: 'Enter Arabic word',
                controller: editWordController.arWord,
                icon: Icons.translate,
                textDirection: TextDirection.rtl,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 16),
              _TextInput(
                label: 'Notes',
                hint: 'Type your notes here',
                controller: editWordController.notes,
                icon: Icons.notes,
                maxLines: 7,
              ),
              const SizedBox(height: 28),
              Obx(
                () => FilledButton.icon(
                  onPressed: editWordController.loading.value
                      ? null
                      : () async {
                          if (formKey.currentState?.validate() != true) {
                            return;
                          }
                          final saved = await editWordController.editCard();
                          if (saved) {
                            Get.back(result: true);
                          }
                        },
                  icon: editWordController.loading.value
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: const Text('Save changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.label,
    required this.hint,
    required this.controller,
    required this.icon,
    this.maxLines = 1,
    this.textDirection,
    this.validator,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final int maxLines;
  final TextDirection? textDirection;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      textDirection: textDirection,
      textInputAction:
          maxLines == 1 ? TextInputAction.next : TextInputAction.newline,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        alignLabelWithHint: maxLines > 1,
      ),
    );
  }
}
