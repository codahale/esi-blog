class TestController < ApplicationController
  enable_esi :only => [:index], :stale_ttl => 1.year
  
  def index
    respond_to do |format|
      format.html
    end
  end
  
  def blurb
    render :text => "YEAH BOYYYEEE #{Time.now.to_i}"
  end
  
end