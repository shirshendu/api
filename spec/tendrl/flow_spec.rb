require 'spec_helper'

RSpec.describe Tendrl::Flow do
  context 'node' do
    before do
      Tendrl.node_definitions = YAML.load_file(
        'spec/fixtures/definitions/master.yaml'
      )
    end

    it 'ImportCluster' do
      flow = Tendrl::Flow.new(
        'namespace.tendrl',
        'ImportCluster'
      )
      expect(flow.flow_name).to eq('ImportCluster')
      expect(flow.tags({ 'TendrlContext.integration_id' => '12345'})).to eq(['tendrl/integration/12345'])
    end
  end

  context 'cluster' do
    context 'gluster volume' do
      before do
        Tendrl.cluster_definitions = YAML.load_file(
          'spec/fixtures/definitions/gluster.yaml'
        )
      end

      specify 'StartProfiling' do
        flow = Tendrl::Flow.new(
          'namespace.gluster',
          'StartProfiling',
          'Volume'
        )
        expect(flow.flow_name).to eq('StartProfiling')
        expect(flow.tags({ 'TendrlContext.integration_id' => '12345'})).to eq(['provisioner/12345'])
      end

      specify 'StopProfiling' do
        flow = Tendrl::Flow.new(
          'namespace.gluster',
          'StopProfiling',
          'Volume'
        )
        expect(flow.flow_name).to eq('StopProfiling')
        expect(flow.tags({ 'TendrlContext.integration_id' => '12345'})).to eq(['provisioner/12345'])
      end
    end

    context 'ceph' do
      before do
        Tendrl.cluster_definitions = YAML.load_file(
          'spec/fixtures/definitions/ceph.yaml'
        )
      end

      it 'CreatePool' do
        flow = Tendrl::Flow.new(
          'namespace.ceph',
          'CreatePool'
        )
        expect(flow.flow_name).to eq('CreatePool')
        expect(flow.tags('TendrlContext.integration_id' => '12345')).to eq(['tendrl/integration/12345'])
      end
    end
  end
end
