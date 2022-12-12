//
//  ActionHandler.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation

public typealias ActionHandler = CustomActionHandler<() -> Void>
public typealias BooleanBlock = (Bool) -> Void

/// Allows to store callback and support Equatable
public final class CustomActionHandler<Block> {
    private let uid: UUID
    public let block: Block

    public init(_ block: Block) {
        self.uid = .init()
        self.block = block
    }

    public convenience init?(_ block: Block?) {
        guard let block = block else { return  nil }
        self.init(block)
    }
}

extension CustomActionHandler: Equatable, Hashable {
    public static func == (lhs: CustomActionHandler, rhs: CustomActionHandler) -> Bool {
        lhs.uid == rhs.uid
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.uid)
    }
}

extension CustomActionHandler where Block == () -> Void {
    public func callAsFunction() {
        self.block()
    }
}
