require 'spec_helper'

describe Form do
  it { should respond_to :name }
  it { should respond_to :template }
  it { should respond_to :options }

	it { should belong_to :site }
end
