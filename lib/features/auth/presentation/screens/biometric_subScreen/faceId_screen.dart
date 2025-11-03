import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/auth/presentation/screens/loginAccount_screen.dart';
import 'package:local_auth/local_auth.dart';

class FaceidScreen extends StatefulWidget {
  const FaceidScreen({super.key});

  @override
  State<FaceidScreen> createState() => _FaceidScreenState();
}

class _FaceidScreenState extends State<FaceidScreen> {
  String status = 'nothing';
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isFaceIDAvailable = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkFaceIDAvailability();
  }

  Future<void> _checkFaceIDAvailability() async {
    try {
      final bool canAuthenticate = await _localAuth.canCheckBiometrics;
      final List<BiometricType> availableBiometrics = await _localAuth
          .getAvailableBiometrics();

      // Vérifier spécifiquement si Face ID est disponible
      final bool isFaceAvailable = availableBiometrics.contains(
        BiometricType.face,
      );

      setState(() {
        _isFaceIDAvailable = canAuthenticate && isFaceAvailable;
        _errorMessage = _isFaceIDAvailable
            ? null
            : 'auth.biometric.faceid.not_available'.tr();
      });

      if (_isFaceIDAvailable) {
        _authenticateWithFaceID();
      }
    } on LocalAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      setState(() {
        _isFaceIDAvailable = false;
        _errorMessage = 'auth.biometric.unknown_error'.tr();
      });
    }
  }

  Future<void> _authenticateWithFaceID() async {
    try {
      setState(() {
        status = 'authenticating';
        _errorMessage = null;
      });

      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'auth.biometric.faceid.reason'.tr(),
        biometricOnly: true, // Force l'utilisation biométrique
      );

      if (didAuthenticate) {
        setState(() {
          status = 'success';
        });

        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(builder: (context) => LoginaccountScreen()),
          );
        }
      } else {
        setState(() {
          status = 'fail';
          _errorMessage = 'auth.biometric.faceid.fail'.tr();
        });
      }
    } on LocalAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      setState(() {
        status = 'fail';
        _errorMessage = 'auth.biometric.unknown_error'.tr();
      });
    }
  }

  void _handleAuthException(LocalAuthException e) {
    setState(() {
      status = 'fail';

      switch (e.code) {
        case LocalAuthExceptionCode.noBiometricHardware:
          _errorMessage = 'auth.biometric.faceid.no_hardware'.tr();
          break;
        case LocalAuthExceptionCode.temporaryLockout:
          _errorMessage = 'auth.biometric.faceid.temporary_lockout'.tr();
          break;
        case LocalAuthExceptionCode.biometricLockout:
          _errorMessage = 'auth.biometric.faceid.lockout'.tr();
          break;
        case LocalAuthExceptionCode.noBiometricsEnrolled:
          _errorMessage = 'auth.biometric.faceid.not_enrolled'.tr();
          break;
        default:
          _errorMessage = 'auth.biometric.unknown_error'.tr();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: status == 'fail'
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/9.png'),
                  CupertinoButton(
                    sizeStyle: CupertinoButtonSize.small,
                    child: CustomText(
                      label: 'global.usepass'.tr(),
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LoginaccountScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : null,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              label: status == 'fail'
                  ? 'Oops!'
                  : status == 'authenticating'
                  ? 'auth.biometric.faceid.authenticating'.tr()
                  : 'auth.biometric.faceid.title'.tr(),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),

            const SizedBox(height: 10),

            if (_errorMessage != null)
              CustomText(
                label: _errorMessage!,
                fontSize: 14,
                color: AppColors.error,
                textAlign: TextAlign.center,
              ),

            CustomText(
              label: _getDescriptionText(),
              fontSize: 16,
              textAlign: TextAlign.center,
            ),

            _buildAuthenticationZone(),

            if (status == 'fail' && _isFaceIDAvailable)
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/10.png'),
                    CupertinoButton(
                      sizeStyle: CupertinoButtonSize.small,
                      onPressed: _authenticateWithFaceID,
                      child: CustomText(
                        label: 'global.tryagain'.tr(),
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

            if (status == 'nothing' || status == 'authenticating')
              CustomText(
                label: 'auth.biometric.faceid.scanning'.tr(),
                fontSize: 16,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  String _getDescriptionText() {
    switch (status) {
      case 'fail':
        return 'auth.biometric.faceid.fail_message'.tr();
      case 'authenticating':
        return 'auth.biometric.faceid.authenticating_desc'.tr();
      case 'success':
        return 'auth.biometric.faceid.success'.tr();
      default:
        return 'auth.biometric.faceid.desc'.tr();
    }
  }

  Widget _buildAuthenticationZone() {
    switch (status) {
      case 'authenticating':
        return GestureDetector(
          onTap: _authenticateWithFaceID,
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Image.asset("assets/images/4.png", width: 86, height: 86),
            ),
          ),
        );

      case 'success':
        return GestureDetector(
          onTap: _authenticateWithFaceID,
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Image.asset("assets/images/4.png", width: 86, height: 86),
            ),
          ),
        );

      case 'fail':
        return GestureDetector(
          onTap: _isFaceIDAvailable ? _authenticateWithFaceID : null,
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Image.asset("assets/images/6.png", width: 86, height: 86),
            ),
          ),
        );

      default:
        return GestureDetector(
          onTap: _isFaceIDAvailable ? _authenticateWithFaceID : null,
          child: const SizedBox(height: 200, width: double.infinity),
        );
    }
  }
}
