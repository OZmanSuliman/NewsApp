/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import RealmSwift

class Article : Object, Codable {
    @Persisted var uri : String?
    @Persisted var url : String?
    @Persisted(primaryKey: true) var id : Int
    @Persisted var asset_id : Int?
    @Persisted var source : String?
    @Persisted var published_date : String?
    @Persisted var updated : String?
    @Persisted var section : String?
    @Persisted var subsection : String?
    @Persisted var nytdsection : String?
    @Persisted var adx_keywords : String?
    @Persisted var column : String?
    @Persisted var byline : String?
    @Persisted var type : String?
    @Persisted var title : String?
    @Persisted var abstract : String?
    @Persisted var des_facet = List<String>()
    @Persisted var org_facet = List<String>()
    @Persisted var per_facet = List<String>()
    @Persisted var geo_facet = List<String>()
    @Persisted var media = List<MediaData>()
    @Persisted var eta_id : Int?

	enum CodingKeys: String, CodingKey {

		case uri = "uri"
		case url = "url"
		case id = "id"
		case asset_id = "asset_id"
		case source = "source"
		case published_date = "published_date"
		case updated = "updated"
		case section = "section"
		case subsection = "subsection"
		case nytdsection = "nytdsection"
		case adx_keywords = "adx_keywords"
		case column = "column"
		case byline = "byline"
		case type = "type"
		case title = "title"
		case abstract = "abstract"
		case des_facet = "des_facet"
		case org_facet = "org_facet"
		case per_facet = "per_facet"
		case geo_facet = "geo_facet"
		case media = "media"
		case eta_id = "eta_id"
	}
    
    override init() {
        super.init()
    }
    
    
    convenience init(uri: String?, url: String?, id: Int, asset_id: Int?, source: String?, published_date: String?, updated: String?, section: String?, subsection: String?, nytdsection: String?, adx_keywords: String?, column: String?, byline: String?, type: String?, title: String?, abstract: String?, des_facet: List<String> = List<String>(), org_facet: List<String> = List<String>(), per_facet: List<String> = List<String>(), geo_facet: List<String> = List<String>(), media: List<MediaData> = List<MediaData>(), eta_id: Int?) {
        self.init()
        self.uri = uri
        self.url = url
        self.id = id
        self.asset_id = asset_id
        self.source = source
        self.published_date = published_date
        self.updated = updated
        self.section = section
        self.subsection = subsection
        self.nytdsection = nytdsection
        self.adx_keywords = adx_keywords
        self.column = column
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.des_facet = des_facet
        self.org_facet = org_facet
        self.per_facet = per_facet
        self.geo_facet = geo_facet
        self.media = media
        self.eta_id = eta_id
    }

    
    required init(from decoder: Decoder) throws {
        super.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
		uri = try values.decodeIfPresent(String.self, forKey: .uri)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		id = try values.decode(Int.self, forKey: .id)
		asset_id = try values.decodeIfPresent(Int.self, forKey: .asset_id)
		source = try values.decodeIfPresent(String.self, forKey: .source)
		published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
		updated = try values.decodeIfPresent(String.self, forKey: .updated)
		section = try values.decodeIfPresent(String.self, forKey: .section)
		subsection = try values.decodeIfPresent(String.self, forKey: .subsection)
		nytdsection = try values.decodeIfPresent(String.self, forKey: .nytdsection)
		adx_keywords = try values.decodeIfPresent(String.self, forKey: .adx_keywords)
		column = try values.decodeIfPresent(String.self, forKey: .column)
		byline = try values.decodeIfPresent(String.self, forKey: .byline)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		abstract = try values.decodeIfPresent(String.self, forKey: .abstract)
		des_facet = try values.decodeIfPresent(List<String>.self, forKey: .des_facet) ?? List<String>()
		org_facet = try values.decodeIfPresent(List<String>.self, forKey: .org_facet) ?? List<String>()
		per_facet = try values.decodeIfPresent(List<String>.self, forKey: .per_facet) ?? List<String>()
		geo_facet = try values.decodeIfPresent(List<String>.self, forKey: .geo_facet) ?? List<String>()
        media = try values.decodeIfPresent(List<MediaData>.self, forKey: .media) ?? List<MediaData>()
		eta_id = try values.decodeIfPresent(Int.self, forKey: .eta_id)
	}

}

