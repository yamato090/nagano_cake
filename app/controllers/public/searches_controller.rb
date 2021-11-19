class Public::SearchesController < ApplicationController
  def genre_search
    @genres = Genre.all
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @value)
  end

  def product_search
    @genres = Genre.all
    @products = Product.search(params[:keyword]).page(params[:page]).per(8)
    @keyword = params[:keyword]
  end

  private

  def match(value)
    @genre = Genre.find_by(name: value)
    Product.where(genre_id: @genre)
  end

  def search_for(how, value)
    case how
    when 'match'
      match(value)
    end
  end
end
