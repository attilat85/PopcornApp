// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum L10n {
  /// Find the movie
  internal static let findTheMovie = L10n.tr("Localizable", "Find the movie")
  /// No
  internal static let no = L10n.tr("Localizable", "No")
  /// No movies found
  internal static let noMoviesFound = L10n.tr("Localizable", "No movies found")
  /// N/A
  internal static let notAvailable = L10n.tr("Localizable", "Not available")
  /// OK
  internal static let ok = L10n.tr("Localizable", "Ok")
  /// Ooups
  internal static let ooups = L10n.tr("Localizable", "Ooups")
  /// Trending Movies
  internal static let trendingMovies = L10n.tr("Localizable", "Trending Movies")
  /// Yes
  internal static let yes = L10n.tr("Localizable", "Yes")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
