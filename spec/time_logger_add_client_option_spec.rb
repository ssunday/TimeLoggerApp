require "menu_options/time_logger_add_client_option"
require "time_logger_mock_io"
require "time_logger_mock_data_repository"

describe TimeLoggerAddClientOption do

  before do
    @mock_io = TimeLoggerMockIO.new
    @mock_data_repository = TimeLoggerMockDataRepository.new
    @add_client_option = TimeLoggerAddClientOption.new
  end

  it "#to_s returns 'Add Client'" do
    expect(@add_client_option.to_s).to eql "Add Client"
  end

  it "#execute adds client to data repository" do
    @mock_io.client_name = "Foogle"
    username = "jill"
    @add_client_option.execute(@mock_data_repository, @mock_io,"jill")
    expect(@mock_data_repository.client_names).to eql ["Foogle"]
  end

end
