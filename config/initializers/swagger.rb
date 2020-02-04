# frozen_string_literal: true

GrapeSwaggerRails.options.url = '/swagger_doc'
GrapeSwaggerRails.options.app_name = 'StadiumGoodsApi'
GrapeSwaggerRails.options.before_action do
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
end
