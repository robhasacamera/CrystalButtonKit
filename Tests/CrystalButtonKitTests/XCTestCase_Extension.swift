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

@testable import CrystalButtonKit
import SnapshotTesting
import SwiftUI
import XCTest

#if os(iOS)
// TODO: Document
// TODO: Move into a CrystalTestKit
public extension XCTestCase {
    // TODO: Document
    // TODO: Add a version where you can specific the sizes to snapshot
    func assertDynamicSizeSnapshots<Content>(
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line,
        sizes: [ContentSizeCategory] = ContentSizeCategory.allCases,
        @ViewBuilder content: () -> Content
    ) where Content: View {
        for size in sizes {
            assertSnapshot(
                matching: content().environment(\.sizeCategory, size),
                as: .image,
                file: file,
                testName: "\(testName).\(size)",
                line: line
            )
        }
    }

    // TODO: Document
    func assertSampledDynamicSizeSnapshots<Content>(
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line,
        @ViewBuilder content: () -> Content
    ) where Content: View {
        assertDynamicSizeSnapshots(
            file: file,
            testName: testName,
            line: line,
            sizes: [
                .extraSmall,
                .medium,
                .extraExtraExtraLarge
            ],
            content: content
        )
    }
}

internal extension XCTestCase {
    var mockTitle: String { "Marty" }
    var mockSubtitle: String { "McFly" }
    var sfSymbolName: String { "gearshape.fill" }

    var mockCustomIcon: some View {
        Text("M")
            .font(.title)
    }

    var mockContent: some View {
        Text("What's a gigwatt?")
            .padding(.standardSpacing)
    }

    func mockCustomSizeIcon(width: CGFloat, height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 10.0)
            .fill(.black) // this is important, otherwise the layout behaves oddly
            .frame(width: width, height: height)
            .padding(.standardSpacing)
    }
}
#endif
