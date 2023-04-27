import Foundation

struct ListComicsTitleRequest: APIRequest {
    enum ComicFormat: String, Encodable {
        case comic = "comic"
        case digital = "digital comic"
        case hardcover = "hardcover"
    }

    typealias Response = [Comics]

    var resourceName: String {
        return "comics"
    }

    // Parameters
    let title: String?
    let titleStartsWith: String?
    let format: ComicFormat?
    let limit: Int?
    let offset: Int?

    init(title: String? = nil,
                titleStartsWith: String? = nil,
                format: ComicFormat? = nil,
                limit: Int? = nil,
                offset: Int? = nil) {
        self.title = title
        self.titleStartsWith = titleStartsWith
        self.format = format
        self.limit = limit
        self.offset = offset
    }
}
