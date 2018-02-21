//
//  ViewController.swift
//  pod-test
//
//  Created by Marcin Hajdukiewicz on 18.02.2018.
//  Copyright © 2018 Marcin Hajdukiewicz. All rights reserved.
//

import UIKit
import MJPEGStreamLib
import Networking

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    @IBAction func postButton(_ sender: Any) {
        let networking = Networking(baseURL: "http://192.168.10.206")
        networking.post("/post_mesage", parameters: ["username" : "jameson", "password" : "secret"]) { result in
            /*
             {
             "json" : {
             "username" : "jameson",
             "password" : "secret"
             },
             "url" : "http://httpbin.org/post",
             "data" : "{"password" : "secret","username" : "jameson"}",
             "headers" : {
             "Accept" : "application/json",
             "Content-Type" : "application/json",
             "Host" : "httpbin.org",
             "Content-Length" : "44",
             "Accept-Language" : "en-us"
             }
             }
             */
        }
    }
    
    
    
    
    @IBAction func buttonSend(_ sender: Any) {
        
        let networking = Networking(baseURL: "http://192.168.10.206")
        networking.get("/get_message") { result in
            switch result {
            case .success(let response):
                let json = response.dictionaryBody
            // Do something with JSON, you can also get arrayBody
            case .failure(let response):
                // Handle error
                return
            }
        }
    }
    
    var stream: MJPEGStreamLib!
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the ImageView to the stream object
        stream = MJPEGStreamLib(imageView: imageView)
        // Start Loading Indicator
        stream.didStartLoading = { [unowned self] in
            self.loadingIndicator.startAnimating()
        }
        // Stop Loading Indicator
        stream.didFinishLoading = { [unowned self] in
            self.loadingIndicator.stopAnimating()
        }
        
        // Your stream url should be here !
        let url = URL(string: "http://root:hajko@192.168.10.13/axis-cgi/mjpg/video.cgi?")
        stream.contentURL = url
        stream.play() // Play the stream
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Make the Status Bar Light/Dark Content for this View
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
}

