//
//  Style.swift
//  QuickSwift
//
//  Created by tcui on 16/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

public struct UIStyle<Element> {

    let element: Element

    init(element: Element) {
        self.element = element
    }

    @discardableResult
    public func with(_ styles: [StyleItem<Element>]) -> UIStyle {
        styles.forEach { $0.apply(on: element) }
        return self
    }

    @discardableResult
    public func ui(_ custom: (Element) -> Void) -> UIStyle {
        custom(element)
        return self
    }
}

extension UIStyle where Element: UIStylable {
    @discardableResult
    public func same(with another: Element.Element ) -> UIStyle {
        self.element.copyStyle(another)
        return self
    }
}

extension UIStyle {
    @discardableResult
    public func with<T: StyleFactory>(_ styles: T...) -> UIStyle where T.Element == Element {
        styles.forEach { $0.styleItem.apply(on: element) }
        return self
    }

    @discardableResult
    public func with<T: StyleFactory>(_ type: T.Type, _ styles: T...) -> UIStyle where T.Element == Element {
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
