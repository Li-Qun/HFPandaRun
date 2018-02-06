//
//  Platform.swift
//  HFPanda
//
//  Created by HF on 2018/2/6.
//  Copyright © 2018年 HF-Liqun. All rights reserved.
//

import SpriteKit

class Platform:SKNode {
    var width  = 0.0
    var height = 10.0
    
    //创建平台函数
    //参数是一个平台数组,平台数组包括左中右三种图片，中间的图片数量大于等于0个，中间图片数越长，平台长度越长
    func onCreatePlatform(spriteArray:[SKSpriteNode]) {
        for childPlatform in spriteArray {
            childPlatform.position.x = CGFloat(self.width)
            self.addChild(childPlatform)
            self.width = Double(childPlatform.position.x + childPlatform.size.width)
        }
    }
}
