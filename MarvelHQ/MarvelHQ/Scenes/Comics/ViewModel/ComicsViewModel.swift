import Foundation

protocol ComicsViewModelProtocol: AnyObject {
    var comics: [Comics] { set get }
    var onFetchComicSucceed: (() -> Void)? { set get }
    var onFetchComicFailure: ((Error) -> Void)? { set get }
    func fetchComicByTitle(title: String)
    func fetchComicList()
    func getModelForCell(index: Int) -> ComicDTO.Resume
}

final class ComicsViewModel: ComicsViewModelProtocol {
    
    var comics: [Comics] = []
    var onFetchComicSucceed: (() -> Void)?
    var onFetchComicFailure: ((Error) -> Void)?
    var userIdentifier: String
    var fullName: PersonNameComponents?
    var email: String?

    private let apiClient = MarvelAPIClient(publicKey: APIContants().publicKey,
                                            privateKey: APIContants().privateKey)

    init(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        self.userIdentifier = userIdentifier
        self.fullName = fullName
        self.email = email
    }

    func fetchComicByTitle(title: String) {
        apiClient.send(ListComicsTitleRequest(titleStartsWith: title, format: .digital)) { [weak self] response in
            do {
                let dataContainer = try response.get()
                self?.comics = dataContainer.results
                self?.onFetchComicSucceed?()
            } catch {
                self?.onFetchComicFailure?(error)
                print(error)
            }
        }
    }

    func fetchComicList() {
        apiClient.send(ListComicsRequest()) { [weak self] response in
            do {
                let dataContainer = try response.get()
                self?.comics = dataContainer.results
                self?.onFetchComicSucceed?()
            } catch {
                print(error)
                self?.onFetchComicFailure?(error)
            }
        }
    }

    func getModelForCell(index: Int) -> ComicDTO.Resume {
        let image = comics[index].thumbnail?.url.description ?? ""
        return ComicDTO.Resume.init(image: image, title: comics[index].title ?? "")
    }
}
