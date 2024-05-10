//
//  PackagesViewController.swift
//  MunkiAdmin2
//
//  Created by Küng, Steve on 28.04.2024.
//

import Cocoa

class PackagesViewController: NSViewController {
    
    @IBOutlet weak var packagesTableView: NSTableView!
    
    let repobridge = RepoBridge()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        packagesTableView.rowHeight = 35
        
    }
}

extension PackagesViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in packagesTableView: NSTableView) -> Int {
      return (DataStore.shared.Packages.count)
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let package = DataStore.shared.Packages[row]

        guard let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        cell.textField?.stringValue = package

        return cell
    }
}
