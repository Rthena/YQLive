//
//  ClientManager.swift
//  Server
//
//  Created by Rthena on 2016/12/11.
//  Copyright © 2016年 Athena. All rights reserved.
//

import Cocoa

protocol ClientManagerDelegate : class {
    func sendMsgToClient(_ data : Data)
}

class ClientManager: NSObject {
    var tcpClient : TCPClient
    
    weak var delegate : ClientManagerDelegate?
    
    fileprivate var isClientConnected : Bool = false
    
    init(tcpClient : TCPClient) {
        self.tcpClient = tcpClient
    }
}


extension ClientManager {
    func startReadMsg() {
        isClientConnected = true
        while isClientConnected {
            if let lMsg = tcpClient.read(4) {
                // 1.读取长度的data
                let headData = Data(bytes: lMsg, count: 4)
                var length : Int = 0
                (headData as NSData).getBytes(&length, length: 4)
                
                // 2.读取类型
                guard let typeMsg = tcpClient.read(2) else {
                    return
                }
                let typeData = Data(bytes: typeMsg, count: 2)
                var type : Int = 0
                (typeData as NSData).getBytes(&type, length: 2)
                print(type)
                 
                // 2.根据长度, 读取真实消息
                guard let msg = tcpClient.read(length) else {
                    return
                }
                let data = Data(bytes: msg, count: length)
                
                /*
                switch type {
                case 0, 1:
                    let user = try! UserInfo.parseFrom(data: data)
                    print(user.name)
                    print(user.level)
                default:
                    print("未知类型")
                }
                */
                let totalData = headData + typeData + data
                delegate?.sendMsgToClient(totalData)
            } else {
                isClientConnected = false
                print("客户端断开了连接")
                tcpClient.close()
            }
        }
    }
}
