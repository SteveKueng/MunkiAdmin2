//
//  TabViewController.swift
//  MunkiAdmin2
//
//  Created by Küng, Steve on 10.05.2024.
//

import Cocoa

class TabViewController: NSTabViewController {
    
    let repobridge = RepoBridge()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    override func viewDidAppear() {
        loadData()
    }
    
    func loadData() {
        let storyboardName = NSStoryboard.Name(stringLiteral: "Main")
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let sceneIdentifier = NSStoryboard.SceneIdentifier(stringLiteral: "LoadingViewController")
        guard let windowController = storyboard.instantiateController(withIdentifier: sceneIdentifier) as? NSWindowController,
        let modalWindow = windowController.window else { return }
        self.view.window?.beginSheet(modalWindow)
        
        let loadingViewController = modalWindow.contentViewController as? LoadingViewController
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                loadingViewController?.progressLabel.stringValue = "Load manifests..."
            }
            DataStore.shared.Manifests = self.repobridge.listitems(kind: "manifests")
            
            DispatchQueue.main.async {
                loadingViewController?.progressLabel.stringValue = "Load pkgsinfo..."
            }
            DataStore.shared.Packages = self.repobridge.listitems(kind: "pkgsinfo")
            
            DispatchQueue.main.async {
                loadingViewController?.progressLabel.stringValue = "Load catalogs..."
            }
            DataStore.shared.Catalogs = self.repobridge.listitems(kind: "catalogs")
            
            
            DispatchQueue.main.async {
                let entriesManifests:NSTabViewItem = self.tabViewItems[0] as NSTabViewItem
                let ManifestsVC:ManifestsViewController? = entriesManifests.viewController as! ManifestsViewController?
                if (ManifestsVC != nil){
                    ManifestsVC?.manifestTableView.reloadData()
                }
                
                let entriesPackages:NSTabViewItem = self.tabViewItems[1] as NSTabViewItem
                let PackagesVC:PackagesViewController? = entriesPackages.viewController as! PackagesViewController?
                if (PackagesVC != nil){
                    PackagesVC?.packagesTableView.reloadData()
                }
                
                let entriesCatalogs:NSTabViewItem = self.tabViewItems[2] as NSTabViewItem
                let CatalogsVC:CatalogsViewController? = entriesCatalogs.viewController as! CatalogsViewController?
                if (CatalogsVC != nil){
                    CatalogsVC?.catalogTableView.reloadData()
                }
                
                self.view.window?.endSheet(modalWindow)
            }
        }
    }
    
}
