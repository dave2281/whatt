require 'sinatra'
require 'puma'

get '/' do

  @today = Time.now.strftime('%Y-%m-%d')

  year_now = Time.now.strftime('%Y')
  month_now = Time.now.strftime('%m')
  day_now = Time.now.strftime('%d')

  day_index = 0
  quotes_index = day_index

  path_file = File.join(__dir__, "data", "quotes.txt")

  File.open('time.txt', 'a') do |file|
    file.puts("#{@today}")
  end
  
  file = File.open('time.txt', 'r')
  lines = file.readline.gsub(/[\n]/, '')
  
  arr = lines.split('-')
  
  year = arr[0]
  month = arr[1]
  day = arr[2]

  loop do 
    if day < day_now
      day_index += 1
    elsif day > day_now 
      day_index -= 1
    elsif day = day_now and quotes_index == day_now
      if File.exist?(path_file)
        myfile = File.new(path_file)
        @content = myfile.readlines
        myfile.close
        quot = @content.sample
        quot_sampled = quot 
      else
        "Файл не знайдено"
      end
      @quot_for_page = quot_sampled[day_now]
      quotes_index += 1
      break
    end
  end
      

  @title = "Цитата дня: "

  erb :index
end