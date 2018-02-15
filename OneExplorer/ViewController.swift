//
//  ViewController.swift
//  OneExplorer
//
//  Created by Mohit Garg on 2/12/18.
//  Copyright © 2018 Mohit Garg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var producer: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var signature: UILabel!
    @IBOutlet weak var fetch: UIButton!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var prefix: UILabel!
    
    let service = BlockFetch()
    
    var latestBlock: Block?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        service.getChainInfo(){block, error in
            print(block!)
            self.latestBlock = block
            self.presentBlock()
        }
    }

    func presentBlock(){
        number.text = String(describing: latestBlock!.number)
        timestamp.text = String(describing: latestBlock!.timeStamp)
        prefix.text = String(describing: latestBlock!.prefix)
        signature.text = latestBlock!.signature
        producer.text = latestBlock!.producer
        id.text = latestBlock!.id
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fetchBlock(_ sender: Any) {
        service.getChainInfo(){block, error in
            print(block!)
            self.latestBlock = block
            self.presentBlock()
        }
    }
}

