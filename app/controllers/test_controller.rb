class TestController < ApplicationController
  enable_esi
  
  def index
    respond_to do |format|
      format.html
    end
  end
  
  def blurb
    render :text => "YEAH BOYYYEEE #{Time.now.to_i}"
  end
  
end