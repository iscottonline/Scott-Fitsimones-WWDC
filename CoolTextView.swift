//
//  CoolTextView.swift
//  Scott Fitsimones
//
//  Created by Scott Fitsimones on 4/17/15.
//  Copyright (c) 2015 Bolt Visual. All rights reserved.
//

import Cocoa

class CoolTextView: NSTextView {

    override init(frame frameRect: NSRect, textContainer aTextContainer: NSTextContainer!) {
        super.init(frame: frameRect, textContainer: aTextContainer)

        self.font = NSFont(name: "HelveticaNeue-Light", size: 38)
        self.editable = false
        self.alignment = NSTextAlignment.CenterTextAlignment
        self.backgroundColor = NSColor.clearColor()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(aPoint: NSPoint) -> NSView? {
        return nil
    }
    
    override func mouseMoved(theEvent: NSEvent) {
        NSCursor.arrowCursor().self
    }
    override func resetCursorRects() {
        self.addCursorRect(self.bounds, cursor: NSCursor.arrowCursor())
    }
    
}
