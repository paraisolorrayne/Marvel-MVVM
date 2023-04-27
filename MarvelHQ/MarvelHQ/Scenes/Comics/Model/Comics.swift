import Foundation

struct Comics: Decodable {
    let id: Int
    let title: String?
    let issueNumber: Double?
    let description: String?
    let pageCount: Int?
    let thumbnail: Image?
}
