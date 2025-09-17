// lib/screens/scan/camera_screen.dart
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'preview_screen.dart'; // Halaman buat nampilin hasil foto

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras.first, // Pake kamera utama (belakang)
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Wajib di-dispose biar nggak memory leak
    super.dispose();
  }

  void _onTakePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      if (!mounted) return;

      // Lempar hasil foto ke halaman preview
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(imagePath: image.path),
        ),
      );
    } catch (e) {
      debugPrint("Error taking picture: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Jika kamera siap, tampilkan preview
            return Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(_controller),
                // Tombol shutter di bawah
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: IconButton(
                      onPressed: _onTakePicture,
                      icon: const Icon(
                        Icons.camera,
                        color: Colors.white,
                        size: 72,
                      ),
                      style: IconButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Kalo belum siap, tampilkan loading spinner
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
