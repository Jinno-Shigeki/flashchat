//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by 神野成紀 on 2020/04/06.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var opponentView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        messageView.layer.cornerRadius = messageView.frame.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
