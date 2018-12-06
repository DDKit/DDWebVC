//
//  ViewController.swift
//  DDWebVC
//
//  Created by DD on 12/06/2018.
//  Copyright (c) 2018 DD. All rights reserved.
//

import UIKit
import DDWebVC

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = DDWebVC()
        present(vc, animated: true, completion: nil)
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

