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

import CUIExpandableButton
import SwiftUI

struct ContentView: View {
    @State
    var expanded1: Bool = false
    @State
    var expanded2: Bool = false
    @State
    var expanded3: Bool = false

    @State
    var expanded4: Bool = true

    @State
    var textFieldString: String = "Compose here"
    @State
    var toggleBool1: Bool = true
    @State
    var toggleBool2: Bool = true
    @State
    var toggleBool3: Bool = true

    @State
    var showAlert = false

    @State
    var sfSymbolName = "gearshape.fill"
    @State
    var hideIcon = false

    @State
    var title = "Title"
    @State
    var titleFont: Font? = nil

    @State
    var subtitle = "Subtitle"
    @State
    var subtitleFont: Font? = nil

    @State
    var content = "Customizing this using the controls below."

    @State
    var hideCloseButton = false
    @State
    var hideSeparator = false
    @State
    var hideHeader = false

    @State
    var hideBackground: Bool = false

    @State
    var backgroundColor: Color = .clear

    @State
    var foregroundColor = Color(uiColor: .label)

    var body: some View {
        VStack(spacing: 8.0) {
            HStack(alignment: .top) {
                CUIExpandableButton(
                    expanded: $expanded1,
                    sfSymbolName: "pencil"
                ) {
                    TextEditor(text: $textFieldString)
                        .frame(width: 200, height: 100)
                } action: {
                    expanded2 = false
                    expanded3 = false
                    expanded4 = false
                }

                CUIExpandableButton(
                    expanded: $expanded2,
                    sfSymbolName: "gearshape.fill"
                ) {
                    VStack {
                        Toggle("Setting 1", isOn: $toggleBool1)
                        Toggle("Setting 2", isOn: $toggleBool2)
                        Toggle("Setting 3", isOn: $toggleBool3)
                    }
                    .frame(width: 200)
                    .padding(8)

                } action: {
                    expanded1 = false
                    expanded3 = false
                    expanded4 = false
                }

                CUIExpandableButton(
                    expanded: $expanded3
                ) {
                    Image("Background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 26, height: 26)
                } content: {
                    Image("Background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(8)
                } action: {
                    expanded1 = false
                    expanded2 = false
                    expanded4 = false
                }
            }

            Spacer()

            CUIExpandableButton(
                expanded: $expanded4,
                sfSymbolName: sfSymbolName
            ) {
                Text(content)
                    .frame(width: 200)
                    .padding(8)
                    .foregroundColor(nil)
            } action: {
                expanded1 = false
                expanded2 = false
                expanded3 = false
            }
            .hideIcon(hideIcon)
            .title(
                title.count > 0 ? title : nil,
                font: titleFont
            )
            .subtitle(
                subtitle.count > 0 ? subtitle : nil,
                font: subtitleFont
            )
            .hideCloseButton(hideCloseButton)
            .hideSeparator(hideSeparator)
            .hideHeader(hideHeader)
            .hideBackground(hideBackground)
            .backgroundColor(backgroundColor)
            .foregroundColor(foregroundColor)

            Spacer()

            ScrollView {
                VStack {
                    TitledGroup("Settings") {
                        Toggle("Expanded", isOn: $expanded4)
                    }

                    TitledGroup("Title") {
                        VStack {
                            TextField("Title", text: $title)
                                .padding(4)
                                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.white.opacity(0.5)))

                            FontPicker(label: "Title Font", font: $titleFont)
                        }
                    }

                    TitledGroup("Subtitle") {
                        VStack {
                            TextField("Subtitle", text: $subtitle)
                                .padding(4)
                                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.white.opacity(0.5)))

                            FontPicker(label: "Subtitle Font", font: $subtitleFont)
                        }
                    }

                    TitledGroup("Content") {
                        TextField("Content", text: $content)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.white.opacity(0.5)))
                    }

                    TitledGroup("Icon") {
                        HStack {
                            Text("Icon Symbol")

                            Spacer()

                            Picker(
                                "Icon",
                                selection: $sfSymbolName
                            ) {
                                Group {
                                    Text("bag.fill").tag("bag.fill")
                                    Text("bell.fill").tag("bell.fill")
                                    Text("cart.fill").tag("cart.fill")
                                    Text("bookmark.fill").tag("bookmark.fill")
                                    Text("doc.fill").tag("doc.fill")
                                    Text("envelope.fill").tag("envelope.fill")
                                    Text("exclamationmark.triangle.fill").tag("exclamationmark.triangle.fill")
                                    Text("gearshape.fill").tag("gearshape.fill")
                                }

                                Group {
                                    Text("list.triangle").tag("list.triangle")
                                    Text("mappin").tag("mappin")
                                    Text("note.text").tag("note.text")
                                    Text("paperclip").tag("paperclip")
                                    Text("paintbrush.pointed.fill").tag("paintbrush.pointed.fill")
                                    Text("person.fill").tag("person.fill")
                                    Text("printer.fill").tag("printer.fill")
                                    Text("square.and.arrow.up").tag("square.and.arrow.up")
                                }

                                Group {
                                    Text("star.fill").tag("star.fill")
                                    Text("sun.max.fill").tag("sun.max.fill")
                                    Text("terminal.fill").tag("terminal.fill")
                                    Text("text.bubble.fill").tag("text.bubble.fill")
                                    Text("waveform.path.ecg").tag("waveform.path.ecg")
                                }
                            }
                        }

                        Toggle("Hide Icon", isOn: $hideIcon)
                    }

                    TitledGroup("Header Only Options") {
                        VStack {
                            Toggle("Hide Header", isOn: $hideHeader)

                            Toggle("Hide Close Button", isOn: $hideCloseButton)

                            Toggle("Hide Separator", isOn: $hideSeparator)
                        }
                    }

                    TitledGroup("Show/Hide Background") {
                        Toggle("Hide Background", isOn: $hideBackground)
                    }

                    TitledGroup("Background Color") {
                        ColorPicker("Background Color", selection: $backgroundColor)
                    }

                    TitledGroup("Foreground Color") {
                        ColorPicker("Foreground Color", selection: $foregroundColor)
                    }
                }
                .padding()
            }
            .background(.ultraThinMaterial)
            .frame(height: 348)
        }
        .background(alignment: .center) {
            Image("Background")
                .centered()
                .edgesIgnoringSafeArea(.all)
        }
        .animation(.easeInOut, value: expanded1)
        .animation(.easeInOut, value: expanded2)
        .animation(.easeInOut, value: expanded3)
        .animation(.easeInOut, value: expanded4)
        .animation(.easeInOut, value: sfSymbolName)
        .animation(.easeInOut, value: hideIcon)
        .animation(.easeInOut, value: title)
        .animation(.easeInOut, value: titleFont)
        .animation(.easeInOut, value: subtitle)
        .animation(.easeInOut, value: subtitleFont)
        .animation(.easeInOut, value: content)
        .animation(.easeInOut, value: hideCloseButton)
        .animation(.easeInOut, value: hideSeparator)
        .animation(.easeInOut, value: hideHeader)
        .animation(.easeInOut, value: backgroundColor)
        .animation(.easeInOut, value: foregroundColor)
    }
}

extension Image {
    func centered() -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

// FIXME: Have to comment these out these previews when I have just the package open, otherwise it breaks the package previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
