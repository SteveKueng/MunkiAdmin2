//
//  ViewController.swift
//  MunkiAdmin2
//
//  Created by Steve Küng on 15.04.2024.
//

import Cocoa

class ManifestsViewController: NSViewController {
    
    @IBOutlet weak var manifestTableView: NSTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        manifestTableView.rowHeight = 35
        manifestTableView.doubleAction = #selector(tableViewDoubleClick(_:))
        
    }
    
    override func viewDidAppear() {
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @objc func tableViewDoubleClick(_ sender:AnyObject) {
        //
        DataStore.shared.manifestName =  DataStore.shared.Manifests[manifestTableView.selectedRow]
        
        let storyboardName = NSStoryboard.Name(stringLiteral: "Main")
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
         
        let sceneIdentifier = NSStoryboard.SceneIdentifier(stringLiteral: "ModalViewController")
        guard let windowController = storyboard.instantiateController(withIdentifier: sceneIdentifier) as? NSWindowController,
        let modalWindow = windowController.window else { return }
        
        self.view.window?.beginSheet(modalWindow)
    }
}

extension ManifestsViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in manifestTableView: NSTableView) -> Int {
        return (DataStore.shared.Manifests.count)
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let manifest =  DataStore.shared.Manifests[row]

        guard let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        cell.textField?.stringValue = manifest

        return cell
    }
}
