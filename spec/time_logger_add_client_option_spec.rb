require "menu_options/time_logger_add_client_option"
require "time_logger_mock_io"
require "time_logger_mock_data_interface"

describe TimeLoggerAddClientOption do

  before do
    @mock_io = TimeLoggerMockIO.new
    @mock_data_interface = TimeLoggerMockDataInterface.new
    @add_client_option = TimeLoggerAddClientOption.new
  end

  it "#to_s returns string" do
    expect(@add_client_option.to_s).to be_an_instance_of(String)
  end

  it "#execute adds client to data repository" do
    @mock_io.client_name = "Foogle"
    username = "jill"
    @add_client_option.execute(@mock_data_interface, @mock_io,"jill")
    expect(@mock_data_interface.get_client_names).to eql ["Foogle"]
  end

end
