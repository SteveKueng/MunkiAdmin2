//
//  CatalogsViewController.swift
//  MunkiAdmin2
//
//  Created by Küng, Steve on 28.04.2024.
//

import Cocoa

class CatalogsViewController: NSViewController {
    
    @IBOutlet weak var catalogTableView: NSTableView!
    
    let repobridge = RepoBridge()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        catalogTableView.rowHeight = 35
    }
}

extension CatalogsViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in catalogTableView: NSTableView) -> Int {
      return (DataStore.shared.Catalogs .count)
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let catalog = DataStore.shared.Catalogs [row]

        guard let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        cell.textField?.stringValue = catalog

        return cell
    }
}
