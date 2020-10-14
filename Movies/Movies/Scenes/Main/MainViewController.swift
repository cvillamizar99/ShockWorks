//
//  MainViewController.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/13/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import UIKit

protocol MainDisplayLogic: class {
    func displayInitialData(viewModel: Main.LoadInitialData.ViewModel)
    func displayMovieDetail(viewModel: Main.Detail.ViewModel)
    func displayError(viewModel: Main.Error.ViewModel)
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var moviesData: [Movies] = []
    
    let cellMoviesNibName = "MoviesTableViewCell"
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .darkGray
        refreshControl.addTarget(self, action: #selector(loadInitialData), for: .valueChanged)
        return refreshControl
    }()
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?

    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }

    // MARK: - Setup
    private func setup() {
      let viewController = self
      let interactor = MainInteractor()
      let presenter = MainPresenter()
      let router = MainRouter()
      viewController.interactor = interactor
      viewController.router = router
      interactor.presenter = presenter
      presenter.viewController = viewController
      router.viewController = viewController
      router.dataStore = interactor
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.clearBackground()
        
        navBarTitle(title: "Hi", name: "Invited")
        
        settingTableView()
        loadInitialData()
    }
    
    // MARK: - Do something
    @objc func loadInitialData() {
        let request = Main.LoadInitialData.Request()
        interactor?.loadInitialData(request: request)
    }
    
    // MARK: - Show Movie Detail
    func showMovieDetail(movie: Movies) {
        let request = Main.Detail.Request(movie: movie)
        interactor?.showMovieDetail(request: request)
    }
    
    // MARK: - Methods
    private func settingTableView() {
        tableView.register(UINib(nibName: cellMoviesNibName, bundle: nil),
        forCellReuseIdentifier: MoviesTableViewCell.reuseIdentifier)
        
        tableView.refreshControl = refresher
        tableView.estimatedRowHeight = 90
    }
    
    func navBarTitle(title: String, name: String){
        let label = UILabel()
        label.attributedText = attributedText(withString: String(format: "\(title) %@", name), boldString: name, font: UIFont(name: "Rubik", size: 18)!)
        label.frame = CGRect(x: 0.0, y: 10.0, width: 200, height: 25)
        label.textColor = .darkGray
        
        let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 44.0))
        customView.addSubview(label)
        let leftButton = UIBarButtonItem(customView: customView)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Rubik-Medium", size: 18.0)!]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
}

// MARK: - MainDisplayLogic
extension MainViewController: MainDisplayLogic {
    func displayInitialData(viewModel: Main.LoadInitialData.ViewModel) {
        refresher.endRefreshing()
        
        moviesData = viewModel.movies
        
        tableView.reloadData()
    }
    
    func displayMovieDetail(viewModel: Main.Detail.ViewModel) {
        router?.routeToMovieDetail()
    }
    
    func displayError(viewModel: Main.Error.ViewModel){
        refresher.endRefreshing()
        
        print("Error ", viewModel.error.description)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.reuseIdentifier, for: indexPath) as? MoviesTableViewCell else {
            fatalError()
        }
        
        cell.configure(moviesData: moviesData[indexPath.item])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showMovieDetail(movie: moviesData[indexPath.row])
    }
}
