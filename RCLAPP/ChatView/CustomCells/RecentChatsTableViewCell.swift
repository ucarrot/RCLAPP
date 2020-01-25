//
//  RecentChatsTableViewCell.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 25/01/2020.
//  Copyright © 2020 UCarrot Software & Design. All rights reserved.
//

import UIKit

//custom created protocol to display prfileview
protocol RecentChatsTableViewCellDelegate {
    func didTapAvatarImage(indexPath: IndexPath)
}

class RecentChatsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var messageCounterLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var messageCounterBackground: UIView!
    
    
    var indexPath: IndexPath!
    
    
    let tapGesture = UITapGestureRecognizer()
    var delegate: RecentChatsTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //make nice round
        messageCounterBackground.layer.cornerRadius = messageCounterBackground.frame.width / 2
        
        tapGesture.addTarget(self, action: #selector(self.avatarTap))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGesture)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: Generate Cell
    
    func generateCell(recentChat: NSDictionary, indexPath: IndexPath) {
        
        self.indexPath = indexPath
        
        self.nameLabel.text = recentChat[kWITHUSERFULLNAME] as? String
        self.lastMessageLabel.text = recentChat[kLASTMESSAGE] as? String
        self.messageCounterLabel.text = recentChat[kCOUNTER] as? String
        //image avatar
        if let avatarString = recentChat[kAVATAR] {
            imageFromData(pictureData: avatarString as! String) { (avatarImage) in
                
                if avatarImage != nil {
                    self.avatarImageView.image = avatarImage!.circleMasked
                }
            }
        }
        //msg counter
        if recentChat[kCOUNTER] as! Int != 0 {
            self.messageCounterLabel.text = "\(recentChat[kCOUNTER] as! Int)"
            self.messageCounterBackground.isHidden = false
            self.messageCounterLabel.isHidden = false
        } else {
            self.messageCounterBackground.isHidden = true
            self.messageCounterLabel.isHidden = true
        }
        
        //date
        var date: Date!
        
        if let created = recentChat[kDATE] {
            if (created as! String).count != 14 {
                date = Date()
            }else {
                date = dateFormatter().date(from: created as! String)!
            }
        }else {
            date = Date()
        }
        
        self.dateLabel.text = timeElapsed(date: date)
        
    }
    
    @objc func avatarTap() {
        
        print("avatar tap \(indexPath)")
        delegate?.didTapAvatarImage(indexPath: indexPath)
    }

}
