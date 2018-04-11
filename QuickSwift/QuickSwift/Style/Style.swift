//
//  Style.swift
//  QuickSwift
//
//  Created by tcui on 16/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

public struct Style<Element> {

    let element: Element

    init(element: Element) {
        self.element = element
    }

    @discardableResult
    public func with(_ styles: [StyleItem<Element>]) -> Style {
        styles.forEach { $0.apply(on: element) }
        return self
    }

    @discardableResult
    public func ui(_ custom: (Element) -> Void) -> Style {
        custom(element)
        return self
    }
}

extension Style where Element: Stylable {
    @discardableResult
    public func same(with another: Element.Element ) -> Style {
        self.element.copyStyle(another)
        return self
    }
}

extension Style {
    @discardableResult
    public func with<T: StyleFactory>(_ styles: T...) -> Style where T.Element == Element {
        styles.forEach { $0.styleItem.apply(on: element) }
        return self
    }

    @discardableResult
    public func with<T: StyleFactory>(_ type: T.Type, _ styles: T...) -> Style where T.Element == Element {
        styles.forEach { $0.styleItem.apply(on: element) }
        return self
    }
}

public struct StyleItem<Element> {
    let operation: (Element) -> Void

    public init(operation: @escaping (Element) -> Void) {
        self.operation = operation
    }

    public func apply(on element: Element) {
        operation(element)
    }
}

public protocol StyleFactory {
    associatedtype Element
    var styleItem: StyleItem<Element> { get }
}
