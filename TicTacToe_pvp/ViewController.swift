//
//  ViewController.swift
//  TicTacToe_pvp
//
//  Created by user216463 on 6/9/22.
//

import UIKit
import FirebaseDatabase

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
    
    @IBOutlet weak var player1: UILabel!
    
    @IBOutlet weak var player1Bar: UIActivityIndicatorView!
    @IBOutlet weak var player2: UILabel!
    @IBOutlet weak var player2Bar: UIActivityIndicatorView!
    
    var playerId = ""
    var isFirst = ""
    var isMyTurn = false
    var connectionId = ""
    var player = ""
    var ref: DatabaseReference!
    var opponentId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectionId = UserDefaults.standard.string(forKey: "connectionId")!
        playerId = UserDefaults.standard.string(forKey: "playerId")!
        isFirst = UserDefaults.standard.string(forKey: "isFirst")!
        
        ref = Database.database().reference()
        
        if(isFirst == "true"){
            player = "x.png"
        }
        else{
            player = "o.png"
        }
        
        ref.child("connections").child(connectionId).observeSingleEvent(of: .value, with: { [self] (snapshot) -> Void in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    if(child.key != playerId){
                        opponentId = child.key
                        //print(child("player_name"))
                    }
                }
            }
        })
        
        ref.child("turns").child(connectionId).observe(.value, with: { [self] (snapshot) -> Void in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    if(child.key == playerId){
                        isMyTurn = true
                        player1Bar.startAnimating()
                        player2Bar.stopAnimating()
                    }
                    else{
                        player2Bar.startAnimating()
                        player1Bar.stopAnimating()
                    }
                }
            }
        })
        
        ref.child("board").child(connectionId).observe(.value, with: { [self] (snapshot) -> Void in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    if(child.key == "cell00"){
                        cell00.setImage(UIImage(named: child.value as! String), for: .normal)
                    }
                    if child.key == "cell01"{
                        cell01.setImage(UIImage(named: child.value as! String), for: .normal)
                    }
                    if child.key == "cell02"{
                        cell02.setImage(UIImage(named: child.value as! String), for: .normal)
                    }
                    if child.key == "cell10"{
                        cell10.setImage(UIImage(named: child.value as! String), for: .normal)
                    }
                    if child.key == "cell11"{
                        cell11.setImage(UIImage(named: child.value as! String), for: .normal)
                    }
                    if child.key == "cell12"{
                        cell12.setImage(UIImage(named: child.value as! String), for: .normal)
                    }
                    if child.key == "cell20"{
                        cell20.setImage(UIImage(named: child.value as! String), for: .normal)
                    }
                    if child.key == "cell21"{
                        cell21.setImage(UIImage(named: child.value as! String), for: .normal)
                    }
                    if child.key == "cell22"{
                        cell22.setImage(UIImage(named: child.value as! String), for: .normal)
                    }
                    
                    
                }
            }
        })
    }

    func checkWinMagnya(sign: String){
        
    }

    @IBAction func clicked(_ sender: UIButton) {
        //print(sender.currentTitle)
        if(isMyTurn){
            ref.child("board").child(connectionId).child(sender.currentTitle!).setValue(player)
            
            ref.child("turns").child(connectionId).child(playerId).removeValue()
            ref.child("turns").child(connectionId).child(opponentId).setValue("")
            isMyTurn = false
        }

    }
    
}

