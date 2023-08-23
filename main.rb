require 'sinatra'
require 'puma'

get '/' do
    @today = Time.now.strftime('%Y-%m-%d')

    path_file = File.join(__dir__, "data", "quotes.txt")

    if File.exist?(path_file)
        myfile = File.new(path_file)
        @content = myfile.readlines.sample
        quotAuthor = @content.split('~')
        @author = quotAuthor[1]
        p @author
        @content = quotAuthor[0]
        p @content
        myfile.close
        @content
    else
        "Файл не знайдено"
    end  

    erb :index
end
