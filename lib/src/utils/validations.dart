class Validators {
  static validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static Validator validatePassword() {
    return (String? value) {
      if (value!.isEmpty) {
        return 'Password is required';
      }
      if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$')
          .hasMatch(value)) {
        return 'Password must contain at least one uppercase letter, one lowercase letter and one number';
      }
      if (value.contains(' ')) {
        return 'Password must not contain spaces';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
      return null;
    };
  }

  static validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  static validatePhone(String value) {
    if (value.isEmpty) {
      return 'Phone is required';
    }
    if (value.length < 10) {
      return 'Phone must be at least 10 characters';
    }
    return null;
  }

  static validateAddress(String value) {
    if (value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }
}

typedef Validator = String? Function(String? value);
