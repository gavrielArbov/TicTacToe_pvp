

import UIKit
import FirebaseDatabase

class FinalViewController: UIViewController {
    var connectionId = ""
    var playerId = ""
    var ref: DatabaseReference!
    @IBOutlet weak var result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        connectionId = UserDefaults.standard.string(forKey: "connectionId")!
        playerId = UserDefaults.standard.string(forKey: "playerId")!

        ref = Database.database().reference()
        
        ref.child("won").child(connectionId).observe(.value, with: { [self] (snapshot) -> Void in
            if let results = snapshot.children.allObjects as? [DataSnapshot] {
                for child in results {
                    if(child.key == playerId){
                        result.text = "You Won"
                    }
                    else{
                        result.text = "You Lost"
                    }
                }
            }
        })
    }
    

    @IBAction func returnClicked(_ sender: Any) {
        present((storyboard?.instantiateViewController(withIdentifier: "menu"))!, animated: true)
    }
}
