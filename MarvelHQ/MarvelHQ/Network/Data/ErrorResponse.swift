import Foundation

enum MarvelError: Error {
    case encoding
    case decoding
    case server(message: String)
    
    public var description: String {
        switch self {
        case .decoding: return "Ooops, there is something problem with the response"
        case .encoding: return "Ooops, there is something problem with the serialization process"
        case .server(message: let message): return message
        }
    }
}
