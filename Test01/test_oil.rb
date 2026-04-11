require 'ferrum'
require 'nokogiri'

browser = Ferrum::Browser.new(timeout: 20)

begin
  puts "Ferrum"
  browser.goto("https://www.bangchak.co.th/th/oilprice/historical")
  sleep 5
  doc = Nokogiri::HTML(browser.body)

  now = Time.now
  current_month = now.strftime('%m')

  i = 0
  loop do
    latest_row = doc.css('table.table--historical-oilprice tbody tr')[i]

    puts latest_row

    if latest_row
      date_text = latest_row.at_css('th')&.text&.strip
      day, month, year = date_text.split('/')
      break if month != current_month
      puts "Date: #{date_text}"

      latest_row.css('td[title]').each do |td|
        puts "Type: #{td['title'].ljust(25)} | Price: #{td.text.strip} บาท"
      end
    end
    i += 1
  end

rescue => e
  puts "Error: #{e.message}"
ensure
  browser.quit
end
