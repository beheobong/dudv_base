import 'package:logger/logger.dart';

mixin LoggerPresenter {
  final logger = Logger(
    printer: PrettyPrinter(),
  );
}
