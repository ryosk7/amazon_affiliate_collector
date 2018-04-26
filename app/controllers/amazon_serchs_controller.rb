class AmazonSerchsController < ApplicationController
  require 'amazon/ecs'
  Amazon::Ecs.options = {
    :associate_tag =>     ENV["AMAZON_ASSOCIATE"],
    :AWS_access_key_id => ENV["AWS_ACCESS_KEY_ID"],
    :AWS_secret_key => ENV["AWS_SECRET_ACCESS_KEY"]
  }
  def index
    # 検索の実行
    amazon = Amazon::Ecs.item_search(
      'キーワード',
      :search_index => 'Books', #=> 検索対象の指定
      :response_group=>"Large", #=> レスポンスに含まれる要素の指定
      :country => 'jp'
    )
    # 各商品ごとに処理
    amazon.items.each do |item|
      #@instance = item.class #=> 商品ごとに Amazon::Element のインスタンスが渡される
      @title = item.get('ItemAttributes/Title') #=> タイトルの取得（Amazon::Element.get(PATH) でパスを指定して値の取得）
      @detail_url = item.get('DetailPageURL') #=> 商品詳細URL
      @image_url = item.get("LargeImage/URL") #=> 商品画像URL
      #@element_name = item.get_element('ItemAttributes').get("Title") #=> Amazon::Element.get_element(ELEMENT_NAME) で子要素を取得
      #@element_css = item.get_element('ItemAttributes').elem.css("Title").text
      book = Book.new(@title,@detail_url,@image_url)
      @books = []
      @books << book
    end
  end

  def show
    amazon = Amazon::Ecs.item_search(
      '', #=> browse_node 指定時にはキーワードは省略可
      :search_index => 'KindleStore',
      :response_group=>"Small, BrowseNodes",
      :country => 'jp',
      :browse_node => '2293143051',
      :sort => "salesrank",
      :item_page => "2"
    )
    amazon.items.each do |item|
      @item_title = "Title: " + item.get('ItemAttributes/Title')
      @item_id = item.get("BrowseNodes/BrowseNode/BrowseNodeId") #=> メインのカテゴリーID
      if item.get_element("BrowseNodes/BrowseNode/Children") then #=> サブのIDがあれば表示
        item.get_element("BrowseNodes/BrowseNode/Children").elem.children.each {|c| @brows_node_id = c.css("BrowseNodeId").text }
      end
    end
  end
end
