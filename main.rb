require 'sinatra'
require 'puma'

get '/' do

    @today = Time.now.strftime('%Y-%m-%d')

    path_file = File.join(__dir__, "data", "quotes.txt")

    if File.exist?(path_file)
        myfile = File.new(path_file)
        @content = myfile.readlines
        myfile.close
        @sampled_content = @content.sample
    else
        "Файл не знайдено"
    end  

    @title = "Цитата дня: "

    erb :index
end