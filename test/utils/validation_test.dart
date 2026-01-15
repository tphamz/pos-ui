import 'package:flutter_test/flutter_test.dart';
import 'package:pos_mobile/utils/validation.dart';

void main() {
  group('ValidationUtils', () {
    group('isValidEmail', () {
      test('should return true for valid email addresses', () {
        expect(ValidationUtils.isValidEmail('user@example.com'), isTrue);
        expect(ValidationUtils.isValidEmail('test.email@domain.co.uk'), isTrue);
        expect(ValidationUtils.isValidEmail('user+tag@example.com'), isTrue);
      });

      test('should return false for invalid email addresses', () {
        expect(ValidationUtils.isValidEmail('invalid'), isFalse);
        expect(ValidationUtils.isValidEmail('@example.com'), isFalse);
        expect(ValidationUtils.isValidEmail('user@'), isFalse);
        expect(ValidationUtils.isValidEmail(''), isFalse);
      });
    });

    group('normalizePhoneNumber', () {
      test('should normalize 10-digit US numbers', () {
        expect(ValidationUtils.normalizePhoneNumber('7033443167'), equals('+17033443167'));
        expect(ValidationUtils.normalizePhoneNumber('1234567890'), equals('+11234567890'));
      });

      test('should handle already normalized numbers', () {
        expect(ValidationUtils.normalizePhoneNumber('+17033443167'), equals('+17033443167'));
        expect(ValidationUtils.normalizePhoneNumber('+441234567890'), equals('+441234567890'));
      });

      test('should handle 11-digit numbers starting with 1', () {
        expect(ValidationUtils.normalizePhoneNumber('17033443167'), equals('+17033443167'));
      });

      test('should strip formatting characters', () {
        expect(ValidationUtils.normalizePhoneNumber('(703) 344-3167'), equals('+17033443167'));
        expect(ValidationUtils.normalizePhoneNumber('703-344-3167'), equals('+17033443167'));
        expect(ValidationUtils.normalizePhoneNumber('703.344.3167'), equals('+17033443167'));
      });

      test('should not normalize email addresses', () {
        expect(ValidationUtils.normalizePhoneNumber('user@example.com'), equals('user@example.com'));
      });
    });

    group('isValidPhoneNumber', () {
      test('should return true for valid phone numbers', () {
        expect(ValidationUtils.isValidPhoneNumber('7033443167'), isTrue);
        expect(ValidationUtils.isValidPhoneNumber('+17033443167'), isTrue);
        expect(ValidationUtils.isValidPhoneNumber('17033443167'), isTrue);
        expect(ValidationUtils.isValidPhoneNumber('(703) 344-3167'), isTrue);
      });

      test('should return false for invalid phone numbers', () {
        expect(ValidationUtils.isValidPhoneNumber(''), isFalse);
        expect(ValidationUtils.isValidPhoneNumber('123'), isFalse);
        expect(ValidationUtils.isValidPhoneNumber('abc123'), isFalse);
      });
    });

    group('isValidStoreCode', () {
      test('should return true for valid store codes', () {
        expect(ValidationUtils.isValidStoreCode('store-code'), isTrue);
        expect(ValidationUtils.isValidStoreCode('my-store-123'), isTrue);
        expect(ValidationUtils.isValidStoreCode('a'), isTrue);
      });

      test('should return false for invalid store codes', () {
        expect(ValidationUtils.isValidStoreCode(''), isFalse);
        expect(ValidationUtils.isValidStoreCode('Store-Code'), isFalse); // uppercase
        expect(ValidationUtils.isValidStoreCode('store code'), isFalse); // spaces
        expect(ValidationUtils.isValidStoreCode('store_code'), isFalse); // underscores
      });
    });

    group('isValidContact', () {
      test('should return true for valid email or phone', () {
        expect(ValidationUtils.isValidContact('user@example.com'), isTrue);
        expect(ValidationUtils.isValidContact('7033443167'), isTrue);
        expect(ValidationUtils.isValidContact('+17033443167'), isTrue);
      });

      test('should return false for invalid contact', () {
        expect(ValidationUtils.isValidContact(''), isFalse);
        expect(ValidationUtils.isValidContact('invalid'), isFalse);
      });
    });
  });
}
