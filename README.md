# CrystalButtonKit

A SwiftUI button that expands to reveal more content.

![CUIExpandableButton Demo](Assets/demo.gif)

[![package build workflow](https://github.com/robhasacamera/CrystalButtonKit/actions/workflows/package.yml/badge.svg)](https://github.com/robhasacamera/CUIExpandableButton/actions/workflows/package.yml)
[![sample app build workflow](https://github.com/robhasacamera/CrystalButtonKit/actions/workflows/sample_app.yml/badge.svg)](https://github.com/robhasacamera/CUIExpandableButton/actions/workflows/sample_app.yml)
[![package build workflow](https://github.com/robhasacamera/CrystalButtonKit/actions/workflows/test.yml/badge.svg)](https://github.com/robhasacamera/CUIExpandableButton/actions/workflows/test.yml)

*CrystalButtonKit is part of the CrystalUI framework (under developement). This framework is working to bring a suite of UI components that utilizes [SwiftUI Material](https://developer.apple.com/documentation/swiftui/material) for it's background element.* 

## Usage

To create a simple CUIExpandableButton, you can use an SF Symbol for your icon.

```swift
import CUIExpandableButton
import SwiftUI

struct ContentView: View {
    @State
    var expanded: Bool = false
    
    var body: some View {
        CUIExpandableButton(
            expanded: $expanded,
            sfSymbolName: "gearshape.fill"
        ) {
            Text("My content")
        }
    }
}
```

## Customization

### Icon

If you'd like more control over the look of the button, you can provide a custom icon for the button instead.

```swift
CUIExpandableButton(
    expanded: $expanded
) {
    Image("icon")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 26, height: 26)
} content: {
    Text("My content")
}
```

Additionally, you can hide the icon altogether. When hiding the icon, it's a good idea to show a title to prevent an empty button in collapsed state. Though it is possible for the button to empty.

```swift
CUIExpandableButton(
    expanded: $expanded,
    sfSymbolName: "bell.fill"
) {
    Text("Button with hidden icon")
        .frame(width: 200)
        .padding(8)
}
.hideIcon(true)
.title("More Info")

CUIExpandableButton(
    expanded: $expanded,
    sfSymbolName: "bell.fill"
) {
    Text("Button that hides icon when expanded.")
        .frame(width: 200)
        .padding(8)
}
.hideIcon(expanded)
.title("New Message")
```

### Actions

You can add an action that's triggered when the button is expanded or collapsed using the built in controls.

```swift
CUIExpandableButton(
    expanded: $expanded,
    sfSymbolName: "bell.fill"
) {
    Text("Additional actions can be performed when expanding/collpasing")
        .frame(width: 200)
        .padding(8)
} action: {
    print("Button was pressed")
}
```

### Title & Subtitle

The button provides options to show a title and subtitle. 

```Swift
CUIExpandableButton(
    expanded: $expanded,
    sfSymbolName: "envelope.fill"
) {
    Text("My content")
        .frame(width: 200)
        .padding(8)
}
.title("Inbox")
.subtitle("5 unread messages")
```

These can also be enabled only for specific states of the button.

```swift
CUIExpandableButton(
    expanded: $expanded4,
    sfSymbolName: "mappin"
) {
    Text("My content")
        .frame(width: 200)
        .padding(8)
}
.title(expanded ? "Visit SF!" : nil)
.subtitle(expanded ? "Top attractions" : nil)
```

### Header Only Options

There are additional customization options for customizing the header when the button is expanded. 

```swift
CUIExpandableButton(
    expanded: $expanded,
    sfSymbolName: "exclamationmark.triangle.fill"
) {
    Text("Take up the full space when expanded.")
        .frame(width: 200)
        .padding(8)
)
.hideHeader()

CUIExpandableButton(
    expanded: $expanded,
    sfSymbolName: "exclamationmark.triangle.fill"
) {
    Text("Hide the separator.")
        .frame(width: 200)
        .padding(8)
)
.hideSeperator()
.title(expanded ? "Alert!" : nil)

CUIExpandableButton(
    expanded: $expanded,
    sfSymbolName: "exclamationmark.triangle.fill"
) {
    Text("Hide the close button to control how it's dismissed yourself.")
        .frame(width: 200)
        .padding(8)
)
.hideCloseButton()
.title(expanded ? "Alert!" : nil)
.subtitle("You need to take action!")
```

### Custom Color

You can opt to add a color background instead of the default material background. However, the material is also rendered beneath. This allows a transparent background to be added that results in a tinted effect.

```swift
CUIExpandableButton(
    expanded: $expanded,
    sfSymbolName: "doc.fill"
) {
    Text("Tinting the background can help the button fit into your UX design.")
        .frame(width: 200)
        .padding(8)
)
.backgroundColor(.blue.opacity(0.15))
```

The standard foreground color modifier can be applied as well to color the elements of the button.

```swift
CUIExpandableButton(
    expanded: $expanded,
    sfSymbolName: "doc.fill"
) {
    Text("You can use other standard modifiers too!")
        .frame(width: 200)
        .padding(8)
        .foregroundColor(nil)
)
.standardLayout(title: "Color", subtitle: "Customization")
.foregroundColor(.yellow)
```

### Other Feature

It is worth noting that CrystalButtonKit fully supports dynamic type variants, dark mode, and the right to left layout direction.

## Installation

CrystalButtonKit supports Swift Package Manager. To use it the following to your `Package.swift` file:

```
dependencies: [
    .package(name: "CUIExpandableButton", url: "https://github.com/robhasacamera/CrystalButtonKit.git", from: "0.15.0")
],
```

## Sample Project

A sample project, `ButtonDemo.xcodeproj`, can be found in the `SampleApp` folder.

## Future Plans

1. Support for CocoaPods and Carthage are being considered for future releases.
2. More test coverage and test types.
3. Customizations specific for Mac and Catalyst.
4. Extracting some other useful views into their own packages.
5. Add tap expansion and allow visually smaller button sizes

## TODO List

1. ~~Add Snapshot tests for CUIButton~~
2. Update Sample app for new package name
3. Add CUIButtons to sample app
4. Create documention file for overall package
5. Move utility views, classes and extensions to their own packages
  - SFSymbol into CrystalSFKit
  - ChildSizeReader, CloseButton, CUIView, & View_Extension in CrystalViewKit
  - Move CGFloat_Extension into CrystalViewKit or CrystralConstKit 
6. Get guthub workflows working
7. Update CUIExpandableButton to point to this repo
8. Update repo permissions to require pull requests for main branch.

