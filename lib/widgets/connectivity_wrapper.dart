import 'package:flutter/material.dart';
import 'package:hemle/features/errors/presentation/screens/connecterror_screen.dart';
import 'package:hemle/utils/connectivity_service.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _setupListener();
  }

  // Vérifier l'état initial
  Future<void> _initConnectivity() async {
    final isConnected = await ConnectivityService.isConnected;
    if (mounted) {
      setState(() {
        _isConnected = isConnected;
      });
    }
  }

  // Écouter les changements
  void _setupListener() {
    ConnectivityService.onConnectionChange.listen((bool isConnected) {
      if (mounted) {
        setState(() {
          _isConnected = isConnected;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isConnected ? widget.child : const ConnecterrorScreen();
  }
}