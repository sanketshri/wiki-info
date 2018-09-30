//
//  ViewController.swift
//  Wiki-Info
//
//  Created by Sanket on 29/09/18.
//  Copyright © 2018 Developer Sanket. All rights reserved.
//

import UIKit

class Main_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let apiService = API()
    let apiImageService = API_Images()
    var pages:[Pages]?
    var terms:Terms?
    var selectedPagetId:Int?
    let resultCell = Result_Cell()

    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var result_TalbleVC: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        result_TalbleVC.rowHeight = UITableView.automaticDimension
        result_TalbleVC.estimatedRowHeight = 100
//        result_TalbleVC.rowHeight
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    
    func getResult(searchKeyword:String){
        apiService.getSearchResult(searchKeyword: searchKeyword) { (results, error) in
            if results != nil{
                print(results as Any)
                self.pages = results?.pages
            }
            self.result_TalbleVC.reloadData()
        }

    }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if pages != nil{
        return (pages?.count)!
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = result_TalbleVC.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Result_Cell
        cell.tittle_Label.text = pages![indexPath.row].title
        cell.detail_Label.text = pages![indexPath.row].terms?.description?[0]
        if(pages![indexPath.row].thumbnail != nil && pages![indexPath.row].thumbnail?.source != nil) {
            cell.no_Image_Label.isHidden = false
            cell.no_Image_Label.text = "Loading..."
            cell.imageView?.image = nil
            cell.imageView?.isHidden = true
                // call api for the given source path and set in imageview
            API_Images().getProfileImage(pageId : pages![indexPath.row].pageid!, image_Url: ((pages?[indexPath.row].thumbnail?.source)!)) { (result_image, errorMessage, forPageId) in
                    if (result_image != nil && forPageId == self.pages![indexPath.row].pageid!) {
                        print("loading image for pageId= \(forPageId) index= \(indexPath.row)"  )
                        cell.imageView?.image = result_image
                        cell.imageView?.isHidden = false
                        cell.no_Image_Label.isHidden = true
                    } else {
                        //cell.imageView?.image = UIImage(named: "no-image")
                        cell.imageView?.image = nil
                        cell.imageView?.isHidden = true
                        cell.no_Image_Label.isHidden = false
                        cell.no_Image_Label.text = "No Image Available"
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false

                    }

            }
        }else{
            //cell.imageView?.image = UIImage(named: "no-image")
            cell.imageView?.image = nil
            cell.imageView?.isHidden = true
            cell.no_Image_Label.isHidden = false
            cell.no_Image_Label.text = "No Image Available"
            UIApplication.shared.isNetworkActivityIndicatorVisible = false

        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPagetId = pages?[indexPath.row].pageid
        performSegue(withIdentifier: "toDetailVC", sender: self)

    }
}



extension Main_VC:UISearchBarDelegate{
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        pages = nil
        result_TalbleVC.reloadData()
        getResult(searchKeyword:searchBar.text!)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searached Button clicked")
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        pages = nil
        result_TalbleVC.reloadData()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"{
            let destination = segue.destination as! Detail_VC
            destination.pageId = selectedPagetId
        }
    }
}
