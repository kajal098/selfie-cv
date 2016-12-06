class Admin::GraphsController < Admin::ApplicationController

  before_action :find_graph, only: [:show, :edit, :update, :destroy]

  def index
    @report = GraphReport.new params[:graph_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @graph = Graph.new
  end

  def create
    @graph = Graph.new graph_params
    if @graph.save
      redirect_to admin_graphs_path, notice: "The graph has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @graph.update graph_params
      redirect_to admin_graphs_path, notice: "The graph has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @graph.destroy
      redirect_to admin_graphs_path, notice: "The graph has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_graphs_path, alert: e.message
    end
  end

  def search
  end

  def search_graph
    if !params[:country_name].empty? && !params[:category_name].empty?
          @paytrek_host = 'https://www.google.com/finance/info?q='
          @json_array = {
            "countysensexcode" => params[:country_name],
            "companyscripcode" => params[:category_name]
          } 
          uri = URI.parse(@paytrek_host)
          uri.query = URI.encode_www_form(@json_array)
          http = Net::HTTP.new(uri.host, uri.port)
          request = Net::HTTP::Get.new(uri, 'Content-Language' => 'en-us', 'Content-Type' =>'application/json')
          response = http.request(request)
          redirect_to admin_search_path, notice: "Search done successfully."
    else
      redirect_to admin_search_path, alert: "Something went wrong"
    end  
  end

  

private

  def find_graph
    @graph = Graph.find params[:id]
  end

  def graph_params
    params.require(:graph).permit!
  end

end