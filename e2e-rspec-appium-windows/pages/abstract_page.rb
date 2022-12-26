class AbstractWindow
  include AgilewayUtils

  if defined?(TestWiseRuntimeSupport) # TestWise 5+
    include TestWiseRuntimeSupport
  end

  attr_accessor :title
  attr_accessor :win_elem

  def initialize(driver, title = "")
    @driver = driver
    if (title && !title.empty?)
      @title = title
      start_time = Time.now
      # too slow with this way: about 100 times slower
      # @win_elem = @driver.find_element(:xpath, "//Window[@Name='#{@title}']")

      try_for(2, 1) { @win_elem = @driver.find_element(:name, @title) }
      puts("Finding window '#{title}' time: #{Time.now - start_time}")
      sleep 0.5
    end
  end

  def driver
    return @driver
  end

  def win
    return @win_elem
  end

  # delegate
  #
  def send_keys(*args)
    win.send_keys(*args)
  end

  def find_element(*args)
    win.find_element(*args)
  end

  def find_elements(*args)
    win.find_elements(*args)
  end

  def click_ok
    win.find_element(:name, "OK").click
  end

  def click_cancel
    win.find_element(:name, "Cancel").click
  end
end

