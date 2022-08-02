
import UIKit

class AddMovieViewController: UIViewController ,UITextFieldDelegate {
    @IBOutlet var feild:UITextField!
    var update: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
//to save data when user press save button
        feild.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self , action: #selector(saveMovie))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveMovie()
        return true
    }
    
    @objc func saveMovie()
    {
        guard let text = feild.text , !text.isEmpty else{
            return
        }
        //get user default array and save into it.
        let userDefaults = UserDefaults.standard
        var srMoveName: [String] = userDefaults.object(forKey: "myMovieList") as? [String] ?? []
        srMoveName.append(text)
        userDefaults.set(srMoveName, forKey: "myMovieList")
        //optional
        update?()
        navigationController?.popViewController(animated: true)
    }
}
