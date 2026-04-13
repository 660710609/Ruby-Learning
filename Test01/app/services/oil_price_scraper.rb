require "ferrum"
require "nokogiri"

class OilPriceScraper
  URL = "https://www.bangchak.co.th/th/oilprice/historical"

  def self.call
    browser = Ferrum::Browser.new(timeout: 30, window_size: [ 1920, 1080 ])
    line_service = LineMessagingService.new
    summary_message = ""

    begin
      browser.goto(URL)
      sleep 5
      doc = Nokogiri::HTML(browser.body)

      current_month = Time.now.strftime("%m")
      i = 0

      loop do
        row = doc.css("table.table--historical-oilprice tbody tr")[i]
        break if row.nil?

        date_text = row.at_css("th")&.text&.strip
        day, month, year = date_text.split("/")

        break if month != current_month

        target_date = Date.new(year.to_i - 543, month.to_i, day.to_i)

        row.css("td[title]").each do |td|
          fuel_name = td["title"].strip
          price_value = td.text.strip.to_f

          OilPrice.find_or_create_by!(
            date: target_date,
            fuel_type: fuel_name
          ) do |record|
            record.price = price_value
          end
        end

        i += 1
      end
      current_price = OilPrice.order(date: :desc, id: :asc).limit(7)
      message = current_price.map do |oil|
        "#{oil.fuel_type} ราคา ณ วันที่ #{oil.date} อยู่ที่ #{oil.price} บาท"
      end.join("\n")

      summary_message = "รวมราคาน้ำมันล่าสุด : \n #{message}"
      line_service.send_text(summary_message)
      status_scraper = "Scraping Complete at #{Time.now}"
      puts status_scraper
      Rails.logger.info status_scraper
      { success: true, message: status_scraper }

    rescue => e
      Rails.logger.error "OilPriceScraper Error: #{e.message}"
      "Error: #{e.message}"
      line_service.send_text(e.message)
    ensure
      browser.quit
    end
  end
end
