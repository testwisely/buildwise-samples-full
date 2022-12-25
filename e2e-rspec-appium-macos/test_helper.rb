# require 'rubygems'
require 'appium_lib'
require 'rspec'

# include utility functions such as 'page_text', 'try_for', 'fail_safe', ..., etc.
require "#{File.dirname(__FILE__)}/agileway_utils.rb"

# this loads defined page objects under pages folder
require "#{File.dirname(__FILE__)}/pages/abstract_page.rb"
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| load file }

# The default base URL for running from command line or continuous build process
$BASE_URL = "http://abc"

# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper

  include AgilewayUtils
  if defined?(TestWiseRuntimeSupport)  # TestWise 5+
    include TestWiseRuntimeSupport 
  end

  def site_url(default = $BASE_URL)
    $TESTWISE_PROJECT_BASE_URL || ENV["BASE_URL"] || default
  end
	
	
  def driver
    @driver
  end
  
  
  # got to path based on current base url
  def visit(path)
    driver.get(site_url + path)
  end
  
  def page_text
    driver.find_element(:tag_name => "body").text
  end
  
  def debugging?
    return ENV["RUN_IN_TESTWISE"].to_s == "true" && ENV["TESTWISE_RUNNING_AS"] == "test_case"
  end
  
  ## 
  #  Highlight a web control on a web page,currently only support 'background_color'
  #  - elem,
  #  - options, a hashmap, 
  #      :background_color
  #      :duration,  in seconds 
  #  
  #  Example:
  #   highlight_control(driver.find_element(:id, "username"), {:background_color => '#02FE90', :duration => 5})
  def highlight_control(element, opts={})
    return if element.nil?
    background_color = opts[:background_color] ? opts[:background_color] : '#FFFF99'
    duration = (opts[:duration].to_i * 1000) rescue 2000
    duration = 2000 if duration < 100 || duration > 60000
    driver.execute_script("h = arguments[0]; h.style.backgroundColor='#{background_color}'; window.setTimeout(function () { h.style.backgroundColor = ''}, #{duration})", element)  
  end
  
  # prevent extra long string generated test scripts that blocks execution when running in 
  # TestWise or BuildWise Agent
  def safe_print(str)
    return if str.nil? || str.empty?
    if (str.size < 250)
      puts(str)
      return;
    end
    
    if ENV["RUN_IN_TESTWISE"].to_s == "true" && ENV["RUN_IN_BUILDWISE_AGENT"].to_s == "true"
      puts(str[0..200])
    end
  end
  
  
  ## user defined functions
  #


  def appium_opts
    opts = {
      caps: {
        platformName: 'mac',
        'appium:automationName': 'Mac2',
        'appium:bundleId': 'com.apple.calculator',
      },
        appium_lib: {
          server_url: "http://127.0.0.1:4723",
          wait: 0.1,
        },
        }
        end
end
