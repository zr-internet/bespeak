require 'spec_helper'

describe EmailConfiguration do
	it { should respond_to :name }
	it { should respond_to :key }
	it { should respond_to :confirmation_template }
	it { should respond_to :reminder_template }
		
	it { should belong_to :site }
end
