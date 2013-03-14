require 'spec_helper'

describe PaymentProcessor do
	it { should respond_to :name }
	it { should respond_to :login }
	it { should respond_to :key }
	
	it { should belong_to :site }
end