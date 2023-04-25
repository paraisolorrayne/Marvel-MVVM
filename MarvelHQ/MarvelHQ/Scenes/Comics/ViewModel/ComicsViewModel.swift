import Foundation

protocol ComicsViewModelProtocol: AnyObject {
    var comics: [Comics] { set get }
    var onFetchMovieSucceed: (() -> Void)? { set get }
    var onFetchMovieFailure: ((Error) -> Void)? { set get }
    func fetchMovie()
}

final class ComicsViewModel: ComicsViewModelProtocol {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    var comics: [Comics] = []
    var onFetchMovieSucceed: (() -> Void)?
    var onFetchMovieFailure: ((Error) -> Void)?
    
    func fetchMovie() {
        let request = ListComicsRequest()
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let comics):
                self?.comics = comics
                self?.onFetchMovieSucceed?()
            case .failure(let error):
                self?.onFetchMovieFailure?(error)
            }
        }
    }
}
