//
//  Label.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

public final class Label: UILabel {
    override public var text: String? {
        get {
            self.attributedText?.string
        }
        set {
            self.attributedText = newValue.map { NSAttributedString(string: $0, attributes: self.appearance?.attributes ?? [:]) }
        }
    }

    private var appearance: Appearance?

    public func apply(_ appearance: Appearance) {
        self.appearance = appearance
        self.backgroundColor = appearance.backgroundColor
        self.textAlignment = appearance.alignment
        self.numberOfLines = appearance.numberOfLines
        if let scaleFactor = appearance.minimumScaleFactor {
            self.minimumScaleFactor = scaleFactor
            self.adjustsFontSizeToFitWidth = true
        } else {
            self.adjustsFontSizeToFitWidth = false
        }
        if let existingText = self.text {
            self.text = existingText
        }
    }
}

public extension Label {
    struct Appearance {
        public var backgroundColor: UIColor
        public var alignment: NSTextAlignment
        public var numberOfLines: Int
        public var attributes: [NSAttributedString.Key: Any]
        public var minimumScaleFactor: CGFloat?

        public init(font: UIFont = .systemFont(ofSize: 14),
                    backgroundColor: UIColor = .clear,
                    textColor: UIColor = .black,
                    alignment: NSTextAlignment = .left,
                    numberOfLines: Int = 0,
                    attributes: [NSAttributedString.Key: Any] = [:],
                    minimumScaleFactor: CGFloat? = nil) {
            self.backgroundColor = backgroundColor
            self.alignment = alignment
            self.numberOfLines = numberOfLines
            var attributes = attributes
            attributes[.font] = font
            attributes[.foregroundColor] = textColor
            self.attributes = attributes
            self.minimumScaleFactor = minimumScaleFactor
        }

    }
}

