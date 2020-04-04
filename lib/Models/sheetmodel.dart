class FeedbackForm {

  String _name;
  String _email;
  String _mobileNo;
  String _feedback;

  String _age;

  FeedbackForm(this._name, this._email, this._feedback, this._mobileNo,this._age);

  // Method to make GET parameters.
  String toParams() =>
      "?name=$_name&email=$_email&mobileNo=$_mobileNo&feedback=$_feedback&age=$_age";


}