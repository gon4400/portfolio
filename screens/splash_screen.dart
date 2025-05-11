import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'portfolio_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late FirebaseRemoteConfig _remoteConfig;
  bool _isConfigLoaded = false;
  List<Map<String, String>> _projects = [];
  String _linkedinUrl = '';
  String _githubUrl = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _initializeRemoteConfig();
  }

  Future<void> _initializeRemoteConfig() async {
    _remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      await _remoteConfig.fetchAndActivate();
      _setConfigData();
    } catch (e) {
      print("Erreur Firebase : $e");
      _setDefaultConfig();
    }
    // Navigation après le chargement de la config
    Future.delayed(Duration(seconds: 2), _navigateToHome);
  }

  void _setDefaultConfig() {
  /*  _projects = [
      {
        'title': 'Kidizz',
        'description': 'Application parentale avec suivi des activités, photos et messages.',
        'image_asset': 'assets/images/kidizz_logo.png',
        'link': '',
      },
      {
        'title': 'MyBatteryHealth',
        'description': 'Suivi de la santé de la batterie pour Android.',
        'image_asset': 'assets/images/mybatteryhealth.png',
        'link': '',
      },
    ];
    _linkedinUrl = '';
    _githubUrl = '';*/
    _isConfigLoaded = true;
  }

  void _setConfigData() {
    List<String> projectIds = [
      'porfolio',
      'planchettes',
      'info_traffic',
      'kidizz',
      'mybatteryhealth_ios',
      'mybatteryhealth_android',
      't4u_ios',
      't4u_android',
      'vinslocal',
      'afpahotellerie',
      'afparestaurant',
      'proxiservices',
      'wifibot',
    ];

    Map<String, String> imageAssets = {
      'porfolio': 'assets/icon/app_icon.png',
      'planchettes': 'assets/images/semitan_logo.png',
      'info_traffic': 'assets/images/semitan_logo.png',
      'kidizz': 'assets/images/kidizz_logo.png',
      'mybatteryhealth_ios': 'assets/images/mybatteryhealth.png',
      'mybatteryhealth_android': 'assets/images/mybatteryhealth.png',
      't4u_ios': 'assets/images/t4u.png',
      't4u_android': 'assets/images/t4u.png',
      'vinslocal': 'assets/images/leckcie_logo.png',
      'afpahotellerie': 'assets/images/afpa_logo.jpg',
      'afparestaurant': 'assets/images/afpa_logo.jpg',
      'proxiservices': 'assets/images/afpa_logo.jpg',
      'wifibot': 'assets/images/gaston_bachelard_logo.png',
    };

    Map<String, String> animationAssets = {
      'planchettes': 'assets/images/semitan.jpeg',
      'info_traffic': 'assets/images/semitan.jpeg',
    };

    _projects = projectIds.map((id) {
      return {
        'title': _remoteConfig.getString('project_${id}_title'),
        'description': _remoteConfig.getString('project_${id}_description'),
        'image_asset': imageAssets[id] ?? 'assets/images/default.jpg',
        'animation': animationAssets[id] ?? 'assets/images/default.jpg',
        'link': _remoteConfig.getString('project_${id}_link')
      };
    }).toList();

    _linkedinUrl = _remoteConfig.getString('linkedinLink');
    _githubUrl = _remoteConfig.getString('githubLink');
    _email = _remoteConfig.getString('email');
    _isConfigLoaded = true;
  }


  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PortfolioScreen(
          projects: _projects,
          linkedinUrl: _linkedinUrl,
          githubUrl: _githubUrl,
          email: _email,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/app_icon.png',
              width: 120,
              height: 120,
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 3.5,
            ),
          ],
        ),
      ),
    );
  }
}