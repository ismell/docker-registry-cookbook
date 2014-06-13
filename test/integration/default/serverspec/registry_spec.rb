require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "Docker Registry" do
  it "is listening on port 5000" do
    expect(port(5000)).to be_listening
  end

  it "has a running service of git-daemon" do
    expect(service("gunicorn")).to be_running
  end
end
