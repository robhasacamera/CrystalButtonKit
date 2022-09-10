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
final class CUIButtonTests: XCTestCase {
    override func setUp() async throws {
        try await super.setUp()

        // isRecording = true
    }

    override func tearDown() async throws {
        // If we overwrite a snapshot, we want it to be just the snapshot we're intentionally changing.
        isRecording = false

        try await super.tearDown()
    }

    // MARK: - SF Symbol Tests

    func testButtonWithSFSymbol() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton(sfSymbolName: sfSymbolName) {
                /* action */
            }
            .prepForTest
        }
    }

    func testButtonWithSFSymbolAndTitle() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton(sfSymbolName: sfSymbolName) {
                /* action */
            }
            .title(mockTitle)
            .prepForTest
        }
    }

    func testButtonWithSFSymbolAndSubtitle() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton(sfSymbolName: sfSymbolName) {
                /* action */
            }
            .subtitle(mockSubtitle)
            .prepForTest
        }
    }

    func testButtonWithSFSymbolTitleAndSubtitle() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton(sfSymbolName: sfSymbolName) {
                /* action */
            }
            .title(mockTitle)
            .subtitle(mockSubtitle)
            .prepForTest
        }
    }

    func testButtonWithTitleOnly() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton(title: mockTitle) {
                /* action */
            }
            .prepForTest
        }
    }

    func testButtonWithSFSymbolAndForegroundColor() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton(sfSymbolName: sfSymbolName) {
                /* action */
            }
            .foregroundColor(.yellow)
        }
    }

    func testButtonWithSFSymbolAndBackgroundColor() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton(sfSymbolName: sfSymbolName) {
                /* action */
            }
            .backgroundColor(.cyan)
            .prepForTest
        }
    }

    func testButtonWithSFSymbolAndHiddenBackground() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton(sfSymbolName: sfSymbolName) {
                /* action */
            }
            .hideBackground()
            .prepForTest
        }
    }

    func testButtonWithSFSymbolAndCornerRadius() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton(sfSymbolName: sfSymbolName) {
                /* action */
            }
            .buttonCornerRadius(5.0)
            .prepForTest
        }
    }

    func testButtonWithNoIcon() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton(sfSymbolName: sfSymbolName) {
                /* action */
            }
            .hideIcon()
            .prepForTest
        }
    }

    func testButtonWithCustomIcon() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton{
                mockCustomIcon
            } action: {
                /* action */
            }
            .prepForTest
        }
    }

    func testButtonWithCustomIconWide() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton{
                mockCustomSizeIcon(width: .icon * 2, height: .icon)
            } action: {
                /* action */
            }
            .prepForTest
        }
    }

    func testButtonWithCustomIconTall() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton{
                mockCustomSizeIcon(width: .icon, height: .icon * 2)
            } action: {
                /* action */
            }
            .prepForTest
        }
    }

    func testButtonWithCustomIconLarge() throws {
        // isRecording = true
        captureSampledDynamicSizeSnapshots {
            CUIButton{
                mockCustomSizeIcon(width: .icon * 2, height: .icon * 2)
            } action: {
                /* action */
            }
            .prepForTest
        }
    }
}

extension CUIButton {
    var prepForTest: some View {
        // FIXME: This must be done, otherwise the defaults for snapshot tests end up being a mix of black and white.
        self.foregroundColor(.black)
    }
}
#endif
