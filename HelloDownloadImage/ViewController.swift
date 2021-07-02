//
//  ViewController.swift
//  HelloDownloadImage
//
//  Created by Sophia Wang on 2021/4/3.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    var session: URLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = URLSession(configuration: .default)
        let imageAddress = "https://store.storeimages.cdn-apple.com/8567/as-images.apple.com/is/MGT33ref_VW_34FR+watch-44-alum-gold-nc-se_VW_34FR_WF_CO_GEO_JP?wid=750&hei=712&trim=1,0&fmt=p-jpg&qlt=80&op_usm=0.5,0.5&.v=1611115355000,1604793308000"
        if let imageURL = URL(string: imageAddress){
            /*
            let task = session?.dataTask(with: imageURL, completionHandler: {
                (data, response, error) in
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                if let loadedData = data{
                    let loadedImage = UIImage(data: loadedData)
                    DispatchQueue.main.async {
                        self.myImageView.image = loadedImage
                    }
                }
            })
            task?.resume()
            */
            
            let newTask = session?.downloadTask(with: imageURL, completionHandler: {
                (url, response, error) in
                if error != nil{
                    //如果沒有網路的時候
                    let erroCode = (error!as NSError).code
                    if erroCode == -1009{
                        print("no internet connection")
                    }else{
                        print(error!.localizedDescription)
                    }
                    return
                }
                if let loadedURL = url{
                    do{
                        let loadedImage = UIImage(data: try Data(contentsOf: loadedURL))
                        DispatchQueue.main.async {
                            self.myImageView.image = loadedImage
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            })
            newTask?.resume()
     }
  }

}
