//
//  DetailVideoViewController.swift
//  YouWatch
//
//  Created by Родион Баглай on 23.05.18.
//  Copyright © 2018 Родион Баглай. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class DetailVideoViewController: UITableViewController {
  
    static let storyboardIndentifier: String = "DetailVideoViewController"
    
    @IBOutlet private weak var videoView: UIView!
    @IBOutlet private weak var videoWebView: UIWebView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var publishLabel: UILabel!
    @IBOutlet private weak var chanelTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var context: Context?
    var videoInfo: DetailInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLabel()
        let request = try? RequestContentProvider.loadVideo((videoInfo?.id.videoId)!).asURLRequest()
        videoWebView.loadRequest(request!)
    }
}

//MARK:- UINavigationBar
extension DetailVideoViewController {
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = videoInfo?.snippet.title
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension DetailVideoViewController {
    
    private func setupLabel() {
        titleLabel?.text = videoInfo?.snippet.title
        chanelTitleLabel?.text = videoInfo?.snippet.channelTitle
        
        chanelTitleLabel.text =  videoInfo?.snippet.channelTitle
        descriptionLabel?.text = videoInfo?.snippet.description
    }
}
