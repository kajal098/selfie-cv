namespace :graphapi do

	task fetch: :environment do
		@stock = CompanyStock.first
        @host = 'https://www.google.com/finance/info'
        @json_array = {
            "q" => @stock.sensex + ":" + @stock.company_code
        } 
        uri = URI.parse(@host)
        uri.query = URI.encode_www_form(@json_array)
        http = Net::HTTP.new(uri.host, uri.port)      
        http.use_ssl = true          
        request = Net::HTTP::Get.new(uri, 'Content-Language' => 'en-us')
        response = http.request(request)
        @parsed_response = JSON.parse(response.body.gsub('//',''))
        puts @parsed_response
        @api = Graphapi.new
        @api.api_id = @parsed_response[0]['id']
	    @api.symbol = @parsed_response[0]['t']
	    @api.index = @parsed_response[0]['e']
	    @api.lasttradetime = @parsed_response[0]['ltt']
	    @api.lasttradedatetime = @parsed_response[0]['lt_dts']
	    @api.lasttradetimelong = @parsed_response[0]['lt']
	    @api.change = @parsed_response[0]['c']
	    @api.changePercent = @parsed_response[0]['cp']
	    @api.previouscloseprice = @parsed_response[0]['pcls_fix']
		@api.save
	end

end
