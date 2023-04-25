import Foundation

struct Comics: Decodable {}

struct ComicsResponse: Decodable {
    let results: [Comics]
}
