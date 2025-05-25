import UIKit

public enum DSToken {
    public enum Spacing {
        public static let xxSmall: CGFloat = 4
        public static let xSmall: CGFloat = 8
        public static let small: CGFloat = 12
        public static let medium: CGFloat = 16
        public static let large: CGFloat = 24
        public static let xLarge: CGFloat = 32
    }

    public enum Typography {
        public static let title1: UIFont = .systemFont(ofSize: 24, weight: .bold)
        public static let title2: UIFont = .systemFont(ofSize: 20, weight: .semibold)
        public static let body: UIFont   = .systemFont(ofSize: 16, weight: .regular)
        public static let caption: UIFont = .systemFont(ofSize: 12, weight: .regular)
    }

    public enum Color {
        public static let primary: UIColor   = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        public static let secondary: UIColor = .darkGray
        public static let background: UIColor = .white
        public static let border: UIColor    = UIColor(white: 0.9, alpha: 1)
        public static let textPrimary: UIColor = .black
        public static let textSecondary: UIColor = .darkGray
    }
}
