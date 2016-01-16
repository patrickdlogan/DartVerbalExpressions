library verbal_expressions_example.example;

import 'package:verbal_expressions/verbal_expression.dart';

main() {
  var result = matchUrl('https://www.google.com'); // true
  // ...

  String phoneWithSpace = "+097 234 243";
  result = matchTelephoneNumber(phoneWithSpace); //true
  // ...

  String phoneWithoutSpace = "+097234243";
  result = matchTelephoneNumber(phoneWithoutSpace); // true
  // ...

  String phoneWithDash = "+097-234-243";
  result = matchTelephoneNumber(phoneWithDash); // true
  // ...

  var domain = getDomain('https://www.google.com');
  print(domain); // .com

  domain = getDomain('http://ru.wikipedia.org/wiki/Dart');
  print(domain); // .org

  var testString = new VerbalExpression()
      .find('dog')
      .stopAtFirst()
      .withAnyCase()
      .replace('Replace first DoG in the sentence but do not touch second dog',
          'cat');

  print(
      testString); // Replace first cat in the sentence but do not touch second dog
}

String getDomain(String url) {
  var regex = new VerbalExpression()
      .startOfLine()
      .then("http")
      .maybe("s")
      .then("://")
      .maybe("www.")
      .anythingBut(" ")
      .beginCapture()
      .then('.')
      .anythingBut('/')
      .endCapture()
      .anything()
      .endOfLine()
      .toRegExp();

  return regex.firstMatch(url).group(4);
}

bool matchTelephoneNumber(String number) {
  var regex = new VerbalExpression()
      .startOfLine()
      .then("+")
      .beginCapture()
      .range([new Range('0', '9')])
      .count(3)
      .maybe("-")
      .maybe(" ")
      .endCapture()
      .count(3)
      .endOfLine();

  return regex.hasMatch(number);
}

bool matchUrl(String url) {
  var regex = new VerbalExpression()
      .startOfLine()
      .then("http")
      .maybe("s")
      .then("://")
      .maybe("www.")
      .anythingBut(" ")
      .endOfLine();

  return regex.hasMatch(url);
}
