//
//  AppDelegate.swift
//  MunkiAdmin2
//
//  Created by Steve Küng on 15.04.2024.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @objc func toolbarPickerDidSelectItem(_ sender: Any) {
        if  let toolbarItemGroup = sender as? NSToolbarItemGroup {
            //print("toolbar item group selected index: \(toolbarItemGroup.selectedIndex)")
            
            let splitviewcontroller = NSApplication.shared.keyWindow?.contentViewController as? NSSplitViewController
            let controller = splitviewcontroller?.splitViewItems[1].viewController as? NSTabViewController
            controller!.selectedTabViewItemIndex = toolbarItemGroup.selectedIndex
            
        }
    }
}

