//
// CrystalButtonKit
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
import CUISeparator
import SwiftUI

/// A control that expands to display additional content and/or initiate an action.
///
/// ``CUIExpandableButton``'s main goal is to provide a convenient/floating
/// control that can expand to show additional content.
///
/// Example use cases include:
/// - A settings button that expands and displays a list of settings that can be
/// adjusted.
/// - A composer button that expands to show a composer.
/// - A notification indicator that expands to show recent activity.
/// - A friend icon that expands to show friends to message.
///
/// The secondary goal is to provide a control that provides a consistent style
/// accross an app. ``CUIExpandableButton`` is styled the same as ``CUIButton``, with the exception of extra stylization options provided when expanded. The ``CUIExpandableButton`` is  prestyled  uses the [`ultraThin`](https://developer.apple.com/documentation/swiftui/material/ultrathin) [`Material`](https://developer.apple.com/documentation/swiftui/material/)
/// as it's background [defined by Apple](https://tinyurl.com/hbzvf74y ).
///
/// Similar to ``CUIButton``, ``CUIExpandableButton`` provides a suite of customization options mentioned below.
///
/// ### Icon options
///
/// There are two options available for the buttons icon, a custom icon and a SF
/// Symbol icon.
///
/// The custom option allows any view to be used for the icon. The icon can be any
/// size, but care should be given to ensure the icon isn't clipped by the rounded
/// corners of the button in collapsed or expanded more. The minimum size for the
/// button and icon area in the header will be maintained at 44x44. Icons that have
/// non-equal height and width, will transform the button into a pill shape instead of
/// a circle.
///
/// ```
/// CUIExpandableButton(
///     expanded: $expanded
/// ) {
///     Image("icon")
///         .resizable()
///         .aspectRatio(contentMode: .fit)
///         .frame(width: 26, height: 26)
/// } content: {
///     Text("My content")
/// }
///
/// ```
///
/// Using a SF Symbol for the icon is straightforward, simply provide the name of
/// the symbol to display the icon. This  guarantees a consistent experience for
/// things like dynamic type and will stay within the bounds of the collapsed
/// button's background.
///
/// ```
/// CUIExpandableButton(
///     expanded: $expanded,
///     sfSymbolName: "gearshape.fill"
/// ) {
///     VStack {
///         Toggle("Setting 1", isOn: $toggleBool1)
///         Toggle("Setting 2", isOn: $toggleBool2)
///         Toggle("Setting 3", isOn: $toggleBool3)
///     }
///     .frame(width: 200)
///     .padding(8)
/// }
///
/// ```
///
/// ### Customizing the button
///
/// There are several modifiers for customizing the button. These include:
/// - Adding a title/subtitle.
/// - Adding a color to the background.
/// - Hiding various elements of the button like the icon, close button or the
/// entire header.
///
/// ```
///
/// CUIExpandableButton(
///     expanded: $expanded,
///     sfSymbolName: "flame.fill"
/// ) {
///     ExampleSettingsView()
/// }
/// .title("Settings")
/// .subtitle(expanded ? "Customize things!" : nil)
///
/// ```
/// Other modifiers only affect the display of the button in a specific state, such as ``hideHeader(_:)``, which only affect the button when expanded.
///
/// ``CUIExpandableButton`` also supports some of the standard modifiers.
/// This includes  ``foregroundColor(_:)`` and  `fontWeight(_:)`. When
/// using standard modifiers, it's important to use the modifiers specific to ``CUIExpandableButton`` first.
///
/// A full list of customization modifiers can be found in ``CUIStylizedControl`` & ``CUIStylizedWindow``.
///
/// *(`fontWeight(_:)` available beginning in iOS 16).*
///
/// ```
///
/// CUIExpandableButton(
///     expanded: $expanded,
///     sfSymbolName: "flame.fill"
/// ) {
///     ExampleContentView()
/// }
/// .title("Customize")
/// .subtitle("Lots of options")
/// .foregroundColor(.yellow)
/// .fontWeight(.bold)
///
/// ```
///
/// ### Additional action
///
/// The button provides access to an additional action when tapped. This can be
/// used to perform another action when expanding or collapsing the button's
/// content.
///
/// ```
/// CUIExpandableButton(
///     expanded: $expanded,
///     sfSymbolName: "bell.fill",
/// ) {
///     Text("Additional actions can be performed when expanding/collpasing")
///         .frame(width: 200)
///         .padding(8)
/// } action: {
///     print("Button was pressed")
/// }
///
/// ```
///
/// ### Minimum sizes
///
/// - When collapsed, the button maintains a minimum size of 44x44pt
/// - When expanded, if both the icon and close button are show, the
/// minimum width is 88
///
/// ### Additional support
///
/// It is worth noting that this button fully supports dynamic type size, dark mode,
/// and the right to left layout direction.
///
/// ### Other limitations
///
/// Below are the items that are not currently supported. Support maybe added in
/// the future.
/// - Other button shapes/styles
/// - Other background style.
/// - Other placement for header content when expanded..
public struct CUIExpandableButton<Icon, Content>: CUIStylizedWindow where Icon: View, Content: View {
    @Namespace private var animation

