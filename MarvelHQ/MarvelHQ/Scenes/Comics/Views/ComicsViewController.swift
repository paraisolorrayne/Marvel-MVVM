import Foundation
import UIKit

final class ComicsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        //table.register(MTCollectionViewTableViewCell.self, forCellReuseIdentifier: MTCollectionViewTableViewCell.identifier)
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 120.0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel: ComicsViewModelProtocol
    
    init(viewModel: ComicsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchComicList()
        bindViewModelEvent()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ComicsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularMovieCell.cellIdentifier, for: indexPath) as? PopularMovieCell else {
//            return UITableViewCell()
//        }
        
        return UITableViewCell()
    }
}
private extension ComicsViewController {
    private func configureView() {
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchComicList() {
        viewModel.fetchComicList()
    }
    
    private func bindViewModelEvent() {
        viewModel.onFetchComicSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onFetchComicFailure = { error in
            print(error)
        }
    }
}
