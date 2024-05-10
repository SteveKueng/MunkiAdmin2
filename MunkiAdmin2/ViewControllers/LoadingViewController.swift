//
//  LoadingViewController.swift
//  MunkiAdmin2
//
//  Created by Küng, Steve on 08.05.2024.
//

import Cocoa

class LoadingViewController: NSViewController {

    @IBOutlet weak var progressLabel: NSTextField!
    @IBOutlet weak var progressindicator: NSProgressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        progressindicator.startAnimation(self)
    }
    
}
