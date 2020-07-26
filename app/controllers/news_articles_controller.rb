class NewsArticlesController < ApplicationController
  def new
    @news_article = NewsArticle.new
  end

  def create
    @news_article = NewsArticle.new news_article_params
    if @news_article.save
      flash[:notice] = 'Article created!'
      redirect_to @news_article
    else
      render :new
    end
  end

  private

  def news_article_params
    params.require(:news_article).permit(:title, :description)
  end
end
