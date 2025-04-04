import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controladores para los campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  // Llave para el formulario (validación)
  final _formKey = GlobalKey<FormState>();
  
  // Variables para manejar estados
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _errorMessage;

  // Colores de la paleta
  final Color _primaryBlack = const Color(0xFF040404);
  final Color _primaryYellow = const Color(0xFFF5D321);
  final Color _lightGrey = const Color(0xFF7C7C7B);
  final Color _darkGrey = const Color(0xFF747474);
  final Color _white = const Color(0xFFFEFFFE);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Función para registrar usuario
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        // Crear usuario en Firebase Auth
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        
        // Actualizar el perfil del usuario con su nombre
        await userCredential.user?.updateDisplayName(_nameController.text.trim());
        
        // Opcional: Enviar email de verificación
        await userCredential.user?.sendEmailVerification();
        
        // Navegar a la pantalla principal después del registro exitoso
        if (mounted) {
          // Puedes mostrar un diálogo de éxito primero
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Cuenta creada exitosamente. Bienvenido/a ${_nameController.text}!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = _getMessageFromErrorCode(e.code);
        });
      } catch (e) {
        setState(() {
          _errorMessage = "Ocurrió un error inesperado. Inténtalo de nuevo.";
        });
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  // Traducir códigos de error de Firebase a mensajes amigables
  String _getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'Este correo electrónico ya está registrado.';
      case 'invalid-email':
        return 'El formato del correo electrónico no es válido.';
      case 'operation-not-allowed':
        return 'El registro con email y contraseña no está habilitado.';
      case 'weak-password':
        return 'La contraseña es demasiado débil.';
      default:
        return 'Error de registro. Inténtalo de nuevo.';
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
                  // Icono o logo
                  Icon(
                    Icons.person_add_outlined,
                    size: 70,
                    color: _primaryYellow,
                  ),
                  const SizedBox(height: 24),
                  
                  // Título
                  Text(
                    'Crear una cuenta',
                    style: TextStyle(
                      color: _white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  
                  // Subtítulo
                  Text(
                    'Completa tus datos para registrarte',
                    style: TextStyle(
                      color: _lightGrey,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  
                  // Campo de nombre
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: _white),
                    decoration: InputDecoration(
                      labelText: 'Nombre completo',
                      labelStyle: TextStyle(color: _lightGrey),
                      prefixIcon: Icon(Icons.person_outline, color: _lightGrey),
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
                        return 'Por favor ingresa tu nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
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
const SizedBox(height: 16),

// Campo de contraseña
TextFormField(
  controller: _passwordController,
  obscureText: _obscurePassword,
  style: TextStyle(color: _white),
  decoration: InputDecoration(
    labelText: 'Contraseña',
    labelStyle: TextStyle(color: _lightGrey),
    prefixIcon: Icon(Icons.lock_outline, color: _lightGrey),
    suffixIcon: IconButton(
      icon: Icon(
        _obscurePassword ? Icons.visibility_off : Icons.visibility,
        color: _lightGrey,
      ),
      onPressed: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
    ),
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
      return 'Por favor ingresa una contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  },
),
const SizedBox(height: 16),

// Campo de confirmación de contraseña
TextFormField(
  controller: _confirmPasswordController,
  obscureText: _obscureConfirmPassword,
  style: TextStyle(color: _white),
  decoration: InputDecoration(
    labelText: 'Confirmar contraseña',
    labelStyle: TextStyle(color: _lightGrey),
    prefixIcon: Icon(Icons.lock_outline, color: _lightGrey),
    suffixIcon: IconButton(
      icon: Icon(
        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
        color: _lightGrey,
      ),
      onPressed: () {
        setState(() {
          _obscureConfirmPassword = !_obscureConfirmPassword;
        });
      },
    ),
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
      return 'Por favor confirma tu contraseña';
    }
    if (value != _passwordController.text) {
      return 'Las contraseñas no coinciden';
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
if (_errorMessage != null) const SizedBox(height: 16),

// Términos y condiciones
Row(
  children: [
    SizedBox(
      height: 24,
      width: 24,
      child: Checkbox(
        value: true,
        onChanged: (value) {
          // Implementar lógica para aceptar términos
        },
        activeColor: _primaryYellow,
        checkColor: _primaryBlack,
        side: BorderSide(color: _lightGrey),
      ),
    ),
    const SizedBox(width: 8),
    Expanded(
      child: Text.rich(
        TextSpan(
          text: 'Acepto los ',
          style: TextStyle(color: _lightGrey),
          children: [
            TextSpan(
              text: 'Términos y Condiciones',
              style: TextStyle(
                color: _primaryYellow,
                fontWeight: FontWeight.bold,
              ),
              // Puedes agregar reconocimiento de tap aquí
            ),
            TextSpan(text: ' y la '),
            TextSpan(
              text: 'Política de Privacidad',
              style: TextStyle(
                color: _primaryYellow,
                fontWeight: FontWeight.bold,
              ),
              // Puedes agregar reconocimiento de tap aquí
            ),
          ],
        ),
      ),
    ),
  ],
),
const SizedBox(height: 24),

// Botón de registro
ElevatedButton(
  onPressed: _isLoading ? null : _register,
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
      : const Text('CREAR CUENTA'),
),
const SizedBox(height: 24),
                  
                  // Separador
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: _darkGrey, thickness: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'O regístrate con',
                          style: TextStyle(color: _lightGrey),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: _darkGrey, thickness: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Botones de redes sociales
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialButton(
                        icon: Icons.g_mobiledata_rounded,
                        onPressed: () {
                          // Implementar registro con Google
                        },
                      ),
                      const SizedBox(width: 16),
                      _socialButton(
                        icon: Icons.facebook,
                        onPressed: () {
                          // Implementar registro con Facebook
                        },
                      ),
                      const SizedBox(width: 16),
                      _socialButton(
                        icon: Icons.apple,
                        onPressed: () {
                          // Implementar registro con Apple
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Enlace para iniciar sesión
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Ya tienes una cuenta?',
                        style: TextStyle(color: _lightGrey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          'Inicia sesión',
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

  // Widget para los botones de redes sociales
  Widget _socialButton({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: _primaryBlack,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _darkGrey),
        ),
        child: Icon(
          icon,
          color: _white,
          size: 30,
        ),
      ),
    );
  }
}