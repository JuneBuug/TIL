//
//  Network.swift
//  baeminFresh
//
//  Created by woowabrothers on 2017. 7. 19..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class Network {
    
    
    var mainJson : Array<Dictionary<String,Any>> = []
    var courseJson : Array<Dictionary<String,Any>> = []
    var sideJson : Array<Dictionary<String,Any>> = []
    var soupJson : Array<Dictionary<String,Any>> = []
    var detailJson : Dictionary<String,Any> = [:]
    
    init(){
    }
    
    let notiKey = NSNotification.Name(rawValue: "dataGetComplete")
    let imageKey = NSNotification.Name(rawValue: "imageDownloadComplete")
    let detailnotiKey = NSNotification.Name(rawValue: "detailJsonComplete")
    
    func alamoGetJsonfromURL(url : String, filename: String){
        
        Alamofire.request(url).responseJSON { response in
            
            if let json = response.result.value{
                
                var dict = [String : Any]()
                
                if let array = json as? [Any]{
                    
                    
                    for object in array {
                        switch filename {
                        case "main" : self.mainJson.append(object as! [String : Any]); dict = [filename: self.mainJson];
                        
                        for dic in self.mainJson{
                            for (key, value) in dic {
                                if key.contains("image"){
                                    self.downloadImg(url: value as! String, hash: dic["detail_hash"] as! String)
                                }
                            }
                            }
                            
                        case "course" : self.courseJson.append(object as! [String : Any]); dict = [filename: self.courseJson];
                        
                        for dic in self.courseJson{
                            for (key, value) in dic {
                                if key.contains("image"){
                                    self.downloadImg(url: value as! String, hash: dic["detail_hash"] as! String)
                                }
                            }
                            }
                        case "side" : self.sideJson.append(object as! [String : Any]); dict = [filename: self.sideJson];
                            
                        for dic in self.sideJson{
                            for (key, value) in dic {
                                if key.contains("image"){
                                    self.downloadImg(url: value as! String, hash: dic["detail_hash"] as! String)
                                }
                            }
                            }
                        case "soup" : self.soupJson.append(object as! [String : Any]); dict = [filename: self.soupJson];
                            
                        for dic in self.soupJson{
                            for (key, value) in dic {
                                if key.contains("image"){
                                    self.downloadImg(url: value as! String, hash: dic["detail_hash"] as! String)
                                }
                            }
                            }
                            
                        default : return
                            
                        }
                        
                        NotificationCenter.default.post(name: self.notiKey, object: nil, userInfo: dict)
                    }
                    
                }
            }
        }
    }
    
    func alamoGetJsonfromURLforDetail(url : String, filename: String){
        Alamofire.request(url).responseJSON { response in
    
            if let json = response.result.value {
               
                if let dictionary = json as? [String: Any] {
                    if let data = dictionary["data"] as? [String : Any] {
                        self.detailJson = data
                        NotificationCenter.default.post(name: self.detailnotiKey, object: nil, userInfo: ["detail": self.detailJson])
                    }
                    
                }
    }
 }
}
    
    func takeLastItemOfUrl(url : String ) -> String {
        let filename = url.components(separatedBy: "/").last
                        
        return filename!
    }
    
    
    
    // DEPRECATED
    // model이 let constant라고해서 inout붙이고 &로 포인터 넘겨줌
    func parseJson(model : inout Array<Dictionary<String,Any>>, filename: String) {
        do {
            if let file = Bundle.main.url(forResource: filename, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let array = json as? [Any] {
                    // json is an array
                    for object in array {
                        model.append(object as! [String : Any])
                    }
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
                        
    func downloadImg(url : String, hash: String)  {
        
        //        var image = UIImage()
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(hash + ".jpg")
                print(fileURL)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(url, to: destination).response { response in
            if response.error == nil, let imagePath = response.destinationURL?.path {
                //                image = UIImage(contentsOfFile: imagePath)!
                //                cell.mainImageView  = UIImageView(image: image)
                NotificationCenter.default.post(name: self.imageKey, object: nil)
            }
        }
    }
       
     
    
}


