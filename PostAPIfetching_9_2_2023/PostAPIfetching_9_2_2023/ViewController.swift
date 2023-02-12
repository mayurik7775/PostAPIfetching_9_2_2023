//
//  ViewController.swift
//  PostAPIfetching_9_2_2023
//
//  Created by Mac on 08/02/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        fecthingApi()
        tableViewDelegateAndDataSource()
    }
    func tableViewDelegateAndDataSource(){
        postTableView.delegate = self
        postTableView.dataSource = self
    }
    func registerXib(){
        let uiNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        self.postTableView.register(uiNib, forCellReuseIdentifier: "PostTableViewCell")
    }
    func fecthingApi(){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        var session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request) {
            data , response , error in
            
            print("Data -- \(data)")
            print("Response -- \(response)")
            print("Error--\(error)")
            var getJSONObject = try! JSONSerialization.jsonObject(with: data!) as! [[String: Any]]
            
            for dictionary in getJSONObject{
                let eachDictionary = dictionary as [String : Any]
                let postId = eachDictionary["id"] as! Int
                let postTitle = eachDictionary["title"] as! String
                let postBody = eachDictionary["body"] as! String
                
                let newPostObject = Post(id:postId, title: postTitle, body: postBody)
                
                self.posts.append(newPostObject)
            }
        DispatchQueue.main.async {
            self.postTableView.reloadData()
        }
    }
        dataTask.resume()
}
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 200
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.postTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        var eachPost = posts[indexPath.row]
        cell.idlbl.text = "\(eachPost.id)"
        cell.titlelbl.text = eachPost.title
        cell.bodylbl.text = eachPost.body
        return cell
    }

}
