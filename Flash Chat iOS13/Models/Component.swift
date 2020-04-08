//
//  Component.swift
//  Flash Chat iOS13
//
//  Created by 神野成紀 on 2020/04/06.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

struct Component {
     static let cellIdentifier = "ReusableCell"
       static let cellNibName = "MessageCell"
       static let registerSegue = "RegisterToChat"
       static let loginSegue = "LoginToChat"
       
       struct BrandColors {
           static let purple = "BrandPurple"
           static let lightPurple = "BrandLightPurple"
           static let blue = "BrandBlue"
           static let lighBlue = "BrandLightBlue"
       }
       
       struct FStore {
           static let collectionName = "messages"
           static let senderField = "sender"
           static let bodyField = "body"
           static let dateField = "date"
       }
    
}
