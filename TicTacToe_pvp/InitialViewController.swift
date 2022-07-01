
import UIKit
import FirebaseDatabase
class InitialViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func startClicked(_ sender: Any) {
        let user = nameText.text
        //var ref: DatabaseReference!
        if (user?.isEmpty == true){
            UserDefaults.standard.set("Player1", forKey: "userName")
        }
        else{
            UserDefaults.standard.set(user, forKey: "userName")
        }
        
        present((storyboard?.instantiateViewController(withIdentifier: "menu"))!, animated: true)
    }
    

}
