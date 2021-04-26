require 'rails_helper'
# rails generate rspec:controller news_aricles --controller-specs --no-request-specs
RSpec.describe NewsArticlesController, type: :controller do
  describe '#new' do
    it 'renders the new template' do 
      get :new
      expect(response).to render_template(:new)
    end

    it 'sets an instance variable with a new news article instance' do 
      get :new
      expect(assigns(:news_article)).to be_a_new(NewsArticle) 
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      def valid_request
        post :create, params: {
          news_article: FactoryBot.attributes_for(:news_article)
        }
      end

      it 'create a new news article in the db' do
        count_before = NewsArticle.count
        valid_request
        count_after = NewsArticle.count
        expect(count_after).to eq(count_before + 1)
      end

      it 'redirects to the show page of that news article' do
        valid_request
        expect(response).to redirect_to(news_article_path(NewsArticle.last))
      end

      it 'sets a flash message' do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context 'with invalid parameters' do
      def invalid_request
        post :create, params: {
          news_article: FactoryBot.attributes_for(:news_article, title: nil)
        }
      end

      it 'doesn\'t save a news article to the db' do
        count_before = NewsArticle.count
        invalid_request
        count_after = NewsArticle.count
        expect(count_after).to eq(count_before)
      end

      it 'render the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#destroy" do
    before do
      @news_article = FactoryBot.create(:news_article)
    end

    it 'removes a record from the database' do
      count_before = NewsArticle.count
      delete :destroy, params: { id: @news_article.id }
      count_after = NewsArticle.count
      expect(count_after).to eq(count_before - 1)
    end

    it 'redirects to the index page' do
      delete :destroy, params: { id: @news_article.id }
      expect(response).to redirect_to(news_articles_path)
    end

    it 'sets a flash message' do
      delete :destroy, params: { id: @news_article.id }
      expect(flash[:alert]).to be
    end
  end

  describe '#show' do
    before do
      @news_article = FactoryBot.create(:news_article)
      get :show, params: { id: @news_article.id }
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'sets an instance variable based on the article id that is passed' do
      expect(assigns(:news_article)).to eq(@news_article)
    end
  end

  describe '#index' do
    before do
      get :index
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'assigns an instance variable to all created news articles sorted by created_at' do
      news_article_1 = FactoryBot.create(:news_article)
      news_article_2 = FactoryBot.create(:news_article)
      expect(assigns(:news_articles)).to eq([news_article_2, news_article_1])
    end
  end
end
