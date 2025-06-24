import 'package:demo_app/context/child_details_context.dart';
import 'package:demo_app/graphql/submit_service.dart';
import 'package:demo_app/screens/successful_submission.dart';
import 'package:demo_app/widgets/appbar.dart';
import 'package:demo_app/widgets/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubmissionScreen extends ConsumerWidget {
  final String videoPath;
  const SubmissionScreen({super.key, required this.videoPath});

  String getCalculatedAge(String dueDateStr) {
    if (dueDateStr.isEmpty) return '';

    try {
      final dueDate = DateTime.parse(dueDateStr);
      final today = DateTime.now();
      final diff = today.difference(dueDate).inDays;

      final weeks = diff ~/ 7;
      final days = diff % 7;

      return '$weeks weeks${days > 0 ? ', $days days' : ''}';
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(formStateProvider);

    // Define display-only fields
    final List<FormFieldData> displayFields = [
      FormFieldData(
        key: 'childFullName',
        placeholder: "Child's full name",
        initialValue: formData["childFullName"],
        isEnabled: false,
      ),
      FormFieldData(
        key: 'nhiNumber',
        placeholder: "Child's NHI number",
        initialValue: formData["nhiNumber"],
        isEnabled: false,
      ),
      FormFieldData(
        key: 'childDOB',
        placeholder: "Child's age",
        initialValue: formData["childDOB"],
        isEnabled: false,
      ),
      FormFieldData(
        key: 'correctedAge',
        placeholder: "Corrected age",
        initialValue: getCalculatedAge(formData["childDOB"]!),
        isEnabled: false,
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(titleText: "Review & Submit"),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: DynamicFormWidget(
          fields: displayFields,
          onSubmit: (_) async {
            await submitVideo(
              sessionId: formData["sessionId"]!,
              videoBase64: videoPath,
            );

            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SuccessfulSubmissionScreen(),
                ),
              );
            }
          },
          submitButtonText: "Submit",
        ),
      ),
    );
  }
}
