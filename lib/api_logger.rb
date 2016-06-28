class ApiLogger < Grape::Middleware::Base
  
  def before
    Rails.logger.info "params: #{request_params}"
  end
  
private

  def request_log_data
    rack_input = env["rack.input"].gets

    if rack_input.present?
      rack_input = rack_input.gsub("&","%26")
      params_data = Rack::Utils.parse_query(rack_input, "&")
    else
      params_data = nil
    end

    request_data = {
      method: env['REQUEST_METHOD'],
      path:   env['PATH_INFO'],
      query:  env['QUERY_STRING'],
      params: params_data
    }
    # request_data[:user_id] = current_user.id if current_user
    request_data
  end
  
  def request_params
    Rack::Utils.parse_query env["rack.input"].gets, "&" 
  end

end