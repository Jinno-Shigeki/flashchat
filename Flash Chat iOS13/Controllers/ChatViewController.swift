//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    let db = Firestore.firestore()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messageArray: [Message] = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        let appearence = UINavigationBarAppearance()
        appearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearence.backgroundColor = UIColor(named: "BrandBlue")
        
        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        
        tableView.register(UINib(nibName: Component.cellNibName, bundle: nil), forCellReuseIdentifier: Component.cellIdentifier)
        
        loadMessage()
    }
    
    func loadMessage(){
        db.collection(Component.FStore.collectionName)
            .order(by: Component.FStore.dateField)
            .addSnapshotListener{ (querySnapshot, error) in
            self.messageArray = []
            
            if let e = error{
                print("loading error!")
            }else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let messageSender = doc[Component.FStore.senderField] as? String , let messageBody = doc[Component.FStore.bodyField] as? String{
                            let newMesssage = Message(sender: messageSender, message: messageBody)
                            self.messageArray.append(newMesssage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexpath = IndexPath(row: self.messageArray.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexpath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(Component.FStore.collectionName)
                .addDocument(data: [Component.FStore.senderField: messageSender, Component.FStore.bodyField: messageBody, Component.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error{
                    print("error!\(e)")
                }else{
                    print("succsesful!")
                }
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
            }
        }
    }
    
    @IBAction func logOutBotton(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        navigationController?.popToRootViewController(animated: true)
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("error",signOutError)
        }
    }
}
//MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messageArray[indexPath.row]
        print(message)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Component.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = message.message
        
        if message.sender == Auth.auth().currentUser?.email{
            print(message.sender)
            cell.opponentView.isHidden = true
            cell.userImage.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: Component.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: Component.BrandColors.purple)
        }
        else{
            cell.opponentView.isHidden = false
            cell.userImage.isHidden = true
            cell.messageView.backgroundColor = UIColor(named: Component.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: Component.BrandColors.lightPurple)
        }
        return cell
    }
    
        
}


