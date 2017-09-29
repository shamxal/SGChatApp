//
//  SGChatCell.swift
//  SGChatApp
//
//  Created by Shamkhal Guliyev on 25.09.2017.
//  Copyright © 2017 Shamkhal Guliyev. All rights reserved.
//

import UIKit

class SGChatCell: UICollectionViewCell {
    
    @IBOutlet weak var imgMe: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtViewChat: UITextView!
    @IBOutlet weak var imgChatBubble: UIImageView!
    
    static var imgLeftBubble = UIImage(named: "bubbleLeft")?.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    static var imgRightBubble = UIImage(named: "bubbleRight")?.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    
    override func awakeFromNib() {
        
        imgMe.layer.cornerRadius = 15
        imgMe.layer.masksToBounds = true
        imgProfile.layer.cornerRadius = 15
        imgProfile.layer.masksToBounds = true
        
        imgChatBubble.layer.cornerRadius = 15
        imgChatBubble.layer.masksToBounds = true
    }
    
    func reloadCell(chatText: String, isFromMe: Bool, view: UIView) {
        
        txtViewChat.text = chatText
        
        var imageBuuble: UIImage!
        let imageInsets: UIEdgeInsets = UIEdgeInsetsMake(22, 26, 22, 26)
        
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: chatText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
        
        if isFromMe == false {
            imgMe.isHidden = true
            imgProfile.isHidden = false
            
            txtViewChat.frame = CGRect(x: 48 + 6, y: 0, width: estimatedFrame.width + 14, height: estimatedFrame.height + 18)
            imgChatBubble.frame = CGRect(x: 48, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 18)
            
            imageBuuble = UIImage(named: "bubbleLeft")
            imgProfile.image = UIImage(named: "chatWoman")
            
        } else {
            imgMe.isHidden = false
            imgProfile.isHidden = true
            
            txtViewChat.frame = CGRect(x: view.frame.size.width - estimatedFrame.width - 16 - 13 - 40, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 15)
            imgChatBubble.frame = CGRect(x: view.frame.size.width - estimatedFrame.width - 16 - 20 - 40, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 15)
            
            imgMe.image = UIImage(named: "chatMan")
            imageBuuble = UIImage(named: "bubbleRight")
        }
        
        imageBuuble = imageBuuble.resizableImage(withCapInsets: imageInsets)
        imgChatBubble.image = imageBuuble
    }
    
}
