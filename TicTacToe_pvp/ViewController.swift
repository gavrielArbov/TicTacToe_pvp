//
//  ViewController.swift
//  TicTacToe_pvp
//
//  Created by user216463 on 6/9/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cell00: UIButton!
    @IBOutlet weak var cell10: UIButton!
    @IBOutlet weak var cell20: UIButton!
    @IBOutlet weak var cell01: UIButton!
    @IBOutlet weak var cell11: UIButton!
    @IBOutlet weak var cell21: UIButton!
    @IBOutlet weak var cell02: UIButton!
    @IBOutlet weak var cell12: UIButton!
    @IBOutlet weak var cell22: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }



    @IBAction func clicked(_ sender: UIButton) {
        if sender.currentTitle == "cell00"{
                cell00.setImage(UIImage(named: "x.png"), for: .normal)
        }
        if sender.currentTitle == "cell11"{
                cell11.setImage(UIImage(named: "o.png"), for: .normal)
        }
    }
    
}

