//
//  FeedStructure.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 28/12/23.
//

import Foundation

// MARK: - FeedStructure
struct FeedStructure: Codable {
    let success: Bool?
    let data: DataClass?
    let status: Int?
}

// MARK: - DataClass
struct DataClass: Codable {
    let items: [DataItem]?
    let next, new: String?
}

// MARK: - DataItem
struct DataItem: Codable {
    let id: String?
    let primary: PostItem?
    let reason: String?
    let type: FluffyType?
    let items: [PostItem]?
    let next: String?
    let meta: FluffyMeta?
    let userFollow: Bool?
    let start: String?

    enum CodingKeys: String, CodingKey {
        case id, primary, reason, type, items, next, meta
        case userFollow = "user_follow"
        case start
    }
}

// MARK: - ItemItem
struct PostItem: Codable, Identifiable {
    var post: ItemPost?
    let meta: PurpleMeta?
    let type: String?
    let comment: Comment?
    let tag: TagElement?
    private let idValue: String?
    var id: String {
        self.idValue ?? UUID().uuidString
    }

    enum CodingKeys: String, CodingKey {
        case post, meta, type, comment, tag
        case idValue = "id"
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id, downs, points, parentID: Int?
    let author, comment: String?
    let albumCover: String?
    let deleted: Bool?
    let imageID: String?
    let authorID: Int?
    let onAlbum: Bool?
    let vote: String?
    let platform: Platform?
    let hasAdminBadge: Bool?
    let children: [JSONAny]?
    let datetime, ups: Int?

    enum CodingKeys: String, CodingKey {
        case id, downs, points
        case parentID = "parent_id"
        case author, comment
        case albumCover = "album_cover"
        case deleted
        case imageID = "image_id"
        case authorID = "author_id"
        case onAlbum = "on_album"
        case vote, platform
        case hasAdminBadge = "has_admin_badge"
        case children, datetime, ups
    }
}

enum Platform: String, Codable {
    case android = "android"
    case api = "api"
    case desktop = "desktop"
    case iphone = "iphone"
}

// MARK: - PurpleMeta
struct PurpleMeta: Codable {
    let display: [Display]?
}

enum Display: String, Codable {
    case grid = "grid"
    case thumbnail = "thumbnail"
}

// MARK: - ItemPost
struct ItemPost: Codable {
    let includeAlbumAds, inGallery: Bool?

    let accountID, coverWidth: Int?
    let description: String?
    let points, score: Int?
    let privacy: Privacy?
    let vote: String?
    let section, cover: String?
    let imagesCount: Int?
    let accountURL: String?
    let views, favoriteCount: Int?
    let link: String?
    let datetime, downs: Int?
    let favorite: Bool?
    let commentCount: Int?
    let images: [FeedImage]?
    let topic: String?
    let tags: [TagElement]?
    let adType: Int?
    let adURL: String?
    let isAlbum: Bool?
    let layout: Layout?
    let topicID: Int?
    let title: String?
    let coverHeight: Int?
    let inMostViral: Bool?
    let ups: Int?
    let nsfw, isAd, animated: Bool?
    let type: ImageType?
    let hasSound: Bool?
    let edited, size, bandwidth: Int?
    private let idValue: String?
    
    var id: String {
        self.idValue ?? UUID().uuidString
    }

    enum CodingKeys: String, CodingKey {
        case includeAlbumAds = "include_album_ads"
        case inGallery = "in_gallery"
        case idValue = "id"
        case accountID = "account_id"
        case coverWidth = "cover_width"
        case description, points, score, privacy, vote, section, cover
        case imagesCount = "images_count"
        case accountURL = "account_url"
        case views
        case favoriteCount = "favorite_count"
        case link, datetime, downs, favorite
        case commentCount = "comment_count"
        case images, topic, tags
        case adType = "ad_type"
        case adURL = "ad_url"
        case isAlbum = "is_album"
        case layout
        case topicID = "topic_id"
        case title
        case coverHeight = "cover_height"
        case inMostViral = "in_most_viral"
        case ups, nsfw
        case isAd = "is_ad"
        case animated, type
        case hasSound = "has_sound"
        case edited, size, bandwidth
    }

