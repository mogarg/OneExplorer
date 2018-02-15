//
//  ViewController.swift
//  OneExplorer
//
//  Created by Mohit Garg on 2/12/18.
//  Copyright © 2018 Mohit Garg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fetch: UIButton!
    let service = BlockFetch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        service.getChainInfo(){block, error in
            print(block!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fetchBlock(_ sender: Any) {
        
    }
}

