
//
//  ViewController.swift
//  MemoAppFirebase
//
//  Created by 高木克 on 2022/06/19.
//

import UIKit
import Firebase

struct Memo {
    let text: String
    
//    javaで言うところのコンストラクタ。インスタンス生成時に自動で呼ばれるメソッド
//    登録する際のdocDataが辞書型のため、取得する際には辞書型で取得する。辞書型はdocやつ。
    init(dic: [String: Any]){
        self.text = dic["text"] as! String
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    
    var memo: Memo? {
//        インスタンスを取得時に起動する
        didSet {
            print("memo?.text: ", memo?.text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var memos: [Memos] = []
//
//        Firebaseからデータを取得
        Firestore.firestore().collection("memos").document("qMq2O4HYGgww47m1C9So").getDocument { (snap, err) in
            if let err = err {
                fatalError("\(err)")
            }
//            登録したデータを取得
            guard let data = snap?.data() else { return }
            let memo = Memo.init(dic: data)
            self.textLabel.text = memo.text
            print(data)
        }
        
        var memos: [String] = getFirestoreData()
        
        Firestore.firestore().collection("memos").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
//                        ↓これではとれない
//                        let text = document.get("text") as! String
                        print(data)
                    }
                }
        }
        
        print("a")
        print(memos)
        print("b")


    }
    
    private func getFirestoreData() -> [String] {
        var memos = [String]()
        Firestore.firestore().collection("memos").getDocuments() { (querySnapshot, err) in
            if let err = err {
                fatalError("\(err)")
            } else {
                for document in querySnapshot!.documents {
                     let text = document.get("text") as! String
                     memos.append(text)
                }
            }
        }
        return memos
    }
    
    @IBAction func pushSaveButton(sender: UIStoryboardSegue){
        guard let senderVC = sender.source as? AddMemoViewController, let text:String = senderVC.textLabel.text else { return }
        self.textLabel.text = text
//        self.textLabel.text = senderVC.one
        
//        memosコレクションに新しくランダムなUIDをキーとしたドキュメントを作成するコード(追加)
        Firestore.firestore().collection("memos").document().setData(
            [
                "text": text
            ]
        )
    }
        
    
    @IBAction func addButton(_ sender: Any) {
        print("addButton")
        let storyboard = UIStoryboard(name: "AddMemo", bundle: nil)
        let addMemoViewController = storyboard.instantiateViewController(identifier: "AddNavigationController") as! UINavigationController
        self.present(addMemoViewController, animated: true)
    }
    

}

