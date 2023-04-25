import Foundation

struct ListComicsRequest: DataRequest {

    var url: String {
        let baseURL: String = APIContants().baseURL
        let limit = "15"
        var path: String = ""
        path = "/comics?format=comic&formatType=comic&noVariants=false&dateRange=2022-01-01%2C2023-01-01&orderBy=title&limit=\(limit)"
        return baseURL + path
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [
            "apikey": APIContants().publicKey
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [Comics] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try decoder.decode(ComicsResponse.self, from: data)
        return response.results
    }
}
