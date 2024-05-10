import Cocoa

extension NSToolbar.Identifier {
    static let mainWindowToolbarIdentifier = NSToolbar.Identifier("MainWindowToolbar")
}

extension NSToolbarItem.Identifier {
    //  Standard examples of `NSToolbarItem`
    static let toolbarItemToggleTitlebarAccessory = NSToolbarItem.Identifier("ToolbarToggleTitlebarAccessoryItem")
    
    /// Example of `NSMenuToolbarItem`
    static let toolbarItemMakeCatalogs = NSToolbarItem.Identifier("toolbarItemMakeCatalogs")
    static let toolbarItemReloadData = NSToolbarItem.Identifier("toolbarItemReloadData")
    
    /// Example of `NSToolbarItemGroup`
    static let toolbarPickerItem = NSToolbarItem.Identifier("ToolbarPickerItemGroup")
    static let toolbarPickerItemMomentary = NSToolbarItem.Identifier("ToolbarPickerItemGroupMomentary")

    /// Example of `NSSearchToolbarItem`
    static let toolbarSearchItem = NSToolbarItem.Identifier("ToolbarSearchItem")
}
