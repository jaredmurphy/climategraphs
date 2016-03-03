class DataPointsController < ApplicationController
  before_action :set_data_point, only: [:show, :edit, :update, :destroy]

  # GET /data_points
  # GET /data_points.json
  def index
    @continents = Continent.all 
    @data_points = DataPoint.all

    case params[:continent]
    when "oceania"
	    @oceania = DataPoint.where(continent_id: 1)
	    @years = []
	    @data = []
	    @oceania.each do |dp|
		@years.push(dp.year)
	      @data.push(dp.value)
	    end 
            @title = "Oceanic" 
    when "south_america"

	    @south_america = DataPoint.where(continent_id: 2)
	    @years = []
	    @data = []
	    @south_america.each do |dp|
		@years.push(dp.year)
	      @data.push(dp.value)
	    end 
            @title = "South American" 
        
    when "north_america"

	    @north_america = DataPoint.where(continent_id: 3)
	    @years = []
	    @data = []
	    @north_america.each do |dp|
		@years.push(dp.year)
	      @data.push(dp.value)
	    end 
            @title = "North American" 

    when "europe"

	    @europe = DataPoint.where(continent_id: 4)
	    @years = []
	    @data = []
	    @europe.each do |dp|
		@years.push(dp.year)
	      @data.push(dp.value)
	    end 
            @title = "Europe" 

    when "asia"

	    @asia = DataPoint.where(continent_id: 5)
	    @years = []
	    @data = []
	    @asia.each do |dp|
		@years.push(dp.year)
	      @data.push(dp.value)
	    end 
            @title = "Asian" 

    when "africa"

	    @africa = DataPoint.where(continent_id: 6)
	    @years = []
	    @data = []
	    @africa.each do |dp|
		@years.push(dp.year)
	      @data.push(dp.value)
	    end 
            @title = "African" 
    when "global"

	    @southern = DataPoint.where(continent_id: 7)
	    @southern_data = []
	    @southern.each do |dp|
	      @southern_data.push(dp.value)
	    end    
	    
	    @northern = DataPoint.where(continent_id: 8)
	    @northern_data = []
	    @northern.each do |dp|
	      @northern_data.push(dp.value)
	    end    

	    @global = DataPoint.where(continent_id: 9)
	    @years = [] 
	    @global_data = []
	    @global.each do |dp|
	      @global_data.push(dp.value)
	      @years.push(dp.year)
	    end    
    end
    if params[:continent] == "global"
       
    @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Global Temperature Anomolies from the 20th Century Average")
      #f.xAxis(categories: @oceania_years)
      f.series(name: "Global", yAxis: 0, data: @global_data, color: "#30A9DE",threshold: 0)

      f.series(name: "Southern Hempisphere", yAxis: 0, data: @northern_data, color: "#EFDC05",threshold: 0)
      f.series(name: "Northern Hempisphere", yAxis: 0, data: @southern_data, color: "#E53A40",threshold: 0)
      f.yAxis [
        {title: {text: "Degrees in Celcius", margin: 10} },
      ]
      f.legend(align: 'left', verticalAlign: 'top', y: 50, x: 70, layout: 'vertical', floating: true, backgroundColor: 'white',  enabled: true)
      f.chart({defaultSeriesType: "line"})
      f.options[:xAxis] = {categories: @years,:labels => {step: 5}, title: {text: "Years", margin: 30}}
      f.options[:yAxis] = {gridLineColor: "#197F07", gridLineWidth: 0, lineWidth: 1, plotLines: [{color:'gray', width: 1, value: 0}]}
    end
    else 
      @graph =  LazyHighCharts::HighChart.new('graph') do |f|
	      f.title(text: "#{@title} Temperature Anomolies from the 20th Century Average")
	      #f.xAxis(categories: @oceania_years)
	      f.series(name: "Temperature Anomoly", yAxis: 0, data: @data, color: "#FF0000",threshold: 0,
		negativeColor: '#008c9e')

	      f.yAxis [
		{title: {text: "Degrees in Celcius", margin: 10} },
	      ]
	      f.legend(align: 'center', verticalAlign: 'bottom', y: 0, x: 0, layout: 'vertical', enabled: false)
	      f.chart({defaultSeriesType: "line"})
	      f.options[:xAxis] = {categories: @years,:labels => {step: 5}, title: {text: "Years", margin: 30}}
              f.options[:yAxis] = {gridLineColor: "#197F07", gridLineWidth: 0, lineWidth: 1, plotLines: [{color:'gray', width: 1, value: 0}]}
      end
    end 

    

    respond_to do |format|
      format.html
      format.js
    end
  end # ends index

  # GET /data_points/1
  # GET /data_points/1.json
  def show
  end

  # GET /data_points/new
  def new
    @data_point = DataPoint.new
  end

  # GET /data_points/1/edit
  def edit
  end

  # POST /data_points
  # POST /data_points.json
  def create
    @data_point = DataPoint.new(data_point_params)

    respond_to do |format|
      if @data_point.save
        format.html { redirect_to @data_point, notice: 'Data point was successfully created.' }
        format.json { render :show, status: :created, location: @data_point }
      else
        format.html { render :new }
        format.json { render json: @data_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data_points/1
  # PATCH/PUT /data_points/1.json
  def update
    respond_to do |format|
      if @data_point.update(data_point_params)
        format.html { redirect_to @data_point, notice: 'Data point was successfully updated.' }
        format.json { render :show, status: :ok, location: @data_point }
      else
        format.html { render :edit }
        format.json { render json: @data_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_points/1
  # DELETE /data_points/1.json
  def destroy
    @data_point.destroy
    respond_to do |format|
      format.html { redirect_to data_points_url, notice: 'Data point was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_point
      @data_point = DataPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_point_params
      params.require(:data_point).permit(:year, :value, :continent_id)
    end
end
