//
//  HFPanda.swift
//  HFPanda
//
//  Created by HF on 2018/1/31.
//  Copyright © 2018年 HF-Liqun. All rights reserved.
//

import Foundation
import SpriteKit

enum Status:Int {
    case run = 1,
    jump,
    jump2,
    roll
}
//创建一个精灵主角:熊猫
//定义纹理：跑，跳，滚动等动作动画
class HFPanda: SKSpriteNode {
    //纹理
    let runAtlas = SKTextureAtlas.init(named:"run.atlas")
    let jumpAtlas = SKTextureAtlas.init(named:"jump.atlas")
    let rollAtlas = SKTextureAtlas.init(named: "roll.atlas")
    //存储纹理实例数组
    var runFrame = [SKTexture]()
    var jumpFrame = [SKTexture]()
    var rollFrame = [SKTexture]()
    //
    //初始化动作状态
    var status = Status.run
    //指令构造函数
    //初始化时候默认展示图像
    init () {
        let texture = runAtlas.textureNamed("panda_run_01.png")
        let size = texture.size()
        //父类构造函数必实现
        super.init(texture: texture, color: UIColor.white, size: size)

        //跑
        for i in 1...runAtlas.textureNames.count {
            let tempName = String(format: "panda_run_%.2d", i) //panda_run_01
            let runTexture = runAtlas.textureNamed(tempName)
            runFrame.append(runTexture)
        }
        //跳
        for i in 1...jumpAtlas.textureNames.count {
            let tempName = String(format: "panda_jump_%.2d", i) //panda_jump_01
            let jumpTexture = jumpAtlas.textureNamed(tempName)
            jumpFrame.append(jumpTexture)
        }
        //滚
        for i in 1...rollAtlas.textureNames.count {
            let tempName = String(format: "panda_roll_%.2d", i) //panda_roll_01
            let rollTexture = rollAtlas.textureNamed(tempName)
            rollFrame.append(rollTexture)
        }
        
        //panda碰撞检测
        self.physicsBody = SKPhysicsBody.init(rectangleOf: texture.size()) //设置碰撞体和物理碰撞检测范围
        self.physicsBody?.categoryBitMask = BitMaskType.panda//设置碰撞检测标识
        self.physicsBody?.isDynamic = true//碰撞结束后 要弹开
        self.physicsBody?.allowsRotation = false//碰撞后不产生角度变化eg碰撞和翻滚都不需要产生角度变化
        //摩擦力设置为0
        self.physicsBody?.restitution = 0 //碰撞后不会被黏住
        //设置关联碰撞 场景
        self.physicsBody?.contactTestBitMask = BitMaskType.scene | BitMaskType.platform
        self.physicsBody?.collisionBitMask = BitMaskType.platform //实际产生作用
        self.zPosition = 20
        //类实例化时候就开始跑
        run()
    }
    
    //跑函数
    func run () {
        //初始化
        self.removeAllActions()
        self.status = .run //因为初始化过 所以直接使用枚举后缀
        //执行跑的动作：无限循环的纹理动作 每一帧切换动作的时间为0.05s
        self.run(SKAction.repeatForever(SKAction.animate(with: runFrame, timePerFrame: 0.05)))
    }
    // 跳
    func jump () {
        self.removeAllActions()
        self.status = .jump
        //跳只跳一次
        self.run(SKAction.animate(with: jumpFrame, timePerFrame: 0.05))
    }
    //打滚
    func roll () {
        self.removeAllActions()
        self.status = .roll
        //滚动后继续跑
        self.run(SKAction.animate(with: rollFrame, timePerFrame: 0.05)) {
            self.run()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
