import 'package:flutter_test/flutter_test.dart';
import 'package:shortest_path_app/core/utils/url_validator.dart';

void main() {
  group('UrlValidator.validate', () {
    group('valid url', () {
      test('url with spaces', () {
        expect(
          UrlValidator.validate(
            '      https://flutter.webspark.dev/flutter/api    ',
          ),
          isNull,
        );
      });

      test('https url', () {
        expect(
          UrlValidator.validate('https://flutter.webspark.dev/flutter/api'),
          isNull,
        );
      });

      test('http url', () {
        expect(
          UrlValidator.validate('http://flutter.webspark.dev/flutter/api'),
          isNull,
        );
      });

      test('with GET params', () {
        expect(
          UrlValidator.validate(
            'http://flutter.webspark.dev/flutter/api?failed=true',
          ),
          isNull,
        );
      });

      test('localhost', () {
        expect(
          UrlValidator.validate(
            'http://localhost:8080/flutter/api',
          ),
          isNull,
        );
      });
    });

    group('invalid url', () {
      test('empty url', () {
        expect(
          UrlValidator.validate(
            '',
          ),
          'Enter URL',
        );
      });

      test('only spaces', () {
        expect(
          UrlValidator.validate(
            '    ',
          ),
          'Enter URL',
        );
      });

      test('without schema', () {
        expect(
          UrlValidator.validate(
            'localhost:8080/flutter/api',
          ),
          'Enter valid URL',
        );
      });

      test('only schema', () {
        expect(
          UrlValidator.validate(
            'https://',
          ),
          'Enter valid URL',
        );
      });

      test('not http', () {
        expect(
          UrlValidator.validate(
            'abc://test.app/flutter/api',
          ),
          'Enter valid URL',
        );
      });

      test('random word', () {
        expect(
          UrlValidator.validate(
            'absdef',
          ),
          'Enter valid URL',
        );
      });
    });
  });
}
