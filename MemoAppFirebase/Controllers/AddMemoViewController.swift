//
//  AddMemoViewController.swift
//  MemoAppFirebase
//
//  Created by 高木克 on 2022/06/19.
//

import UIKit

class AddMemoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var inputText: UITextField!
    
    let one:String = "わん"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputText.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    //    キャンセルボタン押下
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = inputText.text
        textLabel.text = text
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.textLabel.text = self.inputText.text
    }

}
