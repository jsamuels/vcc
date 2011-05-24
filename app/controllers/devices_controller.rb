class DevicesController < ApplicationController  
  before_filter 	:authorize, :except => [:proof_email]
  KEY_STRING_PRE = "p0nBVkj8kluDA5Yhd8kiG4Flso"
  KEY_STRING_POST = "l9Uhy4E2Sw"               
  def index
    render(:template => "proofs/index" )
  end
  
  def trend_de
    #  check if pushed from charts
    if params[:device] || params[:profile] || params[:location] || params[:operator] 
      @date_filter.clear!
      @date_filter.device = Device.find(params[:device]) if params[:device]
      # Should this happen @ the date_filter when a device is set?  REFACTOR
      @date_filter.location = @date_filter.device.location if params[:device]
      @date_filter.series = @date_filter.device.series if params[:device]
      
      @date_filter.profile = params[:profile] if params[:profile]
      @date_filter.location = params[:location] if params[:location]
      @date_filter.operator = params[:operator] if params[:operator]
    end  
    @date_filter.chart_type = 'MSLine.swf'
    render(:template => "proofs/index" )
  end
  
  def trend_labch 
    @date_filter.chart_type = 'MSLine.swf'
    render(:template => "proofs/index" )
  end
  
  def trend_spectral 
    @date_filter.chart_type = 'MSLine.swf'
    render(:template => "proofs/index" )
  end
  
  def proof_details
    if params[:proof]
      @proof = Proof.find(params[:proof])
      @key = key_hash(@proof.id)
      @date_filter.clear!
      @date_filter.device = Device.find(@proof.device_id)
      @date_filter.location = @date_filter.device.location
      @date_filter.chart_type = 'Bar2D.swf'
    	render(:template => "proofs/show" )
    else
      render(:text => "Error expected proof value." )	
    end  
  end
  
  def proof_email
    if params[:proof] && params[:key]
      test_key = key_hash(params[:proof])
      @key = params[:key]
      if @key.to_i == test_key.to_i
        @proof = Proof.find(params[:proof])
        @date_filter = DateFilter.new
        @date_filter.device = Device.find(@proof.device_id)
        @date_filter.location = @date_filter.device.location
        @date_filter.member_id = @date_filter.device.member_id
        @date_filter.chart_type = 'Bar2D.swf'
      	render(:template => "proofs/show" )
      else
       flash[:notice] = "Error incorrect proof and key value.\nPlease log in"
   		 redirect_to(:controller => "login", :action => "login")
      end 
    else
      flash[:notice] = "Error expected proof and key value.\nPlease log in"
  		redirect_to(:controller => "login", :action => "login")	
    end
  end
  

#  USED FOR STATUS TAB
  def division
    # devices by location
    @list_devices = Device.find_all_by_member_id_and_division_id(@member.id, params[:division] )
    render(:action => "index")
  end  


  def location
    # devices by location
    @list_devices = Device.find_all_by_member_id_and_location(@member.id, params[:location] )
    render(:action => "index")
  end
  
  def locations
    # all devices for this member - set in application.init
    @list_devices = @devices
    render(:action => "index")
  end
  
private
  def key_hash(key)
    string_to_hash = "#{KEY_STRING_PRE}#{key.to_i}#{KEY_STRING_POST}"
    Digest::SHA1.hexdigest(string_to_hash)
  end  
  
end
