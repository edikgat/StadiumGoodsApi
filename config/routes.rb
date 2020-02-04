# frozen_string_literal: true

Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine, at: '/documentation'
  mount Api::V1 => '/'
end
