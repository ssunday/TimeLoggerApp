require "menu_options/time_logger_menu_option"

describe TimeLoggerMenuOption do

  before do
    @default_option = TimeLoggerMenuOption.new
  end

  it "#execute returns false" do
    expect(@default_option.execute(nil,nil,nil)).to eql false
  end

  it "#to_s returns string" do
    expect(@default_option.to_s).to be_an_instance_of(String)
  end

end
