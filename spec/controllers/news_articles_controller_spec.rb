require 'rails_helper'

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
end
