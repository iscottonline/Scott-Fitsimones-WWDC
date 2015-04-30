//
//  LayeredView.swift
//  Scott Fitsimones
//
//  Created by Scott Fitsimones on 4/18/15.
//  Copyright (c) 2015 Bolt Visual. All rights reserved.
//

import Cocoa

class LayeredView: NSView {

    var textContent : String?
    var backImageView : NSImageView?
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        let newLayer = CALayer()
        newLayer.backgroundColor =  CGColorCreateGenericRGB(0.4, 0.7, 0.9, 1)
        self.wantsLayer = true
        self.layer = newLayer
        //self.layer?.opacity = 0
        let frame = NSScreen.mainScreen()?.frame as CGRect?
        self.frame = frame!
        // Drawing code here.
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        self.layer?.addAnimation(animation, forKey: "opacity")
        
        let label = CoolTextView(frame: (NSScreen.mainScreen()?.frame)!)
        label.string = textContent
        label.textContainerInset = NSMakeSize(400, 200)
        label.editable = false
        label.font = NSFont(name: "Avenir", size: 26)
        label.alignment = NSTextAlignment.CenterTextAlignment
        label.backgroundColor = NSColor.clearColor()
        self.addSubview(label)
        let point = NSScreen.mainScreen()?.frame.width
         let point2 = (NSScreen.mainScreen()?.frame.height)! - 80
//        let nextImageView = NSImageView(frame: CGRectMake(point!-100, 0, 100, 800))
//        nextImageView.image = NSImage(named: "move13")
//        self.addSubview(nextImageView)
        
        backImageView = NSImageView(frame: CGRectMake(0,point2/2, point!, point2))
    ///    backImageView?.imageAlignment = NSImageAlignment.AlignTop
        backImageView?.layer?.position = CGPointMake(0, 0)
        backImageView?.image = NSImage(named: "move13")
        backImageView?.frameCenterRotation = 90

        self.addSubview(backImageView!)
    }
    
    override func hitTest(aPoint: NSPoint) -> NSView? {
        return self.superview
    }
    
}
