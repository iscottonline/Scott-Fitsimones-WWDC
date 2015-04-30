//
//  FunTableView.swift
//  Scott Fitsimones
//
//  Created by Scott Fitsimones on 4/18/15.
//  Copyright (c) 2015 Bolt Visual. All rights reserved.
//

import Cocoa

class FunTableView: NSTableView {

    var selectedCol : NSInteger?
    
    override func mouseMoved(theEvent: NSEvent) {
        // Detect mouse location
        let myPoint = theEvent.locationInWindow
        let row = self.rowAtPoint(myPoint)
        let col = self.columnAtPoint(myPoint)
        println("At location %@, %@", row, col)
        if (selectedCol != nil) {
        let currentView = self.viewAtColumn(self.selectedRow, row: selectedCol!, makeIfNecessary: true) as! NSView
            currentView.alphaValue = 0.8
        }
    }
    
    override func mouseDown(theEvent: NSEvent) {
        // Override to tell us selected Column
        let locationInWindow = theEvent.locationInWindow as NSPoint
        let locationInCell = self.convertPoint(locationInWindow, fromView: nil)
        selectedCol = self.columnAtPoint(locationInCell) as NSInteger
         super.mouseDown(theEvent)
    }
    
}
