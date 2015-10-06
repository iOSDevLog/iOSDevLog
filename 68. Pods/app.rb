require 'sinatra'
require 'pathname'
require 'cocoapods'
require 'cocoapods-core'
require 'colored'
require 'active_support/all'

# This expects the CocoaPods Specs repository to be in the same directory as the app.

PAGE_SIZE = 20

SPECS = []
Dir.glob('/Users/jiaxianhua/.cocoapods/repos/master/Specs/**/**/*.json') do |spec_path|
    spec = Pod::Spec.from_file(spec_path)
    SPECS << spec if spec.safe_to_hash?
end

NUMBER_OF_PAGES = (SPECS.count.to_f / PAGE_SIZE).ceil

get '/specs' do
    page = [params[:page].to_i, 0].max
    start_range = page * PAGE_SIZE
    end_range = start_range + PAGE_SIZE
    { :result => SPECS[start_range..end_range],
        :number_of_pages => NUMBER_OF_PAGES
    }.to_json
end
