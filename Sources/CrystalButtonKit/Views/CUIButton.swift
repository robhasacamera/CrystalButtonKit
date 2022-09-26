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

import CrystalViewUtilities
import CUIPreviewKit
import SwiftUI

/// A control that executes an action when pressed.
///
/// ``CUIButton``'s main goal is to provide a consistently stylized control that executes an action.
///
/// The control can be highly customized using the modifiers found in ``CUIStylizedControl``. There is a deeper discussion of these options in ``CUIExpandableButton``,  though the expanded options do not  apply to ``CUIButton``.
///
/// ### Icon options
///
/// There are two options available for the buttons icon, a custom icon and a SF
/// Symbol icon.
///
/// The custom option allows any view to be used for the icon. The icon can be any
/// size, but care should be given to ensure the icon isn't clipped by the rounded
/// corners of the button in collapsed or expanded more. The minimum size for the
/// button will be maintained at 44x44. Icons that have non-equal height and width,
/// will transform the button into a pill shape instead of a circle.
///
/// ```
/// CUIButton {
///     MyCustomIconView()
/// } action: {
///     print("Button was pressed")
/// }
/// ```
///
/// Using a SF Symbol for the icon is straightforward, simply provide the name of
/// the symbol to display the icon. This  guarantees a consistent experience for
/// things like dynamic type and will stay within the bounds of the collapsed
/// button's background.
///
/// ```
/// CUIButton(sfSymbol: "bell.fill") {
///     print("Open Notification")
/// }
/// ```
///
/// ### Other limitations
///
/// Below are the items that are not currently supported. Support maybe added in
/// the future.
/// - Other button shapes/styles
/// - Other background style.
/// - Buttons smaller then 44x44
public struct CUIButton<Icon>: _CUIStylizedControl where Icon: View {
    public typealias Control = CUIButton<Icon>

    public var control: CUIExpandableButton<Icon, EmptyView>

    /// Creates a stylized button that initiates an action.
    /// - Parameters:
    ///   - icon: View that is displayed as an icon.
    ///   - action: Action that will be performed when tapping the button.
    public init(
        @ViewBuilder icon: () -> Icon,
        action: @escaping CUIAction
    ) {
        control = CUIExpandableButton(
            expanded: .constant(false),
            icon: icon,
            content: {
                EmptyView()
            },
            action: action
        )
    }

    public var body: some View {
        control
    }
}

public extension CUIButton where Icon == CUISFSymbolIcon {
    /// Creates a stylized button that iniates an action.
    /// - Parameters:
    ///   - sfSymbolName: The name of the SF Symbol to use as the icon.
    ///   - action: Action that will be performed when tapping the button.
    init(
        sfSymbolName: String,
        action: @escaping CUIAction
    ) {
        control = CUIExpandableButton(expanded: .constant(false), sfSymbolName: sfSymbolName, content: {
            EmptyView()
        }, action: action)
    }

    var body: some View {
        control
    }
}

public extension CUIButton where Icon == EmptyView {
    /// Creates a stylized button that iniates an action.
    ///
    /// This controls creates
    /// - Parameters:
    ///   - title: The title to display for the button.
    ///   - action: Action that will be performed when tapping the button.
    init(
        title: String,
        action: @escaping CUIAction
    ) {
        control = CUIExpandableButton(
            expanded: .constant(false),
            icon: {
                EmptyView()
            }, content: {
                EmptyView()
            }, action: action
        )
        .title(title)
        .hideIcon()
    }

    var body: some View {
        control
    }
}

struct CUIButton_Previews: PreviewProvider {
    static var previews: some View {
        CUICenteredPreview(title: "CUIButton") {
            VStack {
                CUICaptionedView("Custom Icon Init") {
                    CUIButton {
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(
                                width: 10,
                                height: 10
                            )
                    } action: {
                        print("button pressed")
                    }
                }

                CUICaptionedView("SF Symbol Init") {
                    CUIButton(sfSymbolName: "doc.fill") {
                        print("button pressed")
                    }
                }

                CUICaptionedView("Title Init") {
                    CUIButton(title: "doc.fill") {
                        print("button pressed")
                    }
                }

                CUICaptionedView(".title(...)") {
                    CUIButton(sfSymbolName: "doc.fill") {
                        print("button pressed")
                    }
                    .title("Title")
                }
            }
        }
    }
}
