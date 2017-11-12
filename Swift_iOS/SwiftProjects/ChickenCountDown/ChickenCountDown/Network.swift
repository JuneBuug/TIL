//
//  Network.swift
//  ChickenCountDown
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation


class Network {
    
    
    func dataPost(phonenumber: String, randNumber : String)  {
        
        let json : [String: String] = ["text": randNumber, "icon_url":"http://emojis.slackmojis.com/emojis/images/1450451598/168/doge2.png?1450451598", "username": phonenumber]
        // 보내고자하는 데이터
        
        let url = URL(string:"https://hooks.slack.com/services/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")
        // 데이터를 보낼 주소
        var request = URLRequest(url: url!)
        // 그 주소에 대한 요청
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])
        // 보낼 데이터를 json으로 묶어서 보내주겠다
        
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: request as URLRequest) {
            data, response, error  in
            
            if error != nil {
            }else{
                NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "postSuccess"), object: nil)
            }
        }.resume()

    }
}
