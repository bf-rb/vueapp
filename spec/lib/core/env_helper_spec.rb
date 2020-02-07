# frozen_string_literal: true

RSpec.describe VueApp::Core::EnvHelper do
  class Test01
    include VueApp::Core::EnvHelper

    def initialize(env)
      init_env(env)
    end
  end

  context '#init_env' do
    it 'Should be valid' do
      expect(Test01.new(:development).development?).to be(true)
      expect(Test01.new(:test).test?).to be(true)
      expect(Test01.new(:production).production?).to be(true)
    end

    it 'Should raise error' do
      expect { Test01.new(:staging) }.to raise_error(VueApp::Errors::InvalidENV)
    end
  end
end
