//
//  ViewController.swift
//  PlayingVideoInTableViewcell
//
//  Created by chaitanya on 15/09/22.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var jsonData = [Category]()
    var avPlayercontrollerView = AVPlayerViewController()
    var playerView:AVPlayer?

    @IBOutlet weak var videoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewcell()
        
        //MARK: - Method Calling
        fetchjsonData { result in
            self.jsonData = result
            
            DispatchQueue.main.async {
                self.videoTableView.reloadData()
            }
        }
    }
    
    
    func registerTableViewcell(){
        
        videoTableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
    }
    
    
    func fetchjsonData(handler: @escaping (_ result:[Category]) -> (Void)) {
        guard let filelocation = Bundle.main.url(forResource: "simple", withExtension: "json") else {return}
        
        do {
           let data = try Data(contentsOf: filelocation)
           let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            print(json)
            
            let decoder = try JSONDecoder().decode(JsonModel.self, from: data)
            print(decoder)
            // Clousure calling
            handler(decoder.categories)
            
        }catch {
            print("Parsing Error")
        }
    }


}


extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData[section].videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        let videoData = jsonData[indexPath.section].videos[indexPath.row]
        cell.videoThumNail.loadImageUsingCache(withUrl: videoData.thumb)
        cell.videoTitle.text = videoData.title
        
        let customSelection = UIView()
        customSelection.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.selectedBackgroundView = customSelection
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoData  = jsonData[indexPath.section].videos[indexPath.row]
        avvideo(url: videoData.sources)
    }
    
    func avvideo(url:String){
        guard let url = URL(string: url) else {return}
        self.playerView = AVPlayer(url: url)
        playerView?.play()
        avPlayercontrollerView.player = playerView
        present(avPlayercontrollerView, animated: true, completion: nil)
        
    }
}
