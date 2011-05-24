class ProofsController < ApplicationController
  include NumberFormulas  # mix-in from /lib
  before_filter 	:authorize
  
  def index
  end
  
  def device_quantities
    @date_filter.chart_type = 'Column3D.swf'
    @sticker_count = Device.device_sticker_quantities(@date_filter)
    @measurement_count = Device.device_measurements(@date_filter )
    @measurement_pass_count = Device.device_measurements(@date_filter, {:pass => 'Pass'} )
    @measurement_pass_percent = (format_num((@measurement_pass_count.to_f / @measurement_count.to_f),2) * 100).to_i
    @sq_inches_of_paper = Device.device_proofs_size(@date_filter)
  	render(:action => "index")
  end
  
  def device_de_histogram
    @date_filter.chart_type = 'Bar2D.swf'
  	render(:action => "index")    
  end
  
  def patch_de
    @date_filter.chart_type = 'Bar2D.swf'
  	render(:action => "index")    
  end
   
  def patch_lab 
    @date_filter.chart_type = '' 
    if @date_filter.profile
  	  @patches = Patch.lab_proof_avg(@date_filter)
  	end    
  end     
    
  def device_de
    @date_filter.chart_type = 'Column3D.swf'
  	render(:action => "index")
  end
  
  def profile_de
    @date_filter.chart_type = 'Column3D.swf'
  	render(:action => "index")
  end
  
  def location_de
    @date_filter.chart_type = 'Column3D.swf'
  	render(:action => "index")
  end
  
  def operator_de
    @date_filter.chart_type = 'Column3D.swf'
  	render(:action => "index")
  end

  def set_t_rgb
    limit = 1000
    limit = params[:limit] if params[:limit]
    @patches = Patch.find_t_rgb_is_null(limit)
    @patches.each do |patch|
      patch.update_rgb
    end
    
    render(:text => Patch.find_t_rgb_remaining_to_convert )
  end

# Analysis
  def location_pass_fail
    @date_filter.chart_type = 'Column3D.swf'
    render(:action => "index")
  end
  
  def device_pass_fail
    @date_filter.chart_type = 'Column3D.swf'
    render(:action => "index")
  end
  
  def profile_pass_fail
    @date_filter.chart_type = 'Column3D.swf'
    render(:action => "index")
  end

  def operator_pass_fail
    @date_filter.chart_type = 'Column3D.swf'
    render(:action => "index")
  end

private

end
