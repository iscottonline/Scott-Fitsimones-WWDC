//
//  ViewController.swift
//  Scott Fitsimones
//
//  Created by Scott Fitsimones on 4/14/15.
//  Copyright (c) 2015 Bolt Visual. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, NSGestureRecognizerDelegate {
    @IBOutlet var mainView: NSView!
    @IBOutlet var scrollView: NSScrollView!
    @IBOutlet var scottTableView: FunTableView!
    
    var squareColors : NSArray?
    var cellHeight : CGFloat?
    var adjectives1 : NSArray?
    var adjectives2 : NSArray?
    var adjectives3 : NSArray?
    var adjectives4 : NSArray?
    
    // To track selection
    var selectedRow : Int?
    var selectedColumn : Int?
    
    // For animation
    var currentRow : Int = 0
    var currentColumn : Int = 0
    
    // Useful
    let mainScreen = NSScreen.mainScreen()?.frame as CGRect?
    var logoImage : NSImageView?
    var startupView : StartupView?
    var contentSlideView : LayeredView?
    // Data
    var dataSource : NSArray?
    var goText : NSTextView?
    
    var click : NSPressGestureRecognizer?
     var top : NSPressGestureRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the squares in a table view
        scottTableView.setDelegate(self)
        scottTableView.columnAutoresizingStyle = NSTableViewColumnAutoresizingStyle.UniformColumnAutoresizingStyle
        scottTableView.selectionHighlightStyle = NSTableViewSelectionHighlightStyle.None
        
        // Create colors for the squares
        let color1 = CGColorCreateGenericRGB(1, 0.6, 0.1, 1)
        let color2 = CGColorCreateGenericRGB(0.6, 0.6, 0.63, 1)
        let color3 = CGColorCreateGenericRGB(0.2, 0.666, 0.86, 1)
        let color4 = CGColorCreateGenericRGB(0.3, 0.8, 0.4, 1)
        squareColors = NSArray(objects: color1, color2, color3, color4)
        
        adjectives1 = NSArray(objects: "developer", "artist", "web dev", "musician")
        adjectives2 = NSArray(objects: "scholar", "animal lover", "app store slayer", "inventor")
        adjectives3 = NSArray(objects: "apple fan", "designer", "runner", "jazz listener")
        adjectives4 = NSArray(objects: "reader", "music producer", "TV watcher", "volunteer")
        
         dataSource = [
            "I am enthusiastic about Swift and I'm passionate about the power of programming to make the world a better place. I leanred iOS and Mac Development from Google searches and Stack Overflow. I know my code might not be perfectly written according to best practices, but attending WWDC would give me the opportnuity to refine my current skills, meet other developers, and innovate alongside them.",
            "I consider creating apps the work of not a developer who knows code, but as an artist. I love creating the whole package--from the interface to how it works together with the code. This is also why Apple is my favorite company: when you buy a Mac, you are buying a powerful computer and a piece of art. I want to have that kind of impact on people.",
            "I started coding websites at an early age. I'm profficient in HTML, Javascript, and CSS. Of course, out of all the programming languages, my heart lies with Swift. :) Though I've been mainly focused on apps, I have some websites. The website for my app studio is BoltVisual.com. I made a cool search engine called Avvecc.com.",
            "I've played piano and guitar for over 5 years. I love music, especially Kanye West and the Beatles. I also enjoy electronic music and jazz. I'm in a pop-rock band where I play guitar and produce the music, and our debut album is coming out soon on iTunes. Several of my apps are based around my passion for music, one of which, called Music Man, teaches you how to read notes.",
            "I was recently accepted into Stanford University! I am still in the midst of deciding since my state school, ASU, offered me a full ride. At school, I have several leadership positions under my belt, like being the president of Student Council. I like math, and I'm taking Calc BC right now.",
            "My family has a dog (a poodle) and two cats, as well as five chickens. ",
            "Okay, 'app store slayer' is a little ambitious for the title, but several of my apps have done well on the charts. One of my  apps, Guess the Song, was the number 4 Music app for over a week. My newest app is called Daily Brief, and it gives you daily voice news briefings. One of my Mac Apps, Marvin Voice Assistant, was in the top 100 in 21 countries.",
            "I recently invented a 3D printed iPhone case that lets you swipe your credit card with a flick of your finger. Check it out at NewtonCase.com.",
            "I believe strongly in Apple's company mission and with the vision of Jobs and Cook. But lets be honest, Jony Ive is the coolest. I have an Apple shirt, and I've waited 4+ hours for new iPhones and iPads. They know my name at the Apple Store...",
            "I am passioate about design, animation, colors, and fonts. I love Apple's move towards Helvetica Neue, but I still think Avenir is the better font. It's underrated. I think we have reached a point in computer science and graphics where we can create extremely complex apps and incredible graphics, and the future is about experimenting and honing complex apps into their minimalist core. ",
             "I love running and I'm currently training for a half-marathon. Running helps me stay sane during long periods of coding and development.",
            "I love jazz music, from Charles Mingus to Miles Davis. At school, I'm the guitarist in our jazz band.",
            "I love reading books. I'm currently reading Fast Food Nation, a book about how the fast food industry became so influential in America. I've also read Steve Jobs' biography, The Innovators Delimma, and a lot of Malcolm Gladwell books recently.",
            "I produce funk and pop music as part of a band called Dune Ave. The band name is a tribute to the hot weather where I live, in Phoenix, AZ. To produce, I use Apple's Logic X software.",
            "I love the TV Shows 'House', 'Silicon Valley', and 'Empire'. ",
            "I volunteer at the Arizona Science Center, I'm a member of my school's Honors Society, and I recently attended a hackathon at ASU called Hack 4 Humanity where we made apps for non-profits."
            ] as NSArray
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        scottTableView.setDataSource(self)
               scottTableView.reloadData()
        self.view.window?.collectionBehavior = NSWindowCollectionBehavior.FullScreenPrimary
        self.view.window?.toggleFullScreen(self)
     //      self.view.window?.makeFirstResponder(scottTableView)
        let options1 = NSTrackingAreaOptions.ActiveAlways | NSTrackingAreaOptions.MouseMoved
        let frame = self.view.bounds
        let trackingArea = NSTrackingArea(rect: frame, options: options1, owner: self, userInfo: nil)
        self.view.addTrackingArea(trackingArea)

        startupView = StartupView(frame: CGRectMake(0, 0, 400, 400))
        let screenFrame = NSScreen.mainScreen()?.frame  as CGRect?
        logoImage = NSImageView(frame: screenFrame!)
        logoImage?.frame = screenFrame!
           logoImage?.wantsLayer = true
        logoImage?.layer?.frame = screenFrame!
        logoImage?.image = NSImage(named: "wwdc logo")
       logoImage?.layer?.anchorPoint = CGPointMake(0.5, 0.5)
        
        
        
         goText = CoolTextView(frame: CGRectMake(0, 0, 200, 100))
        goText?.string = "Learn\n about\n Scott"
        goText?.frame = mainScreen!
        goText?.alignment = NSTextAlignment.CenterTextAlignment
    goText?.textContainerInset = NSMakeSize(400, (mainScreen?.height)!/2.42)
        goText?.textColor = NSColor.whiteColor()
        startupView?.addSubview(logoImage!)
        startupView?.addSubview(goText!)
        self.view.addSubview(startupView!)
        
        click = NSPressGestureRecognizer(target: self, action: Selector("freeView"))
        click?.minimumPressDuration = 0.00001
        click?.allowableMovement = 1000
        self.view.addGestureRecognizer(click!)
    //    self.view.window?.center()
    }

     func freeView() {
  // Executed when the WWDC wheel is clicked
        let finalAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        // Get the current angle to create the gradual stop animation
        let currentLayer = logoImage!.layer?.presentationLayer()
        let currentRotationAngle = currentLayer!.valueForKeyPath("transform.rotation.z") as! Float
        var rotateClosest = (M_PI / 2) as Double
        
        // Use this code to ensure that the WWDC wheel always spins clockwise-- or else it takes the path of least resistance
        if (currentRotationAngle >= Float(M_PI)) {
            rotateClosest = ((M_PI / 2) as Double?)!
        } else {
             rotateClosest = ((M_PI * 2) as Double?)!
        }
        logoImage?.layer?.removeAllAnimations()
        finalAnimation.fromValue = currentRotationAngle
        finalAnimation.fillMode = kCAFillModeForwards
        finalAnimation.toValue = rotateClosest
        finalAnimation.duration = 2
        finalAnimation.cumulative = true
        finalAnimation.repeatCount =  1
        finalAnimation.removedOnCompletion = false
        finalAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        var timer = NSTimer.scheduledTimerWithTimeInterval(3.2, target: self, selector: "showMainWindow", userInfo: nil, repeats: false)
        logoImage!.layer?.addAnimation(finalAnimation, forKey: "rotation")

//        logoImage?.removeFromSuperview()
//        goText?.removeFromSuperview()
//        startupView?.removeFromSuperview()
//        self.view.removeGestureRecognizer(click!)
    }
    
    func showMainWindow() {
                logoImage?.removeFromSuperview()
                goText?.removeFromSuperview()
                startupView?.removeFromSuperview()
                self.view.removeGestureRecognizer(click!)
    }
    override func viewDidAppear() {
        super.viewDidAppear()
          logoImage?.layer?.anchorPoint = CGPointMake(0.5, 0.5)
        let centerX = (NSScreen.mainScreen()?.frame.width)!/2
        let centerY = (NSScreen.mainScreen()?.frame.height)!/2
        logoImage?.layer?.position = CGPointMake(centerX, centerY)
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.fillMode = kCAFillModeForwards;
        rotationAnimation.toValue = M_PI * 2
        rotationAnimation.duration = 5
        rotationAnimation.repeatCount =  HUGE
        rotationAnimation.removedOnCompletion = false
        logoImage!.layer?.addAnimation(rotationAnimation, forKey: "rotation")

    }
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let width = tableColumn?.width
        let myView = NSView(frame: NSMakeRect(0, 0, width!, 100))
        let newLayer = CALayer()
        var newColor =   squareColors?.objectAtIndex(row) as! CGColor
        newLayer.backgroundColor = newColor
        let cellText = CoolTextView(frame:NSMakeRect(0, 0, myView.frame.width, cellHeight!*0.62))
           cellText.string = ""
        
        if (tableColumn?.identifier == "first") {
            newLayer.backgroundColor = CGColorCreateCopyWithAlpha(newColor, 0.7)
            cellText.string = adjectives1?.objectAtIndex(row) as? String
        } else if (tableColumn?.identifier == "second") {
               cellText.string = adjectives2?.objectAtIndex(row) as? String
        } else if (tableColumn?.identifier == "third") {
            newLayer.backgroundColor = CGColorCreateCopyWithAlpha(newColor, 0.7)
               cellText.string = adjectives3?.objectAtIndex(row) as? String
        } else {
               cellText.string = adjectives4?.objectAtIndex(row) as? String
        }
        
        myView.wantsLayer = true
        myView.layer = newLayer

           myView.addSubview(cellText)
        return myView
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {

        cellHeight = ((self.view.window?.frame.height)! / 4) + 5.5
                println(cellHeight)
        return cellHeight!
    }
    

    func showView() {
        contentSlideView = LayeredView(frame: CGRectMake(0, 0, 400, 400))
         contentSlideView?.layer?.anchorPoint = CGPointMake(0.5, 0.5)
        var contentIndex = 0 as Int
        if scottTableView.selectedCol == 0 {
        } else if scottTableView.selectedCol == 1 {
            contentIndex = 4
        } else if scottTableView.selectedCol == 2 {
            contentIndex = 8
        } else {
           contentIndex = 12
        }
        contentSlideView?.textContent =  dataSource?.objectAtIndex(selectedRow!+contentIndex) as! String
        mainView.addSubview(contentSlideView!)
        top = NSPressGestureRecognizer(target: self, action: Selector("removeSlide:"))
        top?.minimumPressDuration = 0.00001
        top?.allowableMovement = 1000
        top?.delegate = self
      self.view.addGestureRecognizer(top!)
//        let delay = 2.0 * Double(NSEC_PER_SEC)
//        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//
//        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
//            self.restoreTable()
//        }

// self.restoreTable()
    }
    
    func removeSlide(gesture : NSGestureRecognizer) {

        CATransaction.begin()
  //      let startPoint = contentSlideView?.frame.origin as CGPoint?
         contentSlideView?.layer?.anchorPoint = CGPointMake(0.5, 0.5)
        let startPoint = CGPointMake((contentSlideView?.frame.width)!/2, (contentSlideView?.frame.height)!/2) as CGPoint?
        let endPoint = CGPointMake((contentSlideView?.frame.width)!/2,-1000) as CGPoint?
       
        let slideAnimation = CABasicAnimation(keyPath: "position")
      slideAnimation.fromValue = NSValue(point: startPoint!)
        slideAnimation.toValue = NSValue(point: endPoint!)
        slideAnimation.duration = 2
        slideAnimation.fillMode = kCAFillModeForwards
        slideAnimation.removedOnCompletion = false
//        let animation = CABasicAnimation(keyPath: "opacity")
//        animation.fromValue = 1
//        animation.toValue = 0
//        animation.duration = 2
        slideAnimation.removedOnCompletion = true
        CATransaction.setCompletionBlock { () -> Void in
               self.contentSlideView!.animator().removeFromSuperview()
        }
        contentSlideView?.layer!.addAnimation(slideAnimation, forKey: "position")


        CATransaction.commit()
        NSAnimationContext.endGrouping()
      self.view.removeGestureRecognizer(top!)
                let delay = 0.8 * Double(NSEC_PER_SEC)
                var time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
      
        
                dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                    self.restoreTable()
                 
                }


    }
    
    func restoreTable() {
           self.scottTableView.deselectRow(self.selectedRow!)
            for var i = 0; i < 4; i++ {
              //  Undo the animations
                let cellViews =  scottTableView.viewAtColumn(0, row: i, makeIfNecessary: true) as! NSView
                cellViews.hidden = false
                let cellViews2 =  scottTableView.viewAtColumn(1, row: i, makeIfNecessary: true) as! NSView
                cellViews2.hidden = false
                let cellViews3 =  scottTableView.viewAtColumn(2, row: i, makeIfNecessary: true) as! NSView
                cellViews3.hidden = false
                let cellViews4 =  scottTableView.viewAtColumn(3, row: i, makeIfNecessary: true) as! NSView
                cellViews4.hidden = false
                //  Reset the animation selections
                }
        currentColumn = 0
        currentRow = 0
       
    }
    func animationSeq(withRow: Int, withColumn: Int) {
        let cellViews = scottTableView.viewAtColumn(withColumn, row: withRow, makeIfNecessary: true) as! NSView
        CATransition()
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fillMode = kCAFillModeForwards
        animation.duration = 0.1
        animation.fromValue = 1
        animation.toValue = 0
        animation.removedOnCompletion = true
     //   animation.removedOnCompletion = true
        CATransaction.setCompletionBlock { () -> Void in

            if (self.currentRow == self.selectedRow! && self.currentColumn == self.selectedColumn!) {
                println(self.selectedColumn)
                println(self.currentColumn)
            } else {
            cellViews.hidden = true
            }
            if (self.currentColumn > self.adjectives1!.count-1) {
                self.currentRow++
                self.currentColumn = 0
            }
            self.animateTable()
        }
        cellViews.layer?.addAnimation(animation, forKey: "opacity")
        CATransaction.commit()
    }
    func animateTable()
    {
// Animates the table after a selection
if (currentRow < 4) {
    // Leave the cell the user selected alone


    animationSeq(currentRow, withColumn: currentColumn)

    currentColumn++

} else {
    showView()
        }

}
    
    func tableView(tableView: NSTableView, didClickTableColumn tableColumn: NSTableColumn) {
      //
    }

    func tableViewSelectionDidChange(notification: NSNotification) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        selectedRow = scottTableView.selectedRow
        if (selectedRow >= 0) {
        selectedColumn = scottTableView.selectedCol! + 1
        animateTable()
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return 4
    }
    
    

}

