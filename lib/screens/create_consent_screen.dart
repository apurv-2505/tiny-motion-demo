import 'package:demo_app/graphql/create_consent_service.dart';
import 'package:demo_app/screens/checklist_screen.dart';
import 'package:demo_app/theme/theme.dart';
import 'package:demo_app/validators/input_validators.dart';
import 'package:demo_app/widgets/appbar.dart';
import 'package:demo_app/widgets/dynamic_form.dart';
import 'package:flutter/material.dart';

class CreateConsentScreen extends StatefulWidget {
  const CreateConsentScreen({super.key});

  @override
  State<CreateConsentScreen> createState() => _CreateConsentScreenState();
}

class _CreateConsentScreenState extends State<CreateConsentScreen> {
  // Define the form fields
  late List<FormFieldData> formFields;

  @override
  void initState() {
    super.initState();
    formFields = [
      FormFieldData(
        key: 'fullName',
        placeholder: 'Full Name',
        validator: FormValidators.fullNameValidator,
      ),
      FormFieldData(
        key: 'emailAddress',
        placeholder: 'Email Address',
        keyboardType: TextInputType.emailAddress,
        validator: FormValidators.emailValidator,
      ),
    ];
  }

  // On submit handler
  void _handleSubmit(Map<String, String> formData) async {
    await createConsent(
      email: formData['emailAddress']!,
      fullName: formData['fullName']!,
    );

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChecklistScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "Create Consent"),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: DynamicFormWidget(
          fields: formFields,
          onSubmit: _handleSubmit,
          submitButtonText: "Create Session",
          title: Text(
            "Create a new consent",
            style: AppStyles.headingText(context),
          ),
          subtitle: Text(
            "Fill in the fields below to continue",
            style: AppStyles.normalText(context),
          ),
        ),
      ),
    );
  }
}
