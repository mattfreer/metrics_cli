require 'metrics'

describe Metrics::MetricsList do
  subject { described_class.new(data) }

  let(:data) do
    [
      {"id" => "machine_1", "metrics" => {"metric_1" => 1, "metric_2" => 1}},
      {"id" => "machine_2", "metrics" => {"metric_1" => 2, "metric_2" => 4}},
      {"id" => "machine_3", "metrics" => {"metric_1" => 3, "metric_2" => 9}},
      {"id" => "machine_4", "metrics" => {"metric_1" => 4, "metric_2" => 16}},
      {"id" => "machine_5", "metrics" => {"metric_1" => 5, "metric_2" => 25}}
    ]
  end

  context "#entries" do
    it { subject.count.should eq(5) }
    it { subject.any?.should be_true }
  end

  context "#last" do
    it { subject.last["metric_1"].should eq(5) }
    it { subject.last["metric_2"].should eq(25) }
  end

  context "#metric_keys" do
    its("metric_keys.count") { should eq(10) }
  end

  context "#uniq_metric_keys" do
    its("uniq_metric_keys.count") { should eq(2) }
  end

  context "#key_count" do
    its("key_count") { should eq({"metric_1" => 5, "metric_2" => 5 }) }
  end

  context "#values_by_metric" do
    it { subject.values_by_metric("metric_1").should eq([1,2,3,4,5]) }
    it { subject.values_by_metric("metric_2").should eq([1,4,9,16,25]) }
  end

  context "#standard_deviation_for_metric" do
    it { subject.standard_deviation_for_metric("metric_1").should eq(1.58) }
    it { subject.standard_deviation_for_metric("metric_2").should eq(9.67) }
  end

  context "#index_of_minimum" do
    it { subject.index_of_minimum("metric_1").should eq(0) }
    it { subject.index_of_minimum("metric_2").should eq(0) }
  end

  context "#index_of_maximum" do
    it { subject.index_of_maximum("metric_1").should eq(4) }
    it { subject.index_of_maximum("metric_2").should eq(4) }
  end

  context "#summary" do
    its(:summary) { should eq(
      [
        {:METRIC=>"metric_1", :NUM=>5, :MINIMUM=>"machine_1", :MAXIMUM=>"machine_5", :STD=>1.58},
        {:METRIC=>"metric_2", :NUM=>5, :MINIMUM=>"machine_1", :MAXIMUM=>"machine_5", :STD=>9.67}
      ]
    )}
  end
end