    static let `default` = ItemPost(includeAlbumAds: false,
                                    inGallery: false,
                                    accountID: 0,
                                    coverWidth: 0,
                                    description: "Description",
                                    points: 0,
                                    score: 0,
                                    privacy: nil,
                                    vote: nil,
                                    section: "Section",
                                    cover: "Cover",
                                    imagesCount: 1,
                                    accountURL: nil,
                                    views: 1,
                                    favoriteCount: 1,
                                    link: "https://imgur.com/a/rWjFvq0",
                                    datetime: 0,
                                    downs: 0,
                                    favorite: false,
                                    commentCount: 1,
                                    images: [FeedImage.default, FeedImage.default, FeedImage.default],
                                    topic: nil,
                                    tags: nil,
                                    adType: nil,
                                    adURL: nil,
                                    isAlbum: nil,
                                    layout: nil,
                                    topicID: nil,
                                    title: "title",
                                    coverHeight: nil,
                                    inMostViral: nil,
                                    ups: nil,
                                    nsfw: nil,
                                    isAd: nil,
                                    animated: false,
                                    type: .imageJPEG,
                                    hasSound: nil,
                                    edited: nil,
                                    size: nil,
                                    bandwidth: nil,
                                    idValue: nil)
}

// MARK: - Image
struct FeedImage: Codable, Identifiable, Hashable {
    
    let inMostViral, inGallery: Bool?
    let nsfw, title: String?
    let link: String
    let tags: [JSONAny]?
    let adURL: String?
    let animated, favorite, isAd: Bool?
    let edited: String?
    let score: String?
    let views: Int?
    let type: ImageType
    let datetime, size: Int?
    let hasSound: Bool?
    let downs, points: String?
    let height, width: Int
    
    let vote, accountURL, accountID: String?
    let adType: Int?
    let favoriteCount, ups, commentCount, section: String?
    let description: String?
    let gifv: String?
    let mp4Size: Int?
    let hls: String?
    let processing: Processing?
    let mp4: String?
    let looping: Bool?
    private let idValue: String?
    
    var id: String {
        self.idValue ?? UUID().uuidString
    }

    func getSize() -> CGSize {
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }

    static func == (lhs: FeedImage, rhs: FeedImage) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    enum CodingKeys: String, CodingKey {
        case inMostViral = "in_most_viral"
        case inGallery = "in_gallery"
        case nsfw, title, link, tags
        case adURL = "ad_url"
        case animated, favorite
        case isAd = "is_ad"
        case edited, score, views, type, datetime, size
        case idValue = "id"
        case hasSound = "has_sound"
        case downs, points, height, width, vote
        case accountURL = "account_url"
        case accountID = "account_id"
        case adType = "ad_type"
        case favoriteCount = "favorite_count"
        case ups
        case commentCount = "comment_count"
        case section, description, gifv
        case mp4Size = "mp4_size"
        case hls, processing, mp4, looping
    }

    static let `default` = FeedImage(inMostViral: false,
                                     inGallery: false,
                                     nsfw: nil,
                                     title: nil,
                                     link: "https://i.imgur.com/EQdsH2D.jpg",
                                     tags: [],
                                     adURL: nil,
                                     animated: false,
                                     favorite: false,
                                     isAd: false,
                                     edited: "0",
                                     score: nil,
                                     views: 1,
                                     type: .imageJPEG,
                                     datetime: 0,
                                     size: 260328,
                                     hasSound: false,
                                     downs: nil,
                                     points: nil,
                                     height: 2048,
                                     width: 1556,
                                     vote: nil,
                                     accountURL: nil,
                                     accountID: nil,
                                     adType: nil,
                                     favoriteCount: nil,
                                     ups: nil,
                                     commentCount: nil,
                                     section: nil,
                                     description: "descrioption",
                                     gifv: nil,
                                     mp4Size: 0,
                                     hls: nil,
                                     processing: nil,
                                     mp4: nil,
                                     looping: false,
                                     idValue: "EQdsH2D")
    
