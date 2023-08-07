import 'package:activities_app/core/error/failures.dart';

// Error messages.
const userCredentialsMismatchMessage = 'El email y contraseña no coinciden';
const notFoundMessage = 'No ha sido encontrado';
const userNotFoundFailureMessage = 'El usuario no existe';
const serverFailureMessage = 'Ha ocurrido un error en el servidor';
const cacheFailureMessage = 'Ha ocurrido un error en el caché';
const unknownFailureMessage = 'Ha ocurrido un error desconocido';
const notAuthorizedFailureMessage = 'No está autorizado para ejecutar acción';
const notEnrolledFailureMessage = 'No está inscrito en el curso';

class Utils {
  static String getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case UserCredentialsMismatchFailure:
        return userCredentialsMismatchMessage;

      case NotFoundFailure:
        return notFoundMessage;

      case ServerFailure:
        return serverFailureMessage;

      case CacheFailure:
        return cacheFailureMessage;

      case UserNotFoundFailure:
        return userNotFoundFailureMessage;

      case NotAuthorizedFailure:
        return notAuthorizedFailureMessage;

      case NotEnrolledFailure:
        return notEnrolledFailureMessage;

      default:
        return 'Ha ocurrido un error desconocido';
    }
  }
}
