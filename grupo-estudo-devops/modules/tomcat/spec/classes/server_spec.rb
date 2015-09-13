require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe 'tomcat::server' do
    it {
        should contain_package('tomcat7').with_ensure('installed')
    }
end
