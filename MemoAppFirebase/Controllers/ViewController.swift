
//
//  ViewController.swift
//  MemoAppFirebase
//
//  Created by 高木克 on 2022/06/19.
//

import UIKit
import Firebase

struct Memos {
    var text: String
}

class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var memos: [Memos] = []

//        Firebaseからデータを取得
        Firestore.firestore().collection("memos").document("zd2Tz3C1yJhfAB3upyBT").getDocument { (snap, err) in
            if let err = err {
                fatalError("\(err)")
            }
            guard let data = snap?.data() else { return }
            print(data)
        }
        
//        memosコレクションに新しくランダムなUIDをキーとしたドキュメントを作成するコード(追加)
        Firestore.firestore().collection("memos").document().setData(
            [
                "text": "テスト1"
            ])

    }
    
    @IBAction func pushSaveButton(sender: UIStoryboardSegue){
        guard let senderVC = sender.source as? AddMemoViewController, let text:String = senderVC.textLabel.text else { return }
        self.textLabel.text = text
//        self.textLabel.text = senderVC.one    
    }
        
    
    @IBAction func addButton(_ sender: Any) {
        print("addButton")
        let storyboard = UIStoryboard(name: "AddMemo", bundle: nil)
        let addMemoViewController = storyboard.instantiateViewController(identifier: "AddNavigationController") as! UINavigationController
        self.present(addMemoViewController, animated: true)
    }
    

}

