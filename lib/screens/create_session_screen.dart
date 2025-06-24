import 'package:demo_app/context/child_details_context.dart';
import 'package:demo_app/validators/input_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_app/graphql/create_session_service.dart';
import 'package:demo_app/screens/require_consent_screen.dart';
import 'package:demo_app/theme/theme.dart';
import 'package:demo_app/widgets/appbar.dart';
import 'package:demo_app/widgets/dynamic_form.dart';

class CreateSessionScreen extends ConsumerStatefulWidget {
  const CreateSessionScreen({super.key});

  @override
  ConsumerState<CreateSessionScreen> createState() =>
      _CreateSessionScreenState();
}

class _CreateSessionScreenState extends ConsumerState<CreateSessionScreen> {
  late List<FormFieldData> formFields;

  @override
  void initState() {
    super.initState();
    formFields = [
      FormFieldData(
        key: 'childFullName',
        placeholder: "Child's full name",
        validator: FormValidators.fullNameValidator,
      ),
      FormFieldData(
        key: 'nhiNumber',
        placeholder: "Child's NHI number",
        validator: FormValidators.nhiNumberValidator,
      ),
      FormFieldData(
        key: 'childDOB',
        placeholder: "Child's DOB(yyyy/mm/dd)",
        validator: FormValidators.futureDateValidator,
      ),
      FormFieldData(
        key: 'motherDueDate',
        placeholder: "Mother's due date(yyyy/mm/dd)",
        validator: FormValidators.futureDateValidator,
      ),
    ];
  }

  void _handleFormSubmit(Map<String, String> formData) async {
    try {
      dynamic sessionCreated = await createSession(
        childDOB: formData['childDOB']!,
        motherDueDate: formData['motherDueDate']!,
        childFullName: formData['childFullName']!,
        childNHINumber: formData['nhiNumber']!,
      );

      final sessionId = sessionCreated?['sessionId'];
      ref.read(formStateProvider.notifier).state = {
        ...formData,
        "sessionId": sessionId,
      };

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequireConsentScreen(sessionId: sessionId),
          ),
        );
      }
    } catch (e) {
      print('Error creating session: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "Create Session"),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: DynamicFormWidget(
          fields: formFields,
          onSubmit: _handleFormSubmit,
          submitButtonText: "Create Session",
          title: Text(
            "Create a new session",
            style: AppStyles.headingText(context),
          ),
          subtitle: Text(
            "Fill in the fields below with the child's details to start a new session",
            style: AppStyles.normalText(context),
          ),
        ),
      ),
    );
  }
}
