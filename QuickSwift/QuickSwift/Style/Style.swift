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

    @discardableResult
    public func make(_ make: (CombinedStyleItem<Element>) -> Void) -> Style {
        let combinedItem = CombinedStyleItem<Element>()
        make(combinedItem)
        with(combinedItem.styles)
        return self
    }
}

extension Style where Element : Stylable {
    @discardableResult
    public func same(with another: Element.Element ) -> Style {
        self.element.copyStyle(another)
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

final public class CombinedStyleItem<Element> {
    var styles = [StyleItem<Element>]()

    @discardableResult
    func and(_ style: StyleItem<Element> ) -> CombinedStyleItem {
        styles.append(style)
        return self
    }

    @discardableResult
    func and<T: StyleFactory>(_ style: T ) -> CombinedStyleItem where T.Element == Element {
        styles.append(style.styleItem)
        return self
    }
}

public protocol StyleFactory {
    associatedtype Element
    var styleItem: StyleItem<Element> { get }
}
