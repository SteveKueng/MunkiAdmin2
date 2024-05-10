//
//  ModalViewController.swift
//  MunkiAdmin2
//
//  Created by Küng, Steve on 02.05.2024.
//

import Cocoa

class ModalViewController: NSViewController {
    
    let repobridge = RepoBridge()
    let navigationItems = ["General", "Managed Installs", "Managed Uninstalls", "Optional Installs", "Included Manifests", "Catalogs", "Plist"]
    var manifest:[String:Any] = [:]
    
    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var notesField: NSTextField!
    @IBOutlet weak var modalTabView: NSTabView!
    @IBOutlet var plistField: NSTextView!
    @IBOutlet weak var navigationTable: NSTableView!
    @IBOutlet weak var managedInstallsTable: NSTableView!
    @IBOutlet weak var managedUninstallsTable: NSTableView!
    @IBOutlet weak var optionalInstallsTable: NSTableView!
    @IBOutlet weak var includedManifestsTable: NSTableView!
    @IBOutlet weak var catalogsTable: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        modalTabView.tabViewBorderType = .none
        
        navigationTable.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
        navigationTable.action = #selector(navigationClick(_:))
        
        let manifestName = DataStore.shared.manifestName
        print(manifestName)
        
        if manifestName != "" {
            manifest = repobridge.getPlist(item: "manifests/" + manifestName)
            nameField.stringValue = manifestName
            
            if let plistData = try? PropertyListSerialization.data(fromPropertyList: manifest, format: .xml, options: 0),
               let plistString = String(data: plistData, encoding: .utf8) {
                plistField.string = plistString
            }
            
            managedInstallsTable.reloadData()
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        guard let window = self.view.window, let parent = window.sheetParent else { return }
        parent.endSheet(window, returnCode: .cancel)
    }
    
    
    @IBAction func save(_ sender: Any) {
        guard let window = self.view.window, let parent = window.sheetParent else { return }
        parent.endSheet(window, returnCode: .cancel)
    }
    
    @objc func navigationClick(_ sender:AnyObject) {
        modalTabView.selectTabViewItem(at: navigationTable.selectedRow)
    }
}

extension ModalViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView == self.navigationTable {
            return (navigationItems.count)
        }
        if tableView == self.managedInstallsTable {
            return (manifest["managed_installs"] as? Array<Any>)?.count ?? 0
        }
        if tableView == self.managedUninstallsTable {
            return (manifest["managed_uninstalls"] as? Array<Any>)?.count ?? 0
        }
        if tableView == self.optionalInstallsTable {
            return (manifest["optional_installs"] as? Array<Any>)?.count ?? 0
        }
        if tableView == self.includedManifestsTable {
            return (manifest["included_manifests"] as? Array<Any>)?.count ?? 0
        }
        if tableView == self.catalogsTable {
            return (manifest["catalogs"] as? Array<Any>)?.count ?? 0
        }
        
        return 0
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

        guard let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        
        if tableView == self.navigationTable {
            cell.textField?.stringValue = navigationItems[row]
        }
        if tableView == self.managedInstallsTable {
            cell.textField?.stringValue = (manifest["managed_installs"] as! Array<String>)[row]
        }
        if tableView == self.managedUninstallsTable {
            cell.textField?.stringValue = (manifest["managed_uninstalls"] as! Array<String>)[row]
        }
        if tableView == self.optionalInstallsTable {
            cell.textField?.stringValue = (manifest["optional_installs"] as! Array<String>)[row]
        }
        if tableView == self.includedManifestsTable {
            cell.textField?.stringValue = (manifest["included_manifests"] as! Array<String>)[row]
        }
        if tableView == self.catalogsTable {
            cell.textField?.stringValue = (manifest["catalogs"] as! Array<String>)[row]
        }
        
        return cell
    }
}
