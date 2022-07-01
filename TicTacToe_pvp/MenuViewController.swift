import FirebaseDatabase

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    var playerId = ""
    var opponentId = ""
    var roomId = ""
    var playersCount: UInt = 0
    var opponentFound = false
    var status = "matching"
    var connectionId = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        playerId = UUID().uuidString
        roomId = UUID().uuidString
    }
    

    @IBAction func quickClicked(_ sender: Any) {
        progress.startAnimating()
        let user = UserDefaults.standard.string(forKey: "userName")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("connections").observe(.value, with: { [self] (snapshot) -> Void in
            
            if(!opponentFound){
                if(snapshot.hasChildren()){
                    if let result = snapshot.children.allObjects as? [DataSnapshot] {
                        for child in result {
                            connectionId = child.key
                                
                            let playersCount = child.childrenCount
                            print(playersCount)
                            if(status == "waiting"){
                                if(playersCount == 2){
                                    var playerFound = false
                                    var getPlayerId = ""
                                    for grandChild in child.children {
                                        getPlayerId = (grandChild as AnyObject).key
                                            
                                        if(playerId != getPlayerId){
                                            playerFound = true
                                        }
                                        else if(playerFound){
                                            opponentFound = true
                                            UserDefaults.standard.set(connectionId, forKey: "connectionId")
                                            present((storyboard?.instantiateViewController(withIdentifier: "game"))!, animated: true)
                                        }
                                    }
                                }
                                        
                                    
                            }
                            else{
                                if(playersCount == 1){
                                    ref.child("connections").child(connectionId).child(playerId).child("player_name").setValue(user)
                                    UserDefaults.standard.set(connectionId, forKey: "connectionId")
                                    present((storyboard?.instantiateViewController(withIdentifier: "game"))!, animated: true)
                                }
                            }
                        }
                    }
                    
                    
                }
                else{
                    connectionId = UUID().uuidString
                    ref.child("connections").child(connectionId).child(playerId).child("player_name").setValue(user)
                    status = "waiting"
                }
                
            }
            
            
            
            
            /*
            let playersCount = snapshot.childrenCount
            
            // create room
            if(playersCount == 0 || playersCount == 2){
                ref.child("connections").child(roomId).child(playerId).setValue(user)
            }
            // join room
            else if(playersCount == 1){
                print(snapshot.key)
            }
            */

            
        })
        
        
        //ref.child("connections").child(roomId).setValue(["username": user])
        
        
        
        
        //present((storyboard?.instantiateViewController(withIdentifier: "game"))!, animated: true)
    }
}
