//
//  HFPanda.swift
//  HFPanda
//
//  Created by HF on 2018/1/31.
//  Copyright © 2018年 HF-Liqun. All rights reserved.
//

import Foundation
import SpriteKit

//创建一个精灵主角:熊猫
//定义纹理：跑，跳，滚动等动作动画
class HFPanda: SKSpriteNode {
    //纹理
    let runAtlas = SKTextureAtlas.init(named:"run.atlas")
    let jumpAtlas = SKTextureAtlas.init(named:"jump.atlas")
    let rollAtlas = SKTextureAtlas.init(named: "roll.atlas")
    //存储纹理实例数组
    let runFrame = [SKTexture]()
    let jumpFrame = [SKTexture]()
    let rollFrame = [SKTexture]()
    //
    //指令构造函数
    //初始化时候默认展示图像
    init () {
        let texture = runAtlas.textureNamed("panda_run_01.png")
        let size = texture.size()
        //父类构造函数必实现
        super.init(texture: texture, color: UIColor.white, size: size)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
