//
//  UserTableViewCell.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 23/01/2020.
//  Copyright © 2020 UCarrot Software & Design. All rights reserved.
//

import UIKit

//custom created protocol to display prfileview
protocol UserTableViewCellDelegate {
    func didTapAvatarImage(indexPath: IndexPath)
}

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    var indexPath: IndexPath!
    var delegate: UserTableViewCellDelegate?
    
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tapGestureRecognizer.addTarget(self, action: #selector(self.avatarTap))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func generateCellWith(fUser: FUser, indexPath: IndexPath) {
        self.indexPath = indexPath
        
        self.fullNameLabel.text = fUser.fullname
        
        //use this function to return image from database
        if fUser.avatar != "" {
            imageFromData2(pictureData: fUser.avatar) { (avatarImage) in
                if avatarImage != nil {
                    self.avatarImageView.image = avatarImage!.circleMasked
                }
            }
        }
        
    }
    
    @objc func avatarTap() {
        
        delegate!.didTapAvatarImage(indexPath: indexPath)
        
    }

}
