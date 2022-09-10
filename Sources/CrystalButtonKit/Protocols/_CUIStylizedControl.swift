//
// CrystalUI
//
// MIT License
//
// Copyright (c) 2022 Robert Cole
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import SwiftUI

protocol _CUIStylizedControl: CUIStylizedControl {
    associatedtype _Control: CUIStylizedControl

    var control: _Control { get set }
}

extension _CUIStylizedControl {
    public var title: String? {
        get {
            control.title
        } set {
            var newButton = control

            newButton.title = newValue

            control = newButton
        }
    }

    public var titleFont: Font? {
        get {
            control.titleFont
        }
        set {
            var newButton = control

            newButton.titleFont = newValue

            control = newButton
        }
    }

    public var subtitle: String? {
        get {
            control.subtitle
        } set {
            var newButton = control

            newButton.subtitle = newValue

            control = newButton
        }
    }

    public var subtitleFont: Font? {
        get {
            control.subtitleFont
        } set {
            var newButton = control

            newButton.subtitleFont = newValue

            control = newButton
        }
    }

    public var hideBackground: Bool {
        get {
            control.hideBackground
        } set {
            var newButton = control

            newButton.hideBackground = newValue

            control = newButton
        }
    }

    public var backgroundMaterial: Material? {
        get {
            control.backgroundMaterial
        } set {
            var newButton = control

            newButton.backgroundMaterial = newValue

            control = newButton
        }
    }

    public var backgroundColor: Color? {
        get {
            control.backgroundColor
        } set {
            var newButton = control

            newButton.backgroundColor = newValue

            control = newButton
        }
    }

    public var cornerRadius: CGFloat? {
        get {
            control.cornerRadius
        } set {
            var newButton = control

            newButton.cornerRadius = newValue

            control = newButton
        }
    }

    public var hideIcon: Bool {
        get {
            control.hideIcon
        } set {
            var newButton = control

            newButton.hideIcon = newValue

            control = newButton
        }
    }
}
