load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Edit text in Notepad" do
  include TestHelper  # defined in ../test_helper.rb

  before(:all) do
    opts = {
      caps: {
        automationName: "windows",
        platformName: "Windows",
        app: "notepad.exe",
      },
      appium_lib: {
        server_url: "http://127.0.0.1:4723",
        wait: 0.1,
      },
    }

    @driver = Appium::Driver.new(opts).start_driver
  end

  after(:all) do
    @driver.quit unless debugging?
  end

  it "Type text in Notepad" do
    sleep 0.5
    puts Appium::VERSION # appium_lib version, not server version
    puts driver.session_capabilities.inspect
    # Appium v1.0
    # @driver.send_keys("TestWise can run Selenium and Appium tests")

    # Appium v2.0 syntax OK, but key input source type is not supported
    # @driver.key_action.send_keys("Appium driver types in active window").perform
    driver.find_element(:name, "Untitled - Notepad").send_keys("TestWise Cool")
  end

  it "Find main window" do
    # we can't use the name to identify the window, as it changes
    #  driver.find_element(:name, "Untitled - Notepad")
    main_win = @driver.find_element(:class_name, "Notepad")
    puts driver.title # title changed
    main_win.send_keys(" ")
    shall_not_allow { driver.find_element(:name, "Untitled - Notepad") }  # can't find, title changed again 
    main_win = @driver.find_element(:class_name, "Notepad")
    expect(driver.title).to eq("*Untitled - Notepad")
  end

  it "Type text to the top level window" do
    main_win = @driver.find_element(:class_name, "Notepad")
    sleep 1
    puts("Old title: #{driver.title}")
    main_win.send_keys("type in main window")

    new_title = main_win.title
    puts("New title: #{driver.title}")
  end

  it "Type text to the editor control" do
    main_win = @driver.find_element(:class_name, "Notepad")
    editor_ctrl = main_win.find_element(:name, "Text Editor")
    editor_ctrl.send_keys("type in editor")
  end

  it "Select Save Menu" do
    main_win = @driver.find_element(:class_name, "Notepad")
    editor_ctrl = @driver.find_element(:name, "Text Editor")
    editor_ctrl.send_keys("End editing")

    main_win.send_keys([:alt, "f"])
    main_win.send_keys(:down, :down, :down)
    main_win.send_keys(:enter)

    sleep 1
    save_as_win = @driver.find_element(:name, "Save As")
    File.delete("C:\\temp\\foo.txt") if File.exists?("C:\\temp\\foo.txt")
    save_as_win.send_keys("C:\\temp\\foo.txt")
    save_as_win.find_element(:name, "Save").click
  end

  it "Close the app" do
    main_win = @driver.find_element(:xpath, "//Window[@ClassName='Notepad']")
    main_win.send_keys([:alt, :f4])
  end
end
