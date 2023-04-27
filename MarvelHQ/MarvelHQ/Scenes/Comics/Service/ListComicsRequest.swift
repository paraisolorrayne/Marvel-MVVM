import Foundation

struct ListComicsRequest: APIRequest {
    typealias Response = [Comics]

    var resourceName: String {
        return "comics"
    }

    // Parameters
    let format: String? = "comic"
    let limit: Int?
    let offset: Int?

    // Note that nil parameters will not be used
    init(limit: Int? = nil,
                offset: Int? = nil) {
        self.limit = limit
        self.offset = offset
    }
}
