//
//  BrandingColors.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

/// Цветовая палитра
extension UIColor {
    
    public struct Branding {
        // MARK: Text
        public struct Text {
            public static let black: UIColor = UIColor.black
            public static let darkGrey: UIColor = UIColor(red: 139 / 255, green: 151 / 255, blue: 163 / 255, alpha: 1)
            public static let grey: UIColor = UIColor(red: 187 / 255, green: 194 / 255, blue: 200 / 255, alpha: 1)
            public static let red: UIColor = UIColor(red: 1, green: 56 / 255, blue: 36 / 255, alpha: 1)
            public static let white: UIColor = UIColor.white
        }
        
        // MARK: Input
        public struct Input {
            public static let grey: UIColor = UIColor(red: 187 / 255, green: 194 / 255, blue: 200 / 255, alpha: 1)
            public static let blue: UIColor = UIColor(red: 0, green: 174 / 255, blue: 199 / 255, alpha: 1)
            public static let red: UIColor = UIColor(red: 1, green: 56 / 255, blue: 36 / 255, alpha: 1)
        }
        
        // MARK: Button
        public struct Button {
            public static let lightGrey: UIColor = UIColor(red: 230 / 255, green: 234 / 255, blue: 237 / 255, alpha: 1)
            public static let blue: UIColor = UIColor(red: 0, green: 174 / 255, blue: 199 / 255, alpha: 1)
            public static let lightBlue: UIColor = UIColor(red: 240 / 255, green: 250 / 255, blue: 252 / 255, alpha: 1)
            public static let grafit: UIColor = UIColor(red: 51 / 255, green: 64 / 255, blue: 72 / 255, alpha: 1)
            public static let yellow: UIColor = UIColor(red: 1, green: 199 / 255, blue: 0, alpha: 1)
            public static let orange: UIColor = UIColor(red: 231 / 255, green: 138 / 255, blue: 44 / 255, alpha: 1)
            public static let white: UIColor = UIColor.white
        }
        
        // MARK: Icon
        public struct Icon {
        }
        
        // MARK: Separator
        public struct Separator {
            public static let lightGrey: UIColor = UIColor(red: 229 / 255, green: 234 / 255, blue: 237 / 255, alpha: 1)
            public static let grafit: UIColor = UIColor(red: 51 / 255, green: 64 / 255, blue: 72 / 255, alpha: 1)
            public static let blue: UIColor = UIColor(red: 0, green: 174 / 255, blue: 201 / 255, alpha: 1)
            public static let grey: UIColor = UIColor(red: 178 / 255, green: 194 / 255, blue: 200 / 255, alpha: 1)
        }
        
        // MARK: Background
        public struct Background {
            public static let `default`: UIColor = UIColor.white
            public static let clear: UIColor = UIColor.clear
            public static let grey: UIColor = UIColor(red: 187 / 255, green: 194 / 255, blue: 200 / 255, alpha: 1)
        }
        
        // MARK: Shadow
        public struct Shadow {
            public static let black: UIColor = UIColor.black
        }
        
        // MARK: Border
        public struct Border {
            public static let grey: UIColor = UIColor(red: 229 / 255, green: 234 / 255, blue: 237 / 255, alpha: 1)
        }
    }
}


