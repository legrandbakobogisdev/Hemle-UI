import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/auth/presentation/screens/loginAccount_screen.dart';
import 'package:local_auth/local_auth.dart';

class TouchidScreen extends StatefulWidget {
  const TouchidScreen({super.key});

  @override
  State<TouchidScreen> createState() => _TouchidScreenState();
}

class _TouchidScreenState extends State<TouchidScreen> {
  String status = 'nothing';
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isTouchIDAvailable = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkTouchIDAvailability();
  }

  Future<void> _checkTouchIDAvailability() async {
    try {
      final bool canAuthenticate = await _localAuth.canCheckBiometrics;
      final List<BiometricType> availableBiometrics = await _localAuth
          .getAvailableBiometrics();

      // Vérifier spécifiquement si l'empreinte digitale est disponible
      final bool isTouchAvailable = availableBiometrics.contains(
        BiometricType.fingerprint,
      );

      setState(() {
        _isTouchIDAvailable = canAuthenticate && isTouchAvailable;
        _errorMessage = _isTouchIDAvailable
            ? null
            : 'auth.biometric.touchid.not_available'.tr();
      });

      if (_isTouchIDAvailable) {
        _authenticateWithTouchID();
      }
    } on LocalAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      setState(() {
        _isTouchIDAvailable = false;
        _errorMessage = 'auth.biometric.unknown_error'.tr();
      });
    }
  }

  Future<void> _authenticateWithTouchID() async {
    try {
      setState(() {
        status = 'authenticating';
        _errorMessage = null;
      });

      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'auth.biometric.touchid.reason'.tr(),
        biometricOnly: true,
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
          _errorMessage = 'auth.biometric.touchid.fail'.tr();
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
          _errorMessage = 'auth.biometric.touchid.no_hardware'.tr();
          break;
        case LocalAuthExceptionCode.temporaryLockout:
          _errorMessage = 'auth.biometric.touchid.temporary_lockout'.tr();
          break;
        case LocalAuthExceptionCode.biometricLockout:
          _errorMessage = 'auth.biometric.touchid.lockout'.tr();
          break;
        case LocalAuthExceptionCode.noBiometricsEnrolled:
          _errorMessage = 'auth.biometric.touchid.not_enrolled'.tr();
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
                  ? 'auth.biometric.touchid.authenticating'.tr()
                  : 'auth.biometric.touchid.title'.tr(),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),

            const SizedBox(height: 10),

            // Message d'erreur spécifique
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

            // Zone d'authentification
            _buildAuthenticationZone(),

            // Bouton réessayer si échec
            if (status == 'fail' && _isTouchIDAvailable)
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/10.png'),
                    CupertinoButton(
                      sizeStyle: CupertinoButtonSize.small,
                      onPressed: _authenticateWithTouchID,
                      child: CustomText(
                        label: 'global.tryagain'.tr(),
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

            // Texte de scanning seulement si en attente
            if (status == 'nothing' || status == 'authenticating')
              CustomText(
                label: 'auth.biometric.touchid.scanning'.tr(),
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
        return 'auth.biometric.touchid.fail_message'.tr();
      case 'authenticating':
        return 'auth.biometric.touchid.authenticating_desc'.tr();
      case 'success':
        return 'auth.biometric.touchid.success'.tr();
      default:
        return 'auth.biometric.touchid.desc'.tr();
    }
  }

  Widget _buildAuthenticationZone() {
    switch (status) {
      case 'authenticating':
        return GestureDetector(
          onTap: _authenticateWithTouchID,
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
          onTap: _authenticateWithTouchID,
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
          onTap: _isTouchIDAvailable ? _authenticateWithTouchID : null,
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Image.asset("assets/images/5.png", width: 86, height: 86),
            ),
          ),
        );

      default:
        return GestureDetector(
          onTap: _isTouchIDAvailable ? _authenticateWithTouchID : null,
          child: const SizedBox(height: 200, width: double.infinity),
        );
    }
  }
}
