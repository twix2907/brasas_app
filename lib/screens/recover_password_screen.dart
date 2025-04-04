import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({Key? key}) : super(key: key);

  @override
  _RecoverPasswordScreenState createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  // Controlador para el campo de texto
  final TextEditingController _emailController = TextEditingController();
  
  // Llave para el formulario (validación)
  final _formKey = GlobalKey<FormState>();
  
  // Variables para manejar estados
  bool _isLoading = false;
  String? _errorMessage;
  bool _emailSent = false;

  // Colores de la paleta
  final Color _primaryBlack = const Color(0xFF040404);
  final Color _primaryYellow = const Color(0xFFF5D321);
  final Color _lightGrey = const Color(0xFF7C7C7B);
  final Color _darkGrey = const Color(0xFF747474);
  final Color _white = const Color(0xFFFEFFFE);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Función para enviar correo de recuperación
  Future<void> _recoverPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim(),
        );
        setState(() {
          _emailSent = true;
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = _getMessageFromErrorCode(e.code);
        });
      } catch (e) {
        setState(() {
          _errorMessage = "Ocurrió un error inesperado. Inténtalo de nuevo.";
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Traducir códigos de error de Firebase a mensajes amigables
  String _getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'El formato del correo electrónico no es válido.';
      case 'user-not-found':
        return 'No existe una cuenta con este correo electrónico.';
      default:
        return 'Error al enviar el correo. Inténtalo de nuevo.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Icono
                  Icon(
                    Icons.lock_reset_outlined,
                    size: 80,
                    color: _primaryYellow,
                  ),
                  const SizedBox(height: 32),
                  
                  // Título
                  Text(
                    'Recuperar contraseña',
                    style: TextStyle(
                      color: _white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  
                  if (!_emailSent)
                    Column(
                      children: [
                        // Instrucciones
                        Text(
                          'Ingresa tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.',
                          style: TextStyle(
                            color: _lightGrey,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        
                        // Campo de correo electrónico
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: _white),
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            labelStyle: TextStyle(color: _lightGrey),
                             prefixIcon: Icon(Icons.email_outlined, color: _lightGrey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: _darkGrey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: _darkGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: _primaryYellow, width: 2),
                            ),
                            filled: true,
                            fillColor: _primaryBlack,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu correo electrónico';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'Ingresa un correo electrónico válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        
                        // Mensaje de error si existe
                        if (_errorMessage != null)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.shade300),
                            ),
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(color: Colors.red.shade300),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        if (_errorMessage != null) const SizedBox(height: 24),
                        
                        // Botón de enviar
                        ElevatedButton(
                          onPressed: _isLoading ? null : _recoverPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryYellow,
                            foregroundColor: _primaryBlack,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(_primaryBlack),
                                  ),
                                )
                              : const Text('ENVIAR CORREO'),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        // Mensaje de éxito
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green.shade300),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.green.shade300,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '¡Correo enviado!',
                                style: TextStyle(
                                  color: Colors.green.shade300,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Hemos enviado un correo electrónico a ${_emailController.text} con instrucciones para restablecer tu contraseña.',
                                style: TextStyle(
                                  color: _white,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Botón para volver al login
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/login');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryYellow,
                            foregroundColor: _primaryBlack,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          child: const Text('VOLVER AL INICIO DE SESIÓN'),
                        ),
                      ],
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // Enlace para volver a iniciar sesión
                  if (!_emailSent)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Recordaste tu contraseña?',
                          style: TextStyle(color: _lightGrey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Volver al inicio de sesión',
                            style: TextStyle(
                              color: _primaryYellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}