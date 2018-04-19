#!/usr/bin/env ruby

require_relative "../common/tools.rb"
require 'restclient'
require 'json'

ip = "localhost" 
ip = "192.168.2.76"

unless ARGV.empty?
  ip = ARGV[0]  
end

class ExamScraper
  attr_accessor :ip, :session_id
  def initialize(ip)
    @ip = ip
    @session_id = get_session_id
  end

  def device_url
    "http://#{@ip}:8100"
  end

  def header
    '-H "Content-Type: application/json"'
  end

  def constants
    "DEVICE_URL=http://#{@ip}:8100;JSON_HEADER='-H \"Content-Type: application/json\"';SESSION_ID=#{@session_id}"
  end

  def wda_command(command)
    puts "============="
    puts command
    res = %x[ #{constants}; #{command} ]
    puts res
    puts "============="
    res
  end

  def get_session_id
    command = 'curl -X GET $JSON_HEADER $DEVICE_URL/status'
    res = wda_command(command)
    JSON.parse(res)["sessionId"]
  end

  def launch
    command = 'curl -X POST $JSON_HEADER -d "{\"desiredCapabilities\":{\"bundleId\":\"com.Csai.CsaiApp\"}}" $DEVICE_URL/session'
    wda_command(command)
  end

  def get_element_id(class_chain)
    command = "curl -X POST $JSON_HEADER -d \"{\\\"using\\\":\\\"class chain\\\",\\\"value\\\":\\\"#{class_chain}\\\"}\" $DEVICE_URL/session/$SESSION_ID/elements"
    res = wda_command(command)
    JSON.parse(res)["value"][0]["ELEMENT"]
  end

  def tap(element_id)
    command = "curl -X POST $JSON_HEADER -d \"\" $DEVICE_URL/session/$SESSION_ID/element/#{element_id}/click"
    wda_command(command)
  end

  def scroll_down(element_id)
    command = "curl -X POST $JSON_HEADER -d \"{\\\"direction\\\":\\\"down\\\"}\" $DEVICE_URL/session/$SESSION_ID/wda/element/#{element_id}/scroll"
    wda_command(command)
  end

  def tap_tab
    element_id = get_element_id "**/XCUIElementTypeTabBar/XCUIElementTypeButton[2]"
    tap element_id
  end

  def tap_day_exam
    element_id = get_element_id "**/XCUIElementTypeScrollView/XCUIElementTypeOther/XCUIElementTypeOther[5]"
    tap element_id
  end

  def drag_table_loading_more
    element_id = get_element_id "**/XCUIElementTypeTable"
    10.times do 
      scroll_down element_id
      sleep(4)
    end
  end

  def run
    
    launch
    sleep(3)
    tap_tab
    sleep(3)
    tap_day_exam
    sleep(3)
    drag_table_loading_more
  end

end

scraper = ExamScraper.new ip
# scraper.launch
scraper.drag_table_loading_more 
