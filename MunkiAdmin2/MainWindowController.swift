import Cocoa

class MainWindowController: NSWindowController, NSToolbarItemValidation {
    
    // MARK: - Window Lifecycle
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window
        // controller's window has been loaded from its nib file.
        
        self.configureToolbar()
    }
    
    private func configureToolbar() {
        if  let unwrappedWindow = self.window {
            
            let newToolbar = NSToolbar(identifier: NSToolbar.Identifier.mainWindowToolbarIdentifier)
            newToolbar.delegate = self
            newToolbar.allowsUserCustomization = false
            newToolbar.autosavesConfiguration = true
            newToolbar.displayMode = .default
            
            // Example on center-pinning a toolbar item
            newToolbar.centeredItemIdentifier = NSToolbarItem.Identifier.toolbarPickerItem
            
            unwrappedWindow.title = "MunkiAdmin2"
            unwrappedWindow.subtitle = ""
            // The toolbar style is best set to .automatic
            // But it appears to go as .unifiedCompact if
            // you set as .automatic and titleVisibility as
            // .hidden
            unwrappedWindow.toolbarStyle = .unified
            
            // Hiding the title visibility in order to gain more toolbar space.
            // Set this property to .visible or delete this line to get it back.
            unwrappedWindow.titleVisibility = .visible
            
            unwrappedWindow.toolbar = newToolbar
            unwrappedWindow.toolbar?.validateVisibleItems()
        }
    }
    
    // MARK: - Toolbar Validation
    
    func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        // print("Validating \(item.itemIdentifier)")
        
        return true
    }
    
    // MARK: - Toolbar Item Custom Actions
    
    @IBAction func relaodData(_ sender: Any) {
        if  let toolbarItem = sender as? NSToolbarItem {
            print("Clicked \(toolbarItem.itemIdentifier.rawValue)")
            let splitVC = self.contentViewController as? NSSplitViewController
            print(splitVC)
            let tabVC = splitVC?.splitViewItems[1].viewController as? TabViewController
            print(tabVC)
            
            tabVC?.loadData()
        }
    }
    
    @IBAction func makeCatalogs(_ sender: Any) {
        if  let toolbarItem = sender as? NSToolbarItem {
            print("Clicked \(toolbarItem.itemIdentifier.rawValue)")
        }
    }
}

// MARK: - Toolbar Delegate

extension MainWindowController: NSToolbarDelegate {
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        //  macOS 11: A rounded square appears behind the icon on mouse-over
        //  macOS X : The item has the appearance of an NSButton (button frame)
        //            If false, it's just a free-standing icon as they appear
        //            in typical Preferences windows with toolbars.
                
        if  itemIdentifier == NSToolbarItem.Identifier.toolbarPickerItem {
            let titles = ["Manifests", "Packages", "Catalogs", "Icons"]
            
            // This will either be a segmented control or a drop down depending
            // on your available space.
            //
            // NOTE: When you set the target as nil and use the string method
            // to define the Selector, it will go down the Responder Chain,
            // which in this app, this method is in AppDelegate. Neat!
            let toolbarItem = NSToolbarItemGroup(itemIdentifier: itemIdentifier, titles: titles, selectionMode: .selectOne, labels: titles, target: nil, action: Selector(("toolbarPickerDidSelectItem:")) )
            toolbarItem.controlRepresentation = .automatic
            toolbarItem.selectionMode = .selectOne
            toolbarItem.label = "View"
            toolbarItem.paletteLabel = "View"
            toolbarItem.toolTip = "Change the selected view"
            toolbarItem.selectedIndex = 0
            return toolbarItem
        }
        
        if  itemIdentifier == NSToolbarItem.Identifier.toolbarItemMakeCatalogs {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(makeCatalogs(_:))
            toolbarItem.label = "Makecatalogs"
            toolbarItem.paletteLabel = "Makecatalogs"
            toolbarItem.toolTip = "Recreate munki catalogs"
            toolbarItem.isBordered = true
            toolbarItem.image = NSImage(systemSymbolName: "pencil.and.list.clipboard", accessibilityDescription: "")
            return toolbarItem
        }
        
        if  itemIdentifier == NSToolbarItem.Identifier.toolbarItemReloadData {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(relaodData(_:))
            toolbarItem.label = "Reload"
            toolbarItem.paletteLabel = "Reload"
            toolbarItem.toolTip = "Reload munkirepo data"
            toolbarItem.isBordered = true
            toolbarItem.image = NSImage(systemSymbolName: "arrow.circlepath", accessibilityDescription: "")
            return toolbarItem
        }
        
        if  itemIdentifier == NSToolbarItem.Identifier.toolbarSearchItem {
            //  `NSSearchToolbarItem` is macOS 11 and higher only
            let searchItem = NSSearchToolbarItem(itemIdentifier: itemIdentifier)
            searchItem.resignsFirstResponderWithCancel = true
            searchItem.searchField.delegate = self
            searchItem.toolTip = "Search"
            return searchItem
        }
        
        return nil
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            NSToolbarItem.Identifier.toolbarItemToggleTitlebarAccessory,
            NSToolbarItem.Identifier.flexibleSpace,
            NSToolbarItem.Identifier.toolbarPickerItemMomentary,
            NSToolbarItem.Identifier.flexibleSpace,
            NSToolbarItem.Identifier.toolbarPickerItem,
            NSToolbarItem.Identifier.flexibleSpace,
            NSToolbarItem.Identifier.toolbarItemMakeCatalogs,
            NSToolbarItem.Identifier.toolbarItemReloadData,
            NSToolbarItem.Identifier.toolbarSearchItem
        ]
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            NSToolbarItem.Identifier.toolbarItemToggleTitlebarAccessory,
            NSToolbarItem.Identifier.toolbarPickerItemMomentary,
            NSToolbarItem.Identifier.toolbarPickerItem,
            NSToolbarItem.Identifier.toolbarItemMakeCatalogs,
            NSToolbarItem.Identifier.toolbarItemReloadData,
            NSToolbarItem.Identifier.toolbarSearchItem,
            NSToolbarItem.Identifier.space,
            NSToolbarItem.Identifier.flexibleSpace]
    }
    
    func toolbarWillAddItem(_ notification: Notification) {
        // print("~ ~ toolbarWillAddItem: \(notification.userInfo!)")
    }
    
    func toolbarDidRemoveItem(_ notification: Notification) {
        // print("~ ~ toolbarDidRemoveItem: \(notification.userInfo!)")
    }
    
    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        // Return the identifiers you'd like to show as "selected" when clicked.
        // Similar to how they look in typical Preferences windows.
        return []
    }
    
}

// MARK: - Titlebar Accessory View

extension MainWindowController {

}

// MARK: - Sharing Service Picker Toolbar Item Delegate

extension MainWindowController: NSSharingServicePickerToolbarItemDelegate {
    func items(for pickerToolbarItem: NSSharingServicePickerToolbarItem) -> [Any] {
        // Compose an array of items that are sharable such as text, URLs, etc.
        // depending on the context of your application (i.e. what the user
        // current has selected in the app and/or they tab they're in).
        let sharableItems = [URL(string: "https://www.apple.com/")!]
        return sharableItems
    }
}

// MARK: - Search Field Delegate

extension MainWindowController: NSSearchFieldDelegate {
    func searchFieldDidStartSearching(_ sender: NSSearchField) {
        print("Search field did start receiving input")
        
        
    }
    
    func searchFieldDidEndSearching(_ sender: NSSearchField) {
        print("Search field did end receiving input")
        sender.resignFirstResponder()
    }
}

class MainWindow: NSWindow {
    
}
