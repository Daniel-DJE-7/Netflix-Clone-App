//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Memo Figueredo on 4/2/26.
//

import UIKit

/*
 items =     (
             {
         etag = "WCsAwcrdx9_zultuRqxm2d2ejJU";
         id =             {
             kind = "youtube#video";
             videoId = 399Ez7WHK5s;
         };
         kind = "youtube#searchResult";
 
 */

struct YoutubeSearchResponse: Codable {
  let items: [VideoElement]
}

struct VideoElement: Codable {
  let id: IdVideoElement
}


struct IdVideoElement: Codable {
  let kind: String
  let videoId: String
}

/*
 YoutubeSearchResponse(items: [Netflix_Clone.IdVideoElement(id:Netflix_Clone.IdVideoElement(kind: "youtube#video", videoId: "V-81bIDPoFc"))
 */
