extension ValidationExtensions on String {
  String? get validateEmail {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (isEmpty) {
      return "Please enter email";
    } else if (!regex.hasMatch(this)) {
      return 'Enter Valid Email';
    }
    return null;
  }

  String? get validateMobile {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(this)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

      String? get validatePassword {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(this)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }
}
