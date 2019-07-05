String validateEmail(String email) {
  RegExp regExp = new RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );

  if (!regExp.hasMatch(email)) {
    return 'Email inválido';
  }

  return null;
}

String validatePassword(String password) {
  if (password.length < 8) {
    return 'A senha deve ter, no mínimo, 8 caracteres!';
  }

  return null;
}

String confirmPassword(String password, String confirmPassword) {
  if (password != confirmPassword) {
    return 'As senhas não são iguais!';
  }
  
  return validatePassword(password);
}