class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  bool _isAuthenticated = false;
  String? _email;

  bool get isAuthenticated => _isAuthenticated;
  String? get currentUser => _email;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim();
    final normalizedPassword = password.trim();

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    if (!emailRegex.hasMatch(normalizedEmail)) {
      throw const FormatException('Veuillez saisir un e-mail valide.');
    }

    if (normalizedPassword.length < 8) {
      throw const FormatException('Le mot de passe doit contenir au moins 8 caractères.');
    }

    await Future<void>.delayed(const Duration(milliseconds: 700));

    _isAuthenticated = true;
    _email = normalizedEmail;
  }

  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _isAuthenticated = false;
    _email = null;
  }
}