    // TODO: Consider moving this to a CUIView protocol. That way we have a place to define all common types
    public typealias Control = CUIExpandableButton
    public typealias Window = CUIExpandableButton

    // MARK: State

    // Needs to be a state so it will be preserved throughout the button's lifecycle
    @State
    var id = UUID()

    @State
    var iconSize = CGSize.zero

    // MARK: Binding

    @Binding var expanded: Bool

    // MARK: Constant Props

    let icon: Icon
    let content: Content
    let action: CUIAction?

    // MARK: Modifier Vars

    public var title: String?
    public var titleFont: Font?
    public var subtitle: String?
    public var subtitleFont: Font?

    public var hideBackground: Bool = false
    public var backgroundMaterial: Material? = .ultraThinMaterial

    var _backgroundColor: Color?
    public var backgroundColor: Color? {
        get {
            hideBackground
                ? nil
                : (
                    _backgroundColor ?? (
                        isRunningUnitTests()
                            ? .gray
                            : .clear
                    )
                )
        }
        set {
            _backgroundColor = newValue
        }
    }

    var _cornerRadius: CGFloat?
    public var cornerRadius: CGFloat? {
        get {
            if let radius = _cornerRadius {
                if !nonEmptyViewExpanded {
                    return min(iconMinLength / 2, radius)
                }

                return radius
            }

            return nonEmptyViewExpanded
                ? menuCornerRadius
                : iconMinLength / 2
        }
        set {
            _cornerRadius = newValue
        }
    }

    var _hideIcon: Bool = false // TODO: Has Shadow
    public var hideIcon: Bool {
        get {
            guard !hideHeader || !expanded || icon is EmptyView else {
                return true
            }

            return _hideIcon
        }
        set {
            _hideIcon = newValue
        }
    }

    // These are only displayed when expanded
    public var hideHeader = false

    var _hideSeparator = false // TODO: Has Shadow
    public var hideSeparator: Bool {
        get {
            guard !hideHeader else {
                return true
            }

            return _hideSeparator
        }
        set {
            _hideSeparator = newValue
        }
    }

    var _hideCloseButton = false // TODO: Has Shadow
    public var hideCloseButton: Bool {
        get {
            guard !hideHeader else {
                return true
            }

            return _hideCloseButton
        }
        set {
            _hideCloseButton = newValue
        }
    }

    // MARK: Scaled Metrics

    @ScaledMetric(relativeTo: .title)
    var minIconSize: CGFloat = .minInteractiveLength

    @ScaledMetric(relativeTo: .title)
    var menuCornerRadius: CGFloat = .cornerRadius

    // MARK: Calculated Vars

    var iconMinLength: CGFloat {
        min(iconSize.width, iconSize.height)
    }

    var headerHeight: CGFloat {
        if nonEmptyViewExpanded {
            if hideHeader {
                return 0
            }

            return minIconSize + (hideSeparator ? 0 : 1)
        }

        return iconMinLength
    }

    var showTitleSubtitleStack: Bool {
        showTitle || showSubtitle
    }

    var showTitle: Bool {
        guard !hideHeader || !expanded else {
            return false
        }

        guard let title = title, !title.isEmpty else {
            return false
        }

        return true
    }

    var showSubtitle: Bool {
        guard !hideHeader || !expanded else {
            return false
        }

        guard let subtitle = subtitle, !subtitle.isEmpty else {
            return false
        }

        return true
    }

    private var nonEmptyViewExpanded: Bool {
        !(content is EmptyView) && expanded
    }

    /// Creates an expandable button, using a custom icon.
    /// - Parameters:
    ///   - expanded: Bool binding that tracks the button's expanded state.
    ///   - icon: View that is displayed as an icon.
    ///   - content: The content that will be displayed when the button is expanded.
    ///   - action: Action that will be performed when the button is
    ///   collapsed or expanded using the built in controls.
    public init(
        expanded: Binding<Bool>,
        @ViewBuilder icon: () -> Icon,
        @ViewBuilder content: () -> Content,
        action: CUIAction? = nil
    ) {
        _expanded = expanded
        self.icon = icon()
        self.content = content()
        self.action = action
    }

    var iconView: some View {
        icon
            .frame(minWidth: minIconSize, minHeight: minIconSize)
            .fixedSize()
            .background(DEBUG_LAYOUT ? .green.tint : .clear)
            .matchedGeometryEffect(id: "icon", in: animation)
    }

