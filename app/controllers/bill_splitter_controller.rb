class BillSplitterController < ApplicationController
  def new
  end

  def create
    amount = params[:amount]
    tax = params[:tax]
    tip = params[:tip]
    num_of_people = params[:num_of_people]
    @split_amount = ( amount.to_f + (amount.to_f * (tax.to_f / 100)) + (amount.to_f * (tip.to_f / 100)) ) / num_of_people.to_f
  end
end
