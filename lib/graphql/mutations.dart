const String loginMutation = r'''
mutation Login($clinicianId: String!) {
  login(clinicianId: $clinicianId) {
    token
  }
}
''';

const String createSessionMutation = r'''
mutation CreateSession($input: SessionInput!) {
  createSession(input: $input) {
    sessionId
    message
  }
}
''';

const String createConsentMutation = r'''
mutation CreateConsent($input: ConsentInput!) {
  createConsent(input: $input) {
    consentId
    message
  }
}
''';

const String submitMutation = r'''
mutation Submit($input: SubmitInput!) {
  submit(input: $input) {
    submissionId
    message
  }
}
''';
