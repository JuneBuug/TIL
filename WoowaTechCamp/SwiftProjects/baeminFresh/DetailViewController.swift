//
//  DetailViewController.swift
//  baeminFresh
//
//  Created by woowabrothers on 2017. 7. 19..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var upperImages: UIScrollView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var shippingInfo: UILabel!
    @IBOutlet weak var shippingFee: UILabel!
    
    let detailnotiKey = NSNotification.Name(rawValue: "detailJsonComplete")

    
    // 그대로 dictionary로 주는게 아니라 객체로 만들어서 주는 걸 권장 
    var detailJson : Dictionary<String,Any> = [:]

    let network = Network()
    
    var hashfromMaster: String? {
        didSet {
            // 데이터를 불러온다.
            loadDetailData()
        }
    }
    
    var titlefromMaster : String? {
        didSet{
            
        }
    }
    
    func loadDetailData(){
        
        if hashfromMaster != nil {
            network.alamoGetJsonfromURLforDetail(url: "http://52.78.212.27:8080/woowa/detail/"+hashfromMaster!, filename: "detail")
        }
    }
    
    override func viewDidLoad() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(processJson(_:)), name: detailnotiKey, object: nil)
        super.viewDidLoad()
        
        productTitle.font = UIFont.boldSystemFont(ofSize: 18.0)
        // Do any additional setup after loading the view.
    }

    
    func processJson(_ notification: NSNotification) {
        
        if let json = notification.userInfo?["detail"] as? Dictionary<String,Any> {
            detailJson = json
            setDatatoView(json: detailJson)
        }
    }
    
    func setDatatoView(json : Dictionary<String,Any>){
        
        for (key, value) in json {
            switch key{
            case "delivery_info" : shippingInfo.text = value as? String
            case  "point" : point.text = value as? String
            case "delivery_fee" : shippingFee.text = value as? String
            case "product_description" : productDesc.text = value as? String
            case "prices" :
                guard let prices = value as? [String] else{
                    break
                };
                if prices.count == 2 {
                   price.text = prices[1]
                }else{
                    price.text = prices[0]
                }
//            case "top_image" :
//               let url = URL(string: (value as? String)!);
//               self.mainImage.af_setImage(withURL: url!)
            case  "thumb_images" :
                guard let images = value as? [String] else{
                    break
                };
                
                let imageViewWidth = upperImages.frame.size.width;
                let imageViewHeight = upperImages.frame.size.height;
                var xPosition:CGFloat = 0;
                var scrollViewSize:CGFloat=0;
                
                
                for image in images {
                    let url = URL(string: (image as? String)!);
                    let myImageView:UIImageView = UIImageView()
                    myImageView.af_setImage(withURL: url!)
                    myImageView.contentMode = .center
                    
                    myImageView.frame.size.width = imageViewWidth
                    myImageView.frame.size.height = imageViewHeight
                    myImageView.frame.origin.x = xPosition
                    myImageView.frame.origin.y = -65
                    
                    upperImages.addSubview(myImageView)
                    xPosition += upperImages.frame.size.width
                    scrollViewSize += imageViewWidth
                };
                upperImages.isPagingEnabled = true
                upperImages.contentSize = CGSize(width: scrollViewSize, height: 1);
                
            default : break
            }
        }
        productTitle.text = titlefromMaster
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
