//
//  API_Images.swift
//  Wiki-Info
//
//  Created by Sanket on 30/09/18.
//  Copyright © 2018 Developer Sanket. All rights reserved.
//

import Foundation
import UIKit

class API_Images {

    typealias updateImageView = (UIImage?,String, Int) -> ()
    var imageData : UIImage?
    var errorMessage = ""
    let defaultSession = URLSession(configuration: .default)

    var dataTask: URLSessionDataTask?


    func getProfileImage(pageId : Int, image_Url:String,completion: @escaping updateImageView ) {
        dataTask?.cancel()
        if(image_Url == "") {
            print("cannot proceed with empty image url")
            DispatchQueue.main.async {
                self.errorMessage = "Image url cannot be null"
                completion(self.imageData, self.errorMessage, pageId)
            }
            return
        }


        let url = image_Url
        print("\nurlforImage: \(url)")
        guard let Url = URL(string: url) else {print("auth URL Error"); return}
        var request = URLRequest(url:Url)

        request.httpMethod = "GET"

        dataTask = defaultSession.dataTask(with: request) { data, response, error in
            defer { self.dataTask = nil }
     //       print(self.dataTask?)
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse {
                print("responsecode= \(response.statusCode)")
                if(response.statusCode == 200) {
                    print("image data = \(data)")
                    self.updateImage(data)
                        DispatchQueue.main.async {
                            completion(self.imageData,self.errorMessage, pageId)
                            print(self.imageData as Any)


                        }
                }
            }
        }
        dataTask?.resume()
    }

    fileprivate func updateImage(_ data: Data){
        imageData = UIImage(data: data)

    }
}

