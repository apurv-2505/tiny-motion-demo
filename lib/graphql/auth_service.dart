import 'package:demo_app/services/secure_storage_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'client.dart';
import 'mutations.dart';

Future<String?> loginClinician(String clinicianId) async {
  final client = getGraphQLClient();

  final MutationOptions options = MutationOptions(
    document: gql(loginMutation),
    variables: {'clinicianId': clinicianId},
  );

  final QueryResult result = await client.mutate(options);

  if (result.hasException) {
    return null;
  }

  return result.data?['login']?['token'];
}

Future<void> logoutClinician() async {
  SecureStorageService.deleteAuthToken();
}
