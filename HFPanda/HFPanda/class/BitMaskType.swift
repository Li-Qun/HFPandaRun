//
//  BitMaskType.swift
//  HFPanda
//
//  Created by HF on 2018/3/8.
//  Copyright © 2018年 HF-Liqun. All rights reserved.
//



class BitMaskType {
    class var panda:UInt32 {
        return 1<<0   //二进制枚举
    }
    class var platform:UInt32 {
        return 1<<1   //二进制枚举
    }
    class var apple:UInt32 {
        return 1<<2   //二进制枚举
    }
    class var scene:UInt32 {
        return 1<<3   //二进制枚举
    }
    //每两种二进制位或运算结果唯一，所以使用二进制枚举
}
