import 'package:dio/dio.dart';

/// Extrae los errores de validación (422) que manda Laravel, para poder
/// mostrarlos campo por campo en cualquier formulario de la app.
class ValidationErrors {
  const ValidationErrors(this.fieldErrors, this.message);

  final Map<String, String> fieldErrors;
  final String message;

  String? forField(String field) => fieldErrors[field];

  static ValidationErrors fromDioException(DioException e) {
    final data = e.response?.data;

    if (data is Map) {
      final errors = <String, String>{};

      if (data['errors'] is Map) {
        (data['errors'] as Map).forEach((field, messages) {
          if (messages is List && messages.isNotEmpty) {
            errors[field as String] = messages.first.toString();
          }
        });
      }

      final defaultMessage = errors.isNotEmpty
          ? 'Revisá los datos ingresados.'
          : 'Ocurrió un error. Intentá de nuevo.';

      return ValidationErrors(errors, data['message']?.toString() ?? defaultMessage);
    }

    return const ValidationErrors({}, 'Ocurrió un error. Intentá de nuevo.');
  }
}
