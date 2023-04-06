class Validators {
  static bool email({required String email}) {
    final emailRegex = RegExp(
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""");
    return emailRegex.hasMatch(email) ? true : false;
  }

  static bool password({required String password}) {
    final passwordRegex =
    RegExp(r'^(?=.*[A-Z])(?=.*[!@#$%^&*])(?=.*[0-9])(?=.*[a-z]).{6,}$');
    return passwordRegex.hasMatch(password) ? true : false;
  }
}

// Email
// One or more characters before the @ symbol, that can be a letter, digit, dot,
// exclamation mark, #, $, %, &, ', *, +, -, /, =, ?, ^, _, , {, |, }
// and ~ (^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+)
// The @ symbol (@)
// One or more characters that are only letters or digits ([a-zA-Z0-9]+)
// A dot (.)
// One or more characters that are only letters ([a-zA-Z]+)

// Password
// At least one uppercase letter (?=.*[A-Z])
// At least one special character (!@#$%^&) (?=.[!@#$%^&*])
// At least one digit (0-9) (?=.*[0-9])
// At least one lowercase letter (?=.*[a-z])
// At least 8 characters in total .{8,}