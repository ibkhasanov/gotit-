//
//  BrandingFonts.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

/// Шрифты
extension UIFont {
    
    public struct Branding {
        
        public struct Header {
            /// Header/h1 34|40 bold
            public static let h1 = UIFont.systemFont(ofSize: 34, weight: .bold)
            /// Header/h2 24|32 bold
            public static let h2 = UIFont.systemFont(ofSize: 24, weight: .bold)
            /// Header/h3 20|28 bold
            public static let h3 = UIFont.systemFont(ofSize: 20, weight: .bold)
            /// Header/h4 18|24 bold
            public static let h4 = UIFont.systemFont(ofSize: 18, weight: .bold)
            /// Header/h5 16|24 bold
            public static let h5 = UIFont.systemFont(ofSize: 16, weight: .bold)
            /// Header/h6 16|24 medium
            public static let h6 = UIFont.systemFont(ofSize: 16, weight: .medium)
            /// Header/h7 14|20 medium
            public static let h7 = UIFont.systemFont(ofSize: 14, weight: .medium)
        }
        public struct Body {
            /// Body/b1 16|24 medium
            public static let b1 = UIFont.systemFont(ofSize: 16, weight: .medium)
            /// Body/b2 14|18 medium
            public static let b2 = UIFont.systemFont(ofSize: 14, weight: .medium)
        }
        
        public struct Component {
            /// Comment/c 12|16 medium
            public static let comment = UIFont.systemFont(ofSize: 12, weight: .medium)
        }
        
        public struct Input {
            /// Input/text 16|24 medium
            public static let text = UIFont.systemFont(ofSize: 16, weight: .medium)
            /// Input/amount 24|28 medium
            public static let amount = UIFont.systemFont(ofSize: 24, weight: .medium)
        }
        
        public struct Button {
            /// Button/button 16|24 medium
            public static let button = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
    }
    
}