    static let video = FeedImage(inMostViral: false,
                                 inGallery: false,
                                 nsfw: nil,
                                 title: nil,
                                 link: "https://i.imgur.com/PcMCULR.mp4",
                                 tags: [],
                                 adURL: nil,
                                 animated: false,
                                 favorite: false,
                                 isAd: false,
                                 edited: "0",
                                 score: nil,
                                 views: 1,
                                 type: .videoMp4,
                                 datetime: 0,
                                 size: 260328,
                                 hasSound: false,
                                 downs: nil,
                                 points: nil,
                                 height: 2048,
                                 width: 1556,
                                 vote: nil,
                                 accountURL: nil,
                                 accountID: nil,
                                 adType: nil,
                                 favoriteCount: nil,
                                 ups: nil,
                                 commentCount: nil,
                                 section: nil,
                                 description: "descrioption",
                                 gifv: nil,
                                 mp4Size: 0,
                                 hls: nil,
                                 processing: nil,
                                 mp4: nil,
                                 looping: false,
                                 idValue: "EQdsH2D")
}

// MARK: - Processing
struct Processing: Codable {
    let status: Status?
}

enum Status: String, Codable {
    case completed = "completed"
}

enum ImageType: String, Codable {
    case imageGIF = "image/gif"
    case imageJPEG = "image/jpeg"
    case imagePNG = "image/png"
    case videoMp4 = "video/mp4"
}

enum Layout: String, Codable {
    case blog = "blog"
}

enum Privacy: String, Codable {
    case hidden = "hidden"
    case privacyPublic = "public"
}

// MARK: - TagElement
struct TagElement: Codable {
    let thumbnailIsAnimated: Bool?
    let description: String?
    let isPromoted, backgroundIsAnimated: Bool?
    let logoDestinationURL, logoHash: String?
    let totalItems: Int?
    let backgroundHash, displayName: String?
    let accent, thumbnailHash: String?
    let descriptionAnnotations: DescriptionAnnotations?
    let following: Bool?
    let followers: Int?
    let tagFollow: TagFollow?
    let name: String?
    let isWhitelisted: Bool?

    enum CodingKeys: String, CodingKey {
        case thumbnailIsAnimated = "thumbnail_is_animated"
        case description
        case isPromoted = "is_promoted"
        case backgroundIsAnimated = "background_is_animated"
        case logoDestinationURL = "logo_destination_url"
        case logoHash = "logo_hash"
        case totalItems = "total_items"
        case backgroundHash = "background_hash"
        case displayName = "display_name"
        case accent
        case thumbnailHash = "thumbnail_hash"
        case descriptionAnnotations = "description_annotations"
        case following, followers
        case tagFollow = "tag_follow"
        case name
        case isWhitelisted = "is_whitelisted"
    }
}

// MARK: - DescriptionAnnotations
struct DescriptionAnnotations: Codable {
}

// MARK: - TagFollow
struct TagFollow: Codable {
    let status: Bool?
}

// MARK: - FluffyMeta
struct FluffyMeta: Codable {
    let display: [String]?
    let sorts: [JSONAny]?
    let total: Int?
}

// MARK: - Primary
struct Primary: Codable {
    let meta: PrimaryMeta?
    let id: String?
    let type: PrimaryType?
    let tag: PrimaryTag?
    let post: PrimaryPost?
    let string: String?
}

// MARK: - PrimaryMeta
struct PrimaryMeta: Codable {
    let display: [JSONAny]?
    let analytics: Analytics?
}

// MARK: - Analytics
struct Analytics: Codable {
    let viewed: String?
}

// MARK: - PrimaryPost
struct PrimaryPost: Codable {
    let includeAlbumAds, inGallery: Bool?
    let id: String?
    let accountID: Int?
    let adConfig: AdConfig?
    let coverWidth: Int?
    let description: String?
    let points, score: Int?
    let privacy: Privacy?
    let vote: String?
    let section: String?
    let cover: String?
    let imagesCount: Int?
    let accountURL: String?
    let views, favoriteCount: Int?
    let link: String?
    let datetime, downs: Int?
    let favorite: Bool?
    let commentCount: Int?
    let images: [FeedImage]?
    let topic: String?
    let tags: [TagElement]?
    let adType: Int?
    let adURL: String?
    let isAlbum: Bool?
    let layout: Layout?
    let topicID: Int?
    let title: String?
    let coverHeight: Int?
    let inMostViral: Bool?
    let ups: Int?
    let nsfw, isAd: Bool?
    let gifv: String?
    let animated: Bool?
    let type: ImageType?
    let hasSound: Bool?
    let mp4Size: Int?
    let hls: String?
    let processing: Processing?
    let height, edited, size, bandwidth: Int?
    let mp4: String?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case includeAlbumAds = "include_album_ads"
        case inGallery = "in_gallery"
        case id
        case accountID = "account_id"
        case adConfig = "ad_config"
        case coverWidth = "cover_width"
        case description, points, score, privacy, vote, section, cover
        case imagesCount = "images_count"
        case accountURL = "account_url"
        case views
        case favoriteCount = "favorite_count"
        case link, datetime, downs, favorite
        case commentCount = "comment_count"
        case images, topic, tags
        case adType = "ad_type"
        case adURL = "ad_url"
        case isAlbum = "is_album"
        case layout
        case topicID = "topic_id"
        case title
        case coverHeight = "cover_height"
        case inMostViral = "in_most_viral"
        case ups, nsfw
        case isAd = "is_ad"
        case gifv, animated, type
        case hasSound = "has_sound"
        case mp4Size = "mp4_size"
        case hls, processing, height, edited, size, bandwidth, mp4, width
    }
}

