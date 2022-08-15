//
//  DetailedCryptoModel.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 13/08/22.
//

import Foundation


struct DetailedCryptoModel: Codable {
    var id, symbol, name: String?
    var localization, welcomeDescription: Tion?
    var image: Image?
    var countryOrigin: String?
    var sentimentVotesUpPercentage, sentimentVotesDownPercentage: Double?
    var marketCapRank, coingeckoRank: Int?
    var coingeckoScore, developerScore, communityScore, liquidityScore: Double?
    var publicInterestScore: Double?
    var marketData: MarketData?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case localization
        case welcomeDescription = "description"
        case image
        case countryOrigin = "country_origin"
        case sentimentVotesUpPercentage = "sentiment_votes_up_percentage"
        case sentimentVotesDownPercentage = "sentiment_votes_down_percentage"
        case marketCapRank = "market_cap_rank"
        case coingeckoRank = "coingecko_rank"
        case coingeckoScore = "coingecko_score"
        case developerScore = "developer_score"
        case communityScore = "community_score"
        case liquidityScore = "liquidity_score"
        case publicInterestScore = "public_interest_score"
        case marketData = "market_data"
    }
}

// MARK: - Image
struct Image: Codable {
    var thumb, small, large: String?
}

// MARK: Currency
struct Currency: Codable {
    var inr: Double?
    var usd: Double?
    var eur: Double?
    
    enum CodingKeys: String, CodingKey {
        case inr
        case usd
        case eur
    }
}

// MARK: - Tion
struct Tion: Codable {
    var en, de, es, fr: String?
    var it, pl, ro, hu: String?
    var nl, pt, sv, vi: String?
    var tr, ru, ja, zh: String?
    var zhTw, ko, ar, th: String?
    var id, cs, da, el: String?
    var hi, no, sk, uk: String?
    var he, fi, bg, hr: String?
    var lt, sl: String?

    enum CodingKeys: String, CodingKey {
        case en, de, es, fr, it, pl, ro, hu, nl, pt, sv, vi, tr, ru, ja, zh
        case zhTw = "zh-tw"
        case ko, ar, th, id, cs, da, el, hi, no, sk, uk, he, fi, bg, hr, lt, sl
    }
}

// MARK: - MarketData
struct MarketData: Codable {
    var currentPrice: Currency?
    var ath, athChangePercentage: Currency?
    var atl, atlChangePercentage: Currency?
    var marketCap: Currency?
    var marketCapRank: Int?
    var fullyDilutedValuation, totalVolume, high24H, low24H: Currency?
    var priceChange24H, priceChangePercentage24H, priceChangePercentage7D, priceChangePercentage14D: Double?
    var priceChangePercentage30D, priceChangePercentage60D, priceChangePercentage200D, priceChangePercentage1Y: Double?
    var marketCapChange24H: Double?
    var marketCapChangePercentage24H: Double?
    var priceChange24HInCurrency, priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency: Currency?
    var priceChangePercentage14DInCurrency, priceChangePercentage30DInCurrency, priceChangePercentage60DInCurrency, priceChangePercentage200DInCurrency: Currency?
    var priceChangePercentage1YInCurrency, marketCapChange24HInCurrency, marketCapChangePercentage24HInCurrency: Currency?
    var totalSupply, maxSupply, circulatingSupply: Double?
    var lastUpdated: String?
    var sparkline7D: Sparkline7D?


    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case priceChangePercentage7D = "price_change_percentage_7d"
        case priceChangePercentage14D = "price_change_percentage_14d"
        case priceChangePercentage30D = "price_change_percentage_30d"
        case priceChangePercentage60D = "price_change_percentage_60d"
        case priceChangePercentage200D = "price_change_percentage_200d"
        case priceChangePercentage1Y = "price_change_percentage_1y"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case priceChange24HInCurrency = "price_change_24h_in_currency"
        case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case priceChangePercentage7DInCurrency = "price_change_percentage_7d_in_currency"
        case priceChangePercentage14DInCurrency = "price_change_percentage_14d_in_currency"
        case priceChangePercentage30DInCurrency = "price_change_percentage_30d_in_currency"
        case priceChangePercentage60DInCurrency = "price_change_percentage_60d_in_currency"
        case priceChangePercentage200DInCurrency = "price_change_percentage_200d_in_currency"
        case priceChangePercentage1YInCurrency = "price_change_percentage_1y_in_currency"
        case marketCapChange24HInCurrency = "market_cap_change_24h_in_currency"
        case marketCapChangePercentage24HInCurrency = "market_cap_change_percentage_24h_in_currency"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case circulatingSupply = "circulating_supply"
        case lastUpdated = "last_updated"
        case sparkline7D = "sparkline_7d"

    }
}


// MARK: - PublicInterestStats
struct PublicInterestStats: Codable {
    var alexaRank: Int?

    enum CodingKeys: String, CodingKey {
        case alexaRank = "alexa_rank"
    }
}

struct Sparkline7D: Codable {
    var price: [Double]?
}
