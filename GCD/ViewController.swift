//
//  ViewController.swift
//  GCD
//
//  Created by David Svensson on 2022-12-08.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imageURLstring = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Felis_catus-cat_on_snow.jpg/2560px-Felis_catus-cat_on_snow.jpg"
    
    var inactiveQueue : DispatchQueue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // simpleQueue()
       // queuesWithPriority()
       // concurrentQueue()
        
       // inactiveQueue?.activate()
        
        showImage()
        
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //
    //        for i in 0...1000000 {
    //            print("hej")
    //        }
    //
    //    }
    
    
    func simpleQueue() {
        
        let queue = DispatchQueue(label: "queue1")
        
        
        queue.async {
            for i in 0...10 {
                print("🟢 \(i)")
            }
        }
        
        
        for i in 0...10 {
            print("🔴 \(i)")
        }
        
        
    }
    
    
    func queuesWithPriority() {
        let queue1 = DispatchQueue(label: "queue1", qos: .userInitiated)
        let queue2 = DispatchQueue(label: "queue2", qos: .utility)
        
        queue1.async {
            for i in 1...10 {
                print("🔴 \(i)")
                
            }
        }
        
        queue2.async {
            for i in 1...10 {
                print("🟢 \(i)")
                
            }
        }
        
        for i in 1...10 {
            print("🟡 \(i)")
            
        }
    }
    
    func concurrentQueue() {
        let queue = DispatchQueue(label: "queue", qos: .utility,
                                  attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue = queue
        
        queue.async {
            for i in 1...10 {
                print("🟡 \(i)")
                
            }
        }
        
        queue.async {
            for i in 1...10 {
                print("🟢 \(i)")
                
            }
        }
        
        for i in 1...10 {
            print("🔴 \(i)")
            
        }
    }
    
    func showImage() {
        
        //imageView.image = imageURL
        
        guard let imageUrl = URL(string: imageURLstring) else {return}
        
        
        
        
        
        
        
        
        let session = URLSession(configuration: .default).dataTask(with: imageUrl) {
            imageData, response, error in
            
            
            if let data = imageData {
                print("Bild nedladdad: 💙")
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
                
            }
        }
        
        session.resume()
        
        print("nedladdning startar 💚")
        
        
    }
    
    
    
    
    
}