    var titleAndSubtitle: some View {
        VStack(alignment: .leading) {
            if let title = title {
                Text(title)
                    .font(titleFont ?? .headline)
                    .background(DEBUG_LAYOUT ? .red.tint : .clear)
                    .matchedGeometryEffect(id: "title", in: animation)
            }
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(subtitleFont ?? .subheadline)
                    .background(DEBUG_LAYOUT ? .orange.tint : .clear)
                    .matchedGeometryEffect(id: "subtitle", in: animation)
            }
        }
        .padding(
            .leading, hideIcon && expanded ? .standardSpacing : 0
        )
        .padding(
            .trailing, hideCloseButton && expanded ? .standardSpacing : 0
        )
        .padding(
            .bottom,
            hideIcon && hideCloseButton
                && expanded
                ? .standardSpacing : 0
        )
        .fixedSize()
    }

    var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                // This animation looks delayed in previews, but works fine in the simulator
                if expanded {
                    if !hideIcon {
                        CUISizeReader(
                            size: $iconSize,
                            id: id
                        ) {
                            iconView
                        }
                    }
                } else {
                    CUISizeReader(
                        size: $iconSize,
                        id: id
                    ) {
                        Button {
                            expanded.toggle()
                            action?()
                        } label: {
                            HStack(spacing: 0) {
                                if !hideIcon {
                                    iconView
                                }

                                /*
                                 * This is to make sure the button is still clickable
                                 * when the icon is hidden and neither the title or
                                 * the subtitle is being shown.
                                 */
                                if hideIcon
                                    && title == nil
                                    && subtitle == nil
                                {
                                    // Tests on the github process transparency differently
                                    Color.white.opacity(isRunningUnitTests() ? 1.0 : 0.01)
                                }

                                if showTitleSubtitleStack {
                                    titleAndSubtitle
                                        .padding(
                                            hideIcon
                                                ? .horizontal
                                                : .trailing
                                        )
                                        .background(DEBUG_LAYOUT ? .purple.tint : .clear)
                                }
                            }
                            .frame(minWidth: minIconSize, minHeight: minIconSize)
                        }.buttonStyle(.plain)
                    }
                }

                if nonEmptyViewExpanded {
                    if showTitleSubtitleStack {
                        titleAndSubtitle
                            .background(DEBUG_LAYOUT ? .purple.tint : .clear)
                    }

                    Spacer(minLength: 0)

                    if !hideCloseButton {
                        CloseButton {
                            self.expanded.toggle()
                            self.action?()
                        }
                        .frame(
                            height:
                            hideIcon
                                ? nil :
                                iconSize.height,
                            alignment: .top
                        )
                        .transition(.opacity)
                    }
                }
            }

            if nonEmptyViewExpanded && !hideSeparator {
                CUISeparator()
            }
        }
        .frame(
            minHeight: headerHeight
        )
        .frame(minWidth: nonEmptyViewExpanded && !hideHeader ? minIconSize * 2 : nil)
    }

    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
            VStack(spacing: 0) {
                header
                    .frame(maxWidth: .infinity) // This may not be needed

                if nonEmptyViewExpanded {
                    content
                        .transition(.opacity)
                }
            }

            if DEBUG_LAYOUT {
                Text(String(format: "%.1f", iconSize.width))
                    .foregroundColor(.green)
                    .background(.black.tint)
            }
        }
        // FIXME: Material doesn't render in snapshot tests for some reason
        .optionalBackground(backgroundColor)
        .optionalBackground(
            hideBackground
                ? nil as Material?
                : backgroundMaterial as Material?
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius ?? 0))
        .animation(.spring(), value: expanded)
        .fixedSize()
    }
}

// MARK: - SFSymbol Initializers

// TODO: Add a convienience initializer that doesn't require the icon at all.
public extension CUIExpandableButton where Icon == CUISFSymbolIcon {
    /// Creates an expandable button, using a SF Symbol as the icon.
    /// - Parameters:
    ///   - expanded: Bool binding that tracks the button's expanded state.
    ///   - sfSymbolName: The name of the SF Symbol to use as the icon.
    ///   - content: The content that will be displayed when the button is expanded.
    ///   - action: Action that will be performed when the button is
    ///   collapsed or expanded using the built in controls.
    init(
        expanded: Binding<Bool>,
        sfSymbolName: String,
        @ViewBuilder content: () -> Content,
        action: CUIAction? = nil
    ) {
        self.init(
            expanded: expanded,
            icon: { CUISFSymbolIcon(iconName: sfSymbolName) },
            content: content,
            action: action
        )
    }
}

// MARK: - DEBUG_LAYOUT

internal var DEBUG_LAYOUT = false

private extension Color {
    var tint: Color {
        opacity(0.5)
    }
}

// From: https://stackoverflow.com/a/33194122/898984
private func isRunningUnitTests() -> Bool {
    if let _ = NSClassFromString("XCTest") {
        return true
    }

    return false
}
