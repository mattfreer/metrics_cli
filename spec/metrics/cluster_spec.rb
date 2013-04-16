require 'metrics'

describe Metrics::Cluster do
  subject { described_class.new(:url => url) }

  let(:cluster_data) do
    { "machine_1" => "http://192.168.50.30:4567/metrics/machine_1",
      "machine_2" => "http://192.168.50.30:4567/metrics/machine_2",
      "machine_3" => "http://192.168.50.30:4567/metrics/machine_3",
      "machine_4" => "http://192.168.50.30:4567/metrics/machine_4",
      "machine_5" => "http://192.168.50.30:4567/metrics/machine_5" }
  end

  context "with invalid url" do
    let(:url) { 'foobar.com' }
    its(:url) { should eq('foobar.com') }
    its(:valid?) { should be_false }
  end

  context "with valid url" do
    let(:url) { 'http://www.google.com' }
    its(:url) { should eq('http://www.google.com') }
    its(:valid?) { should be_true }
  end

  context "with valid IP" do
    let(:url) { 'http://192.168.50.30:4567' }
    its(:url) { should eq('http://192.168.50.30:4567') }
    its(:valid?) { should be_true }

    context "#machines" do
      before(:each) do
        subject.stub(:fetch_data).and_return(cluster_data)
      end

      its("machines.count") { should eq(5) }
    end
  end
end
