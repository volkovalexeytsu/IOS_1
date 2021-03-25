//
//  Bullet.swift
//  SpaceInvaders
//
//  Created by Admin on 21.03.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class Bullet: UIImageView {

    func setup() {
        let image: UIImage? = UIImage(named: "Bullet")
        self.contentMode = .redraw
        self.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

}
