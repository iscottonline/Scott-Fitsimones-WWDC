//
//  ScottWindowController.swift
//  Scott Fitsimones
//
//  Created by Scott Fitsimones on 4/16/15.
//  Copyright (c) 2015 Bolt Visual. All rights reserved.
//

import Cocoa

class ScottWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        let rect = NSScreen.mainScreen()?.frame
        self.window?.setFrame(rect!, display: true)
        self.window?.title = "Scott Fitsimones"
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    override func windowWillLoad() {
        super.windowWillLoad()


    }
    


}