// MARK: - AdConfig
struct AdConfig: Codable {
    let adConfigUnsafeFlags: [UnsafeFlag]?
    let adConfigWallUnsafeFlags, wallUnsafeFlags: [String]?
    let showAdLevel: Int?
    let highRiskFlags: [JSONAny]?
    let showAds: Bool?
    let adConfigShowAdLevel: Int?
    let nsfwScore: Double?
    let safeFlags, adConfigSafeFlags: [SafeFlag]?
    let showsAds: Bool?
    let unsafeFlags: [UnsafeFlag]?
    let adConfigHighRiskFlags: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case adConfigUnsafeFlags = "unsafe_flags"
        case adConfigWallUnsafeFlags = "wall_unsafe_flags"
        case wallUnsafeFlags, showAdLevel, highRiskFlags
        case showAds = "show_ads"
        case adConfigShowAdLevel = "show_ad_level"
        case nsfwScore = "nsfw_score"
        case safeFlags
        case adConfigSafeFlags = "safe_flags"
        case showsAds, unsafeFlags
        case adConfigHighRiskFlags = "high_risk_flags"
    }
}

enum SafeFlag: String, Codable {
    case album = "album"
    case gallery = "gallery"
    case inGallery = "in_gallery"
    case sixthModSafe = "sixth_mod_safe"
}

enum UnsafeFlag: String, Codable {
    case onsfwModUnsafe = "onsfw_mod_unsafe"
    case sixthModUnsafe = "sixth_mod_unsafe"
    case under10 = "under_10"
}

enum Section: String, Codable {
    case empty = ""
    case movies = "movies"
}

// MARK: - PrimaryTag
struct PrimaryTag: Codable {
    let thumbnailIsAnimated, backgroundIsAnimated: Bool?
    let totalItems: Int?
    let backgroundHash, displayName: String?
    let accent, thumbnailHash: String?
    let following: Bool?
    let followers: Int?
    let tagFollow: TagFollow?
    let name: String?
    let isWhitelisted: Bool?

    enum CodingKeys: String, CodingKey {
        case thumbnailIsAnimated = "thumbnail_is_animated"
        case backgroundIsAnimated = "background_is_animated"
        case totalItems = "total_items"
        case backgroundHash = "background_hash"
        case displayName = "display_name"
        case accent
        case thumbnailHash = "thumbnail_hash"
        case following, followers
        case tagFollow = "tag_follow"
        case name
        case isWhitelisted = "is_whitelisted"
    }
}

enum PrimaryType: String, Codable {
    case post = "post"
    case string = "string"
    case tag = "tag"
}

enum FluffyType: String, Codable {
    case ad = "ad"
    case header = "header"
    case post = "post"
    case recommendedFollowable = "recommended_followable"
    case recommendedList = "recommended_list"
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }

        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
