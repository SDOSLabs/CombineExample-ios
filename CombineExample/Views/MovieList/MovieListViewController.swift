//
//  MovieListViewController.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import UIKit
import Combine

final class MovieListViewController: BaseViewController {
    private let viewModel: MovieListViewModelProtocol
    
    private let cancelButtonSubject = PassthroughSubject<Void, Never>()
    private let movieSelectionSubject = PassthroughSubject<Int, Never>()
    private var subscriptions = [AnyCancellable]()
    
    private var state: MovieListState? {
        didSet {
            guard let state = state else { return }
            
            switch state {
            case .initial:
                hideErrorView()
                hideLoader()
                showInfoView(title: "Utiliza la barra de búsqueda superior para encontrar tus películas favoritas",
                             image: UIImage(systemName: "film"))
                movies = []
            case .loading:
                hideInfoView()
                hideErrorView()
                showLoader()
                movies = []
            case .noResults:
                hideLoader()
                showInfoView(title: "No hay ningún resultado que concuerde con tu búsqueda",
                             image: UIImage(systemName: "exclamationmark"))
                
            case .success(let movies):
                hideLoader()
                self.movies = movies
            case .failure(let error):
                hideLoader()
                showErrorView(error)
            }
        }
    }
    
    private var movies = [MovieCellViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        
        return searchController
    }()
    
    @IBOutlet private var tableView: UITableView!
    
    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: MovieCell.identifier, bundle: nil),
                           forCellReuseIdentifier: MovieCell.identifier)
        
        let cancelSearch = cancelButtonSubject.eraseToAnyPublisher()
        let search = Publishers.MergeMany(searchController.searchBar.searchTextField.textPublisher(),
                                          cancelSearch.map { "" }.eraseToAnyPublisher())
            .eraseToAnyPublisher()
        
        let selection = movieSelectionSubject.eraseToAnyPublisher()
        
        let input = MovieListViewModelInput(search: search, cancelSearch: cancelSearch, selection: selection)
        let output = viewModel.bind(input: input)
        
        output.state
            .sink { [weak self] state in
                self?.state = state
            }.store(in: &subscriptions)
        
        output.showDetail
            .sink { [weak self] viewController in
                self?.navigationController?.pushViewController(viewController, animated: true)
            }.store(in: &subscriptions)
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as! MovieCell
        cell.populate(with: movie)
        
        return cell
    }
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieSelectionSubject.send(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelButtonSubject.send()
    }
}
