//
//  DataManager.swift
//  GCDSample
//
//  Created by woowabrothers on 2017. 7. 24..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation


class DataManager {
    
    var parsedJson : Array<Dictionary<String,Any>> = []

    let notiKey = NSNotification.Name(rawValue: "dataGetComplete")
    let imgDownloadKey = NSNotification.Name(rawValue: "imgDownloadComplete")
    
    func getJSONfromURL(){
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with:
        URL(string: "http://125.209.194.123/doodle.php")!) {
            (data, response, error) in
            
            if error != nil {
                print("에러가 발생했습니다.")
            }else{
                
           self.parseJson(data: data!)
            }
            
            }.resume()
    }
    

    func parseJson(data: Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            if let array = json as? [Any] {
                // json is an array
                for object in array {
                    parsedJson.append(object as! [String : Any])
                }
                NotificationCenter.default.post(name: self.notiKey, object: nil, userInfo : ["json": parsedJson])
            } else {
                print("JSON is invalid")
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    func downloadImagefromURL(urlstr : String, title: String)  {
        
        let url = URL(string: urlstr)!
        let manager = FileManager()
        URLSession(configuration: URLSessionConfiguration.default).downloadTask(with: url){
            url, response,error in
            
            if error != nil {
                print(error!)
            }else{
                
                let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
                
                print("현재경로 \(url!.path)")
                print("cache경로 \(cacheDirectory.path)")
                
                let destURL = cacheDirectory.appendingPathComponent(title+".png")
                // response 의 파일 이름을 붙여서 최종 복사할 파일명까지 나오게한다
                
                if manager.fileExists(atPath: destURL.path) == false {
                    do {
                        try manager.moveItem(atPath: url!.path, toPath: destURL.path)
                        NotificationCenter.default.post(name: self.imgDownloadKey, object: nil, userInfo : ["index": title])
                    } catch let error {
                        print("Failed moving directory, \(error)")
                    }
                }
            }
            }.resume()
    }
    
   



}
