//
//  ColorExtensions.swift
//  SwifterSwift-iOS
//
//  Created by Omar Albeik on 9/27/17.
//  Copyright © 2017 SwifterSwift
//

// MARK: - Properties
public extension UIColor {

    /// SwifterSwift: Random color.
    public static var random: UIColor {
        let r = Int(arc4random_uniform(255))
        let g = Int(arc4random_uniform(255))
        let b = Int(arc4random_uniform(255))
        return UIColor(red: r, green: g, blue: b)!
    }

    /// SwifterSwift: RGB components for a Color (between 0 and 255).
    ///
    ///        UIColor.red.rgbComponents.red -> 255
    ///        NSColor.green.rgbComponents.green -> 255
    ///        UIColor.blue.rgbComponents.blue -> 255
    ///
    public var rgbComponents: (red: Int, green: Int, blue: Int) {
        var components: [CGFloat] {
            let c = cgColor.components!
            if c.count == 4 {
                return c
            }
            return [c[0], c[0], c[0], c[1]]
        }
        let r = components[0]
        let g = components[1]
        let b = components[2]
        return (red: Int(r * 255.0), green: Int(g * 255.0), blue: Int(b * 255.0))
    }

    /// SwifterSwift: RGB components for a Color represented as CGFloat numbers (between 0 and 1)
    ///
    ///        UIColor.red.rgbComponents.red -> 1.0
    ///        NSColor.green.rgbComponents.green -> 1.0
    ///        UIColor.blue.rgbComponents.blue -> 1.0
    ///
    public var cgFloatComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var components: [CGFloat] {
            let c = cgColor.components!
            if c.count == 4 {
                return c
            }
            return [c[0], c[0], c[0], c[1]]
        }
        let r = components[0]
        let g = components[1]
        let b = components[2]
        return (red: r, green: g, blue: b)
    }

    /// SwifterSwift: Hexadecimal value string (read-only).
    public var hexString: String {
        let components: [Int] = {
            let c = cgColor.components!
            let components = c.count == 4 ? c : [c[0], c[0], c[0], c[1]]
            return components.map { Int($0 * 255.0) }
        }()
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }

    /// SwifterSwift: Short hexadecimal value string (read-only, if applicable).
    public var shortHexString: String? {
        let string = hexString.replacingOccurrences(of: "#", with: "")
        let chrs = Array(string)
        guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else { return nil }
        return "#\(chrs[0])\(chrs[2])\(chrs[4])"
    }

    /// SwifterSwift: Alpha of Color (read-only).
    public var alpha: CGFloat {
        return cgColor.alpha
    }
}

// MARK: - Initializers
public extension UIColor {

    /// SwifterSwift: Create NSColor from RGB values with optional transparency.
    ///
    /// - Parameters:
    ///   - red: red component.
    ///   - green: green component.
    ///   - blue: blue component.
    ///   - transparency: optional transparency value (default is 1).
    public convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }

    /// SwifterSwift: Create NSColor from hexadecimal value with optional transparency.
    ///
    /// - Parameters:
    ///   - hex: hex Int (example: 0xDECEB5).
    ///   - transparency: optional transparency value (default is 1).
    public convenience init?(hex: Int, transparency: CGFloat = 1) {
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }

    /// SwifterSwift: Create Color from hexadecimal string with optional transparency (if applicable).
    ///
    /// - Parameters:
    ///   - hexString: hexadecimal string (examples: EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F, ..).
    ///   - transparency: optional transparency value (default is 1).
    public convenience init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }

        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }

        guard let hexValue = Int(string, radix: 16) else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }

}
