require 'spec_helper'

class UserRoutes < MozNav::Routes::Base
  route_types :profile, :account
end

describe UserRoutes do
  describe '#route_for' do
    it 'returns a lambda that calls the defined route' do
      subject.profile { |id| "/users/profile/#{id}" }
      subject.route_for(:profile).call(17).should == "/users/profile/17"
    end

    it 'raises an appropriate error when no route is found' do
      expect { subject.route_for(:boom) }.to raise_error(ArgumentError)
    end
  end

  describe '#verify_all_routes!' do
    it "does nothing if all route types have been defined" do
      subject.profile { }
      subject.account { }
      subject.verify_all_routes!
    end

    it "raises an error if one or more of the routes are not defined" do
      subject.account { }
      expect {
        subject.verify_all_routes!
      }.to raise_error(MozNav::Routes::Base::UndefinedRouteError)
    end
  end
end
