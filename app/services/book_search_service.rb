require "net/http"
require "uri"
require "json"

# Google Books APIを叩いて本の情報を取得
class BookSearchService
  GOOGLE_BOOKS_URL = "https://www.googleapis.com/books/v1/volumes"

  def initialize(query)
    @query = query
    @api_key = Rails.configuration.x.google_books.api_key
  end

  def call
    uri = URI(GOOGLE_BOOKS_URL)
    uri.query = URI.encode_www_form({
      q: @query,
      key: @api_key,
      maxResults: 20,
      langRestrict: 'ja'
    })

    response = Net::HTTP.get_response(uri)
    return [] unless response.is_a?(Net::HTTPSuccess)

    parse_items(JSON.parse(response.body)["items"] || [])
  end

  private

  # 取得した本の情報を形成
  def parse_items(items)
    items.map do |item|
      info = item["volumeInfo"] || {}

      # HTTPS化&サムネ画像がない場合に代替画像を付与
      thumbnail = info.dig("imageLinks", "thumbnail")
      book_image = thumbnail ? thumbnail.gsub(/^http:/, "https:") : "/sample.jpg"

      # 2種のISBNから1つ抽出
      identifiers = info["industryIdentifiers"] || []
      isbn_hash = identifiers.find { |h| h["type"].include?("ISBN") }
      systemid = isbn_hash && isbn_hash["identifier"]

      {
        google_id: item["id"],
        title: info["title"],
        authors: info["authors"] || [],
        published_date: info["publishedDate"],
        thumbnail_link: book_image,
        description: info["description"],
        isbn: systemid
      }
    end
  end
end