import 'package:flutter/material.dart';
import 'package:demo_app/theme/theme.dart';

class FormFieldData {
  final String key;
  final String placeholder;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final String? initialValue;
  final bool isEnabled; // New field added

  FormFieldData({
    required this.key,
    required this.placeholder,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.initialValue,
    this.isEnabled = true,
  });
}

class DynamicFormWidget extends StatefulWidget {
  final List<FormFieldData> fields;
  final void Function(Map<String, String>) onSubmit;
  final String submitButtonText;
  final Widget? title;
  final Widget? subtitle;

  const DynamicFormWidget({
    super.key,
    required this.fields,
    required this.onSubmit,
    this.submitButtonText = "Submit",
    this.title,
    this.subtitle,
  });

  @override
  State<DynamicFormWidget> createState() => _DynamicFormWidgetState();
}

class _DynamicFormWidgetState extends State<DynamicFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = {};

    for (var field in widget.fields) {
      _controllers[field.key] = TextEditingController(
        text: field.initialValue ?? '',
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Map<String, String> _getFormData() {
    Map<String, String> data = {};
    for (var entry in _controllers.entries) {
      data[entry.key] = entry.value.text;
    }
    return data;
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_getFormData());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the errors in the form.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              if (widget.title != null) widget.title!,
              if (widget.subtitle != null) widget.subtitle!,
              if (widget.title != null || widget.subtitle != null)
                const SizedBox(height: 16),

              ...widget.fields.map(
                (field) => AppStyles.glassTextField(
                  controller: _controllers[field.key]!,
                  hint: field.placeholder,
                  validator: field.validator,
                  isEnabled: field.isEnabled,
                ),
              ),
            ],
          ),

          // Submit button
          AppStyles.confirmButton(
            onPressed: _handleSubmit,
            text: widget.submitButtonText,
          ),
        ],
      ),
    );
  }
}
