require 'metrics'

describe Metrics::MachineList do
  subject { described_class.new(data) }

  let(:data) do
    { "machine_1" => "http://mock/metrics/machine_1",
      "machine_2" => "http://mock/metrics/machine_2",
      "machine_3" => "http://mock/metrics/machine_3",
      "machine_4" => "http://mock/metrics/machine_4",
      "machine_5" => "http://mock/metrics/machine_5" }
  end

  context "#entries" do
    its(:count) { should eq(5) }
    its(:any?) { should be_true }
  end

  context "#last" do
    its("last.id") { should eq('machine_5') }
    its("last.url") { should eq('http://mock/metrics/machine_5') }
  end

  context "#metrics" do
    before(:each) do
      subject.stub(:raw_metrics_data).and_return([])
    end
    its(:metrics) { should be_instance_of(Metrics::MetricsList) }
  end
end
