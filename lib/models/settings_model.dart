import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'settings_model.g.dart';

const int _isDarkModeHiveIndex = 0;
const int _fontSizeModeHiveIndex = 1;

@HiveType(typeId: 4)
class Settings extends Equatable {
  @HiveField(_isDarkModeHiveIndex)
  final bool isDarkMode;
  @HiveField(_fontSizeModeHiveIndex)
  final double fontSize;

  const Settings({required this.isDarkMode, required this.fontSize});

  Settings copyWith({
    bool? isDarkMode,
    double? fontSize,
  }) {
    return Settings(
        isDarkMode: isDarkMode ?? this.isDarkMode,
        fontSize: fontSize ?? this.fontSize);
  }

  @override
  List<Object?> get props => [isDarkMode, fontSize];
}
