
//
//  ViewController.swift
//  MemoAppFirebase
//
//  Created by 高木克 on 2022/06/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    
    @IBAction func addButton(_ sender: Any) {
        print("addButton")
        let storyboard = UIStoryboard(name: "AddMemo", bundle: nil)
        let addMemoViewController = storyboard.instantiateViewController(identifier: "AddNavigationController") as! UINavigationController
        self.present(addMemoViewController, animated: true)
    }
    

}

