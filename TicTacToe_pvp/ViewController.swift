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
    
    @IBOutlet weak var finalVerdict: UILabel!
    var playerId = ""
    var isFirst = ""
    var isMyTurn = false
    var connectionId = ""
    var player = ""
    var opponent = ""
    var ref: DatabaseReference!
    var opponentId = ""
    var board: [String: String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectionId = UserDefaults.standard.string(forKey: "connectionId")!
        playerId = UserDefaults.standard.string(forKey: "playerId")!
        isFirst = UserDefaults.standard.string(forKey: "isFirst")!
        
        ref = Database.database().reference()
        
        if(isFirst == "true"){
            player = "x.png"
            opponent = "o.png"
        }
        else{
            player = "o.png"
            opponent = "x.png"
        }
        
        ref.child("connections").child(connectionId).observeSingleEvent(of: .value, with: { [self] (snapshot) -> Void in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    if(child.key != playerId){
                        opponentId = child.key
                        let opponentName = child.value as! [String: Any]
                        player2.text = "\(opponentName["player_name"]!)"
                    }
                    else{
                        let playerName = child.value as! [String: Any]
                        player1.text = "\(playerName["player_name"]!)"
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
                        finalVerdict.text = "\(player1.text!)'s turn"
                    }
                    else{
                        player2Bar.startAnimating()
                        player1Bar.stopAnimating()
                        finalVerdict.text = "\(player2.text!)'s turn"
                    }
                }
            }
        })
        
        ref.child("board").child(connectionId).observe(.value, with: { [self] (snapshot) -> Void in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    
                    addToBoard(cell: child.key, sign: child.value! as! String)
                    
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

    func addToBoard(cell: String, sign: String){
        board[cell] = sign
        if(checkBoard(playerSign: player)){
            ref.child("won").child(connectionId).child(playerId).setValue("")
            present((storyboard?.instantiateViewController(withIdentifier: "final"))!, animated: true)
        }
        if(checkBoard(playerSign: opponent)){
            present((storyboard?.instantiateViewController(withIdentifier: "final"))!, animated: true)
        }
        
        
    }
    
    func checkBoard(playerSign: String) -> Bool{
        //cols
        if(board["cell00"] == playerSign && board["cell01"] == playerSign && board["cell02"] == playerSign){
            return true
        }
        if(board["cell10"] == playerSign && board["cell11"] == playerSign && board["cell12"] == playerSign){
            return true
        }
        if(board["cell20"] == playerSign && board["cell21"] == playerSign && board["cell22"] == playerSign){
            return true
        }
        //rows
        if(board["cell00"] == playerSign && board["cell10"] == playerSign && board["cell20"] == playerSign){
            return true
        }
        if(board["cell01"] == playerSign && board["cell11"] == playerSign && board["cell21"] == playerSign){
            return true
        }
        if(board["cell02"] == playerSign && board["cell12"] == playerSign && board["cell22"] == playerSign){
            return true
        }
        
        //x's
        if(board["cell00"] == playerSign && board["cell11"] == playerSign && board["cell22"] == playerSign){
            return true
        }
        if(board["cell02"] == playerSign && board["cell11"] == playerSign && board["cell20"] == playerSign){
            return true
        }
        return false
    }

    @IBAction func clicked(_ sender: UIButton) {
        
        if(isMyTurn){
            ref.child("board").child(connectionId).child(sender.currentTitle!).setValue(player)
            
            ref.child("turns").child(connectionId).child(playerId).removeValue()
            ref.child("turns").child(connectionId).child(opponentId).setValue("")
            isMyTurn = false
        }

    }
    
}

