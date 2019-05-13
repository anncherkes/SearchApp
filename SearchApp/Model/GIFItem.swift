//
//  GIFItem.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.


import Foundation
import UIKit

public struct GIFItem: Decodable  {
    public let data : [DataItem]?
    public let meta : Meta?
    public let pagination : Pagination?
}

public struct Pagination: Decodable {
    public let count : Int?
    public let offset : Int?
    public let total_count : Int?
}

public struct Meta: Decodable {
    public let msg : String?
    public let response_id : String?
    public let status : Int?
}

public struct DataItem: Decodable {
    public let analytics : Analytic?
    public let bitly_gif_url : String?
    public let bitly_url : String?
    public let content_url : String?
    public let embed_url : String?
    public let id : String?
    public let images : Image?
    public let import_datetime : String?
    public let is_sticker : Int?
    public let rating : String?
    public let slug : String?
    public let source : String?
    public let source_post_url : String?
    public let source_tld : String?
    public let title : String?
    public let trending_datetime : String?
    public let type : String?
    public let url : String?
    public let user : User?
    public let username : String?
}

public struct User : Decodable {
    public let avatar_url : String?
    public let banner_url : String?
    public let display_name : String?
    public let is_verified : Bool?
    public let profile_url : String?
    public let username : String?
}

public struct `Image`: Decodable {
    public let downsized_small : DownsizedSmall?
    public let fixed_height : FixedHeight?
    public let fixed_height_downsampled : FixedHeightDownsampled?
    public let fixed_height_small : FixedHeight?
    public let fixed_height_small_still : FixedHeightSmallStill?
    public let fixed_height_still : FixedHeightSmallStill?
    public let fixed_width : FixedHeight?
    public let fixed_width_downsampled : FixedHeightDownsampled?
    public let fixed_width_small : FixedHeight?
    public let fixed_width_small_still : FixedHeightSmallStill?
    public let fixed_width_still : FixedHeightSmallStill?
    public let looping : Looping?
    public let original : Original?
    public let original_mp4 : DownsizedSmall?
    public let original_still : FixedHeightSmallStill?
    public let preview : DownsizedSmall?
}

public struct Original : Decodable {
    public let frames : String?
    public let height : String?
    public let mp4 : String?
    public let mp4_size : String?
    public let size : String?
    public let url : String?
    public let webp : String?
    public let webp_size : String?
    public let width : String?
}

public struct Looping : Decodable {
    public let mp4 : String?
    public let mp4_size : String?
}

public struct FixedHeightSmallStill : Decodable {
    public let height : String?
    public let url : String?
    public let width : String?
}

public struct FixedHeightDownsampled : Decodable {
    public let height : String?
    public let size : String?
    public let url : String?
    public let webp : String?
    public let webp_size : String?
    public let width : String?
}

public struct FixedHeight : Decodable {
    public let height : String?
    public let mp4 : String?
    public let mp4_size : String?
    public let size : String?
    public let url : String?
    public let webp : String?
    public let webp_size : String?
    public let width : String?
}

public struct DownsizedSmall : Decodable {
    public let height : String?
    public let mp4 : String?
    public let mp4_size : String?
    public let width : String?
}

public struct Analytic : Decodable {
    public let onclick : Onclick?
    public let onload : Onclick?
    public let onsent : Onclick?
}

public struct Onclick : Decodable {
    public let url : String?
}
