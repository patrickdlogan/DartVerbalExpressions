library verbal_expressions.or_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expression.dart';

class OrTests {
  static run(){
    group('Or', () {

      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
        .startOfLine()
        .then("abc")
        .or("def")
        .endOfLine();

        expect(verbalExpression.toString(), '^(abc)|(def)\$', reason: 'Regex should be "^(abc)|(def)\$"');
      });

      test('Should match', () {
        verbalExpression
        .startOfLine()
        .then("abc")
        .or("def");

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('defzzz'), isTrue, reason: 'Starts with abc or def');
        expect(matcher.hasMatch('xyzabc'), isFalse, reason: 'Doesn\'t start with abc or def');
      });
    });
  }
}

void main() {
  OrTests.run();
}