//
//  SGChatVC.swift
//  SGChatApp
//
//  Created by Shamkhal Guliyev on 25.09.2017.
//  Copyright © 2017 Shamkhal Guliyev. All rights reserved.
//

import UIKit

class SGChatVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionChat: UICollectionView!
    
    @IBOutlet weak var viewTypeText: UIView!
    @IBOutlet weak var txtFieldMessage: UITextField!
    @IBOutlet weak var viewTypeBottomConstraint: NSLayoutConstraint!
    
    var arrMessage: NSMutableArray = ["Hello", "Hi", "How may I help you?", "Question on my checking account", "What is the transfer fee?", "It was for two wire transfer you did during the month. I notice you have an avarage balance of $11,000 in you checking account. If you open a 2 year CD for $5,000 with us you can avoid all fees It was for two wire transfer you did during the month. I notice you have an avarage balance of $11,000 in you checking account. If you open a 2 year CD for $5,000 with us you can avoid all fees It was for two wire transfer you did during the month. I notice you have an avarage balance of $11,000 in you checking account. If you open a 2 year CD for $5,000 with us you can avoid all fees It was for two wire transfer you did during the month. I notice you have an avarage balance of $11,000 in you checking account. If you open a 2 year CD for $5,000 with us you can avoid all fees", "What is the transfer rate?", "Currently it is 4.25 %", "Sounds good. What do I have to do?", "I can open the account now and transfer $5,000. Is that what you would like to do?", "Yes", "I am sending you the web page so you can accept the terms of the new account. Anything else I can help you with?", "Thanks, I got it. That is all", "http://www.thebankurladdress.com/termsofnewaccount.php", "Thanks", "Thanks you for using our bank. We appreciate your business"]
    
    var arrFromMe: NSMutableArray = [true, false, false, true, true, false, true, false, true, false, true, false, true, false, true, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let indexPath = NSIndexPath(item: self.arrMessage.count - 1, section: 0)
        self.collectionChat.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: .UIKeyboardWillHide, object: nil)
        
        navigationItem.title = "shamxal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "right", style: .plain, target: self, action: #selector(handleRefresh))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "left", style: .plain, target: self, action: #selector(handleRefresh))
    }
    
    @objc func handleRefresh() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleKeyboard(notification: Notification) {
        
        let isShow = notification.name == .UIKeyboardWillShow
        let frame: CGRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect)!
        
        viewTypeBottomConstraint.constant = isShow ? frame.height : 0
        
        UIView.animate(withDuration: 0.0, animations: {
            self.view.layoutIfNeeded()
            
            let indexPath = NSIndexPath(item: self.arrMessage.count - 1, section: 0)
            self.collectionChat.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMessage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SGChatCell", for: indexPath) as! SGChatCell
        
        cell.reloadCell(chatText: arrMessage[indexPath.item] as! String, isFromMe: arrFromMe[indexPath.item] as! Bool, view: view)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if arrMessage.count > indexPath.item {
            
            let chatText = arrMessage[indexPath.item] as! String
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: chatText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
            
            return CGSize(width: view.frame.size.width, height: estimatedFrame.height + 18)
        }
        
        return CGSize(width: view.frame.size.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        txtFieldMessage.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    @IBAction func btnSendMessage(_ sender: Any) {
        
        if (txtFieldMessage.text?.characters.count)! > 0 {
            
            arrFromMe.add(true)
            arrMessage.add(txtFieldMessage.text ?? "")
//            arrMessage.add(txtFieldMessage.text ?? "")
//            arrFromMe.add(false)
            
            txtFieldMessage.text = nil
            collectionChat.reloadData()
            
            let item = arrMessage.count - 1
            let indexPath = NSIndexPath(item: item, section: 0)
            collectionChat.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
        }
    }
}
