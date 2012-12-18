require 'spec_helper'

describe "Static pages" do

  subject { page }
  
  describe "Contact page" do
    before { visit contact_path }
    
    it { should have_link("info@sharethelot.com", href: "mailto:info@sharethelot.com")}
  end
end
