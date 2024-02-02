import Foundation

// MARK: - GetAllResponse
struct GetAllResponse: Codable {
    let name: Name?
}

// MARK: - Name
struct Name: Codable {
    let common, official: String?
    let nativeName: NativeName?
}

// MARK: - NativeName
struct NativeName: Codable {
    let cat: Translation?
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String?
}
