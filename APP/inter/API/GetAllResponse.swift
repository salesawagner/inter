import Foundation

// MARK: - GetAllResponse
struct GetAllResponse: Codable {
    let name: Name?
    let tld: [String]?
    let cca2, ccn3, cca3, cioc: String?
    let independent: Bool?
    let status: String?
    let unMember: Bool?
    let currencies: Currencies?
    let idd: Idd?
    let capital, altSpellings: [String]?
    let region, subregion: String?
    let languages: [String: String]?
    let translations: [String: Translation]?
    let latlng: [Double]?
    let landlocked: Bool?
    let borders: [String]?
    let area: Double?
    let demonyms: Demonyms?
    let flag: String?
    let maps: Maps?
    let population: Int?
    let fifa: String?
    let car: Car?
    let timezones, continents: [String]?
    let flags: Flags?
    let coatOfArms: CoatOfArms?
    let startOfWeek: String?
    let capitalInfo: CapitalInfo?
    let postalCode: PostalCode?
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]?
    let side: String?
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

// MARK: - Currencies
struct Currencies: Codable {
    let eur: Eur?

    enum CodingKeys: String, CodingKey {
        case eur = "EUR"
    }
}

// MARK: - Eur
struct Eur: Codable {
    let name, symbol: String?
}

// MARK: - Demonyms
struct Demonyms: Codable {
    let eng, fra: Eng?
}

// MARK: - Eng
struct Eng: Codable {
    let f, m: String?
}

// MARK: - Flags
struct Flags: Codable {
    let png: String?
    let svg: String?
    let alt: String?
}

// MARK: - Idd
struct Idd: Codable {
    let root: String?
    let suffixes: [String]?
}


// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String?
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

// MARK: - PostalCode
struct PostalCode: Codable {
    let format, regex: String?
}
