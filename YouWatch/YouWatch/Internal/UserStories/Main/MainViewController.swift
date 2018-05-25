
import UIKit
import Foundation

class ViewController: UIViewController {
    
    private static let usersCellReuseID: String = "reusableCell"
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var viewMore: UIView!
    
    private var searchController: UISearchController?
    private var refreshControl:UIRefreshControl!
    private var context: Context?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = Context.createStorageContext()
        setupNavigationBar()
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return context?.videoManager.videos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.usersCellReuseID, for: indexPath) as! VideoInfoTableViewCell
        if let video = context?.videoManager.videos[indexPath.row] {
            let urlString = video.snippet.thumbnails.high.url
            guard let url  = URL(string: urlString) else {
                return cell
            }
            // DispatchQueue.main.async {
            cell.titleLabel?.text = video.snippet.title
            cell.descriptionLabel?.text = video.snippet.description
            cell.thumbnails.downloadImageFrom(link: url.absoluteString, contentMode: UIViewContentMode.scaleToFill)
            //  }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = DetailVideoViewController.storyboardIndentifier
        let storyboard = UIStoryboard(name: identifier, bundle: Bundle.main)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: identifier) as! DetailVideoViewController
        detailViewController.context = context
        guard let video = context?.videoManager.videos[indexPath.row] else {
            return
        }
        detailViewController.videoInfo = video
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        searchController?.dismiss(animated: true, completion: nil)
        context?.videoManager.searchVideo(videoName: searchBar.text!, key:  "AIzaSyCuBInTJZNIGX-xMegSfj2WsK_vAj_NRqs") { (result) in
            switch result {
            case .success( _):
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.tableView.reloadData()
                }
            case .failure( _):
                break
            }
        }
    }
}

//MARK:- UINavigationBar
extension ViewController {
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Поиск"
        navigationItem.largeTitleDisplayMode = .automatic
    }
}

//MARK:- UINavigationBar
extension ViewController {
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
}

//MARK:- PULL TO REFRESH

extension ViewController {

}


