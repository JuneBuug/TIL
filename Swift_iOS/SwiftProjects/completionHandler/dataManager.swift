//
//  dataManager.swift
//  completionHandler
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation


class DataManager{
    
    let notiKey = NSNotification.Name(rawValue: "dataGetComplete")
    

    init(){
        
    
    }
    
    func getJSONfromURL(){
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with:
        URL(string: "")!) {
            (data, response, error) in
            
            if error != nil {
                print("에러가 발생했습니다.")
            }else{
                print("data는 \(data!)")
                print("response는 \(response!)")
                NotificationCenter.default.post(name: self.notiKey, object: nil)
            }
            }.resume()
    }
    
    func postJSONtoWebhook(){
        
        let json : [String: String] = ["text": "준킴 웹훅 스위프트 훅훅", "icon_url":"http://emojis.slackmojis.com/emojis/images/1450451598/168/doge2.png?1450451598", "username": "준키미"]
        // 보내고자하는 데이터
        
        let url = URL(string:"")
        // 데이터를 보낼 주소
        var request = URLRequest(url: url!)
        // 그 주소에 대한 요청
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])
        // 보낼 데이터를 json으로 묶어서 보내주겠다
        
         URLSession(configuration: URLSessionConfiguration.default).dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print(error!)
            }else{
                print(data!)
                print(response!)
            }
        }.resume()
    }
    
    func downloadImagefromURL(url : URL)  {
        let manager = FileManager()
        URLSession(configuration: URLSessionConfiguration.default).downloadTask(with: url){
            url, response,error in
            
            if error != nil {
                print(error!)
            }else{
//                try? manager.copyItem(atPath: (url?.absoluteString)!, toPath: (Bundle.main.url(forResource: "Cache", withExtension: nil)?.absoluteString)!)
                
//                print(url!)
//                print(response!)
            }
        }.resume()
        
    }
}
