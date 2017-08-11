//
//  ViewController.swift
//  Client
//
//  Created by Rthena on 2016/12/11.
//  Copyright © 2016年 Athena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate lazy var socket : YQSocket = YQSocket(addr: "192.168.31.109", port: 7878)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if socket.connectServer() {
            socket.startReadMsg()
//            socket.delegate = self
        }
    }
    
    /*
     进入房间 = 0
     离开房间 = 1
     文本 = 2
     礼物 = 3
    */
    
    @IBAction func joinRoom() {
        socket.sendJoinRoom()
    }
    
    @IBAction func leaveRoom() {
        socket.sendLeaveRoom()
    }
    
    @IBAction func sendText() {
        socket.sendTextMsg(message: "这是一个文本消息")
    }
    
    @IBAction func sendGift() {
        socket.sendGiftMsg(giftName: "火箭", giftURL: "http://www.baidu.com", giftCount: 1000)
    }
    
}

