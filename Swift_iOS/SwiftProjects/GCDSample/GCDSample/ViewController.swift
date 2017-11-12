//
//  ViewController.swift
//  GCDSample
//
//  Created by woowabrothers on 2017. 7. 24..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var manager = DataManager()
    var logoJson : Array<Dictionary<String,Any>> = []
    let notiKey = NSNotification.Name(rawValue: "dataGetComplete")
    let imgDownloadKey = NSNotification.Name(rawValue: "imgDownloadComplete")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPrefetchingEnabled = true
        collectionView.allowsMultipleSelection = true
        
        
        var doubleTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(didDoubleTapCollectionView(_:)))
        doubleTapGesture.numberOfTapsRequired = 2;
        collectionView.addGestureRecognizer(doubleTapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setJson(_:)), name: notiKey, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollectionView(_:)), name: imgDownloadKey, object: nil)
        
        manager.getJSONfromURL()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didDoubleTapCollectionView(_ sender: UIGestureRecognizer){
        
//        var mylayout = collectionView.layout
        print("더블탭")
    }

    
    func updateCollectionView(_ notification: NSNotification){
        
        if let title = notification.userInfo?["index"] as? String {
            DispatchQueue.main.async {
                let indexPath  = IndexPath(item: Int(title)! - 1, section : 0)
                self.collectionView.reloadItems(at: [indexPath])
            }
        }
        
    }
    
    
    func setJson(_ notification: NSNotification) {
        if let json = notification.userInfo?["json"] as? Array<Dictionary<String,Any>> {
            logoJson = json
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}



extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return logoJson.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
                                                         for: indexPath) as? CustomCell {
            
            if logoJson.count > 1 {
                let dicts = logoJson[indexPath.item]
                var imageurl = ""
                var title = ""
                for (key,value) in dicts{
                    
                    switch key {
                    case "image" : imageurl = (value as? String)!
                    case "title" : title = (value as? String)!
                    case "date" : break;
                    default : break;
                    }
                }
                
                let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
                
                let destURL = cacheDirectory.appendingPathComponent(String((indexPath.row + 1))+".png")
                
                let filemanager = FileManager()
                if filemanager.fileExists(atPath: destURL.path) == false {
                    DispatchQueue.global().async{
                        self.manager.downloadImagefromURL(urlstr: imageurl, title: title)
                    }
                }
                else{
                    cell.image.frame.size = CGSize(width: 128, height: 50)
                    cell.image.image = UIImage(contentsOfFile: destURL.path)
                    cell.image.contentMode = .scaleAspectFill
                }
                
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.2, animations: {
            selectedCell?.transform = CGAffineTransform(scaleX: 1.6,y: 1.6);
            selectedCell?.layer.zPosition = 1024;
        },completion: { (complete:Bool) in
            
        })
        
        selectedCell?.isSelected = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        
        
        UIView.animate(withDuration: 0.2, animations: {
            selectedCell?.transform = CGAffineTransform(scaleX: 1.0,y: 1.0);
            selectedCell?.layer.zPosition = 1;
        },completion: { (complete:Bool) in
        })
        
        selectedCell?.isSelected = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        
        if logoJson.count > 1 {
            
            for indexPath in indexPaths {
                let dicts = logoJson[indexPath.item]
                var imageurl = ""
                var title = ""
                for (key,value) in dicts{
                    
                    switch key {
                    case "image" : imageurl = (value as? String)!
                    case "title" : title = (value as? String)!
                    case "date" : break;
                    default : break;
                    }
                }
                
                let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
                
                let destURL = cacheDirectory.appendingPathComponent(String((indexPath.row + 1))+".png")
                
                let filemanager = FileManager()
                if filemanager.fileExists(atPath: destURL.path) == false {
                    DispatchQueue.global().async{
                        self.manager.downloadImagefromURL(urlstr: imageurl, title: title)
                    }
                }
                
            }
        }
        
    }
    
}

