import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Utility for encrypting/decrypting passwords stored locally
/// Uses AES encryption with a key derived from device-specific storage
class PasswordEncryption {
  static const String _keyPrefsKey = '_password_encryption_key';
  static const String _ivPrefsKey = '_password_encryption_iv';
  
  /// Get or generate encryption key
  static Future<Key> _getKey() async {
    final prefs = await SharedPreferences.getInstance();
    String? keyString = prefs.getString(_keyPrefsKey);
    
    if (keyString == null) {
      // Generate new key (32 bytes for AES-256)
      final key = Key.fromSecureRandom(32);
      await prefs.setString(_keyPrefsKey, key.base64);
      return key;
    }
    
    return Key.fromBase64(keyString);
  }
  
  /// Get or generate IV (Initialization Vector)
  static Future<IV> _getIV() async {
    final prefs = await SharedPreferences.getInstance();
    String? ivString = prefs.getString(_ivPrefsKey);
    
    if (ivString == null) {
      // Generate new IV (16 bytes for AES)
      final iv = IV.fromSecureRandom(16);
      await prefs.setString(_ivPrefsKey, iv.base64);
      return iv;
    }
    
    return IV.fromBase64(ivString);
  }
  
  /// Encrypt a password
  static Future<String> encrypt(String password) async {
    final key = await _getKey();
    final iv = await _getIV();
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }
  
  /// Decrypt a password
  static Future<String> decrypt(String encryptedPassword) async {
    try {
      final key = await _getKey();
      final iv = await _getIV();
      final encrypter = Encrypter(AES(key));
      final encrypted = Encrypted.fromBase64(encryptedPassword);
      return encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      throw Exception('Failed to decrypt password: $e');
    }
  }
}
