import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../providers/auth_provider.dart';
import '../../services/user_service.dart';
import '../../config/api_config.dart';
import '../../models/auth_models.dart';
import '../../providers/api_providers.dart';

/// Password dialog for verifying owner password before sensitive operations
class PasswordDialog extends ConsumerStatefulWidget {
  final String title;
  final String message;
  final VoidCallback onVerified;

  const PasswordDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onVerified,
  });

  @override
  ConsumerState<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends ConsumerState<PasswordDialog> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _verifyPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authState = ref.read(authProvider);
      final user = authState.user;
      
      if (user == null) {
        setState(() {
          _errorMessage = 'User not authenticated';
          _isLoading = false;
        });
        return;
      }

      // Get contact info from user profile and business data
      debugPrint('=== User Debug ===');
      debugPrint('User: $user');
      debugPrint('User ID: ${user.userId}');
      debugPrint('User Type: ${user.userType}');
      debugPrint('User Business ID: ${user.businessId}');
      debugPrint('User Store Code: ${user.storeCode}');
      debugPrint('User Businesses: ${user.businesses}');
      debugPrint('==================');
      
      String? contact;
      String? storeCode;
      try {
        debugPrint('Fetching user profile for userId: ${user.userId}');
        final userService = ref.read(userServiceProvider);
        final userProfile = await userService.getUser(user.userId);
        
        debugPrint('User profile fetched: phone=${userProfile.phoneNumber}, email=${userProfile.email}');
        
        if (userProfile.phoneNumber != null && userProfile.phoneNumber!.isNotEmpty) {
          contact = userProfile.phoneNumber!;
        } else if (userProfile.email != null && userProfile.email!.isNotEmpty) {
          contact = userProfile.email!;
        }
        
        // Get store code from user storeCode or fallback to business detail query
        storeCode = user.storeCode; // Already from auth, includes store_code from user's current session
        
        debugPrint('Initial storeCode from user: $storeCode');
        
        if (storeCode == null || storeCode.isEmpty) {
            // Fallback: try to get from business info
          final authState = ref.read(authProvider);
          final currentBusinessId = authState.currentBusinessId;
          debugPrint('Current business ID: $currentBusinessId');
          
          if (currentBusinessId != null) {
            final businessService = ref.read(businessServiceProvider);
            try {
              debugPrint('Fetching business detail for businessId: $currentBusinessId');
              final businessDetail = await businessService.getBusiness(currentBusinessId);
              storeCode = businessDetail.storeCode;
              debugPrint('StoreCode from business detail: $storeCode');
            } catch (e) {
              debugPrint('Error fetching business detail: $e');
              // Fallback to user's storeCode from auth response
              storeCode = user.storeCode;
            }
          }
        }
        
        if (storeCode == null || storeCode.isEmpty) {
          storeCode = user.storeCode; // Final fallback to auth storeCode
        }
        
        debugPrint('Final contact: $contact, Final storeCode: $storeCode');
      } catch (e) {
        debugPrint('Error fetching user profile: $e');
        debugPrint('Error type: ${e.runtimeType}');
        // If we can't fetch user profile, we'll need to prompt for contact
        setState(() {
          _errorMessage = 'Unable to retrieve contact information: ${e.toString()}';
          _isLoading = false;
        });
        return;
      }

      if (contact == null || storeCode == null) {
        setState(() {
          _errorMessage = 'Contact or business information not available';
          _isLoading = false;
        });
        return;
      }

      // Debug: print values before creating request
      debugPrint('=== Password Verification Debug ===');
      debugPrint('Contact: $contact');
      debugPrint('StoreCode: $storeCode');
      debugPrint('Password length: ${_passwordController.text.length}');

      // Create a fresh Dio instance without any interceptors for password verification
      // This prevents the "business context required" error when already authenticated
      final loginRequest = LoginRequest(
        contact: contact,
        password: _passwordController.text,
        storeCode: storeCode, // Use storeCode from business data query above
      );

      // Debug: print request body JSON
      final requestJson = loginRequest.toJson();
      debugPrint('Request JSON: $requestJson');
      debugPrint('Request body: ${requestJson.toString()}');

      // Create a completely fresh Dio instance with only base configuration
      // No interceptors to ensure no request modification
      final dio = Dio(BaseOptions(
        baseUrl: ApiConfig.apiBaseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        headers: ApiConfig.defaultHeaders,
        // Explicitly do NOT include Authorization header
      ));
      // Do NOT add any interceptors - we want a clean, unauthenticated request

      // Debug: print request details
      final requestUrl = '${dio.options.baseUrl}/auth/login';
      debugPrint('=== Request Debug ===');
      debugPrint('Request URL: $requestUrl');
      debugPrint('Request Method: POST');
      debugPrint('Request Data: $requestJson');
      debugPrint('Request Data Type: ${requestJson.runtimeType}');
      debugPrint('Request Headers: ${dio.options.headers}');
      debugPrint('Base URL: ${dio.options.baseUrl}');
      debugPrint('Contact: $contact');
      debugPrint('StoreCode: $storeCode');
      debugPrint('Password (length): ${_passwordController.text.length}');
      debugPrint('==============================');

      // Make unauthenticated login request for password verification
      final response = await dio.post(
        '/auth/login',
        data: requestJson,
      );

      // Debug: print response
      debugPrint('=== Response Debug ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data: ${response.data}');
      debugPrint('Response Data Type: ${response.data.runtimeType}');
      debugPrint('Response Headers: ${response.headers}');
      debugPrint('Request Options Data: ${response.requestOptions.data}');
      debugPrint('Request Options Headers: ${response.requestOptions.headers}');
      debugPrint('Request Options Path: ${response.requestOptions.path}');
      debugPrint('Request Options Base URL: ${response.requestOptions.baseUrl}');
      debugPrint('Full Request URL: ${response.requestOptions.uri}');
      debugPrint('====================');

      // Check if response is successful (200-299)
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        // Password verified successfully (even if response data is null)
        debugPrint('Password verification successful (status: ${response.statusCode})');
        if (mounted) {
          Navigator.of(context).pop();
          widget.onVerified();
        }
        return;
      }

      // Handle error response
      debugPrint('ERROR: Response status: ${response.statusCode}');
      debugPrint('Error Response: ${response.data}');
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    } catch (e) {
      // Debug: print error details
      debugPrint('=== Error Debug ===');
      debugPrint('Error type: ${e.runtimeType}');
      debugPrint('Error message: $e');
      if (e is DioException) {
        debugPrint('DioException type: ${e.type}');
        debugPrint('DioException response: ${e.response?.data}');
        debugPrint('DioException statusCode: ${e.response?.statusCode}');
      }
      debugPrint('==================');
      
      setState(() {
        _errorMessage = 'Invalid password. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.message,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark 
                      ? const Color(0xFFA3A3A3) 
                      : const Color(0xFF737373).withValues(alpha: 1.0),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                enabled: !_isLoading,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _verifyPassword(),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _verifyPassword,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Verify'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
