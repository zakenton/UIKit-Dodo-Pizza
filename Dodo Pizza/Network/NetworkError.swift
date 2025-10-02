import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case statusCode(Int)
    case network(Error)
    case unknown
}
