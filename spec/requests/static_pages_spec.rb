require 'spec_helper'

describe "Static pages" do
 
  describe "Home page" do
  	
    it "should have the h1 'Americo'" do
      
      visit '/static_pages/home'
      expect(page).to have_selector('h1', :text => 'Americo')	
    end

    it "should have the right title" do
      visit '/static_pages/home'
      expect(page).to have_title("Americo | Home")
    end

  end 

  describe "Help page" do
  	
    it "should have the h1 'Help'" do
      
      visit '/static_pages/help'
      expect(page).to have_selector('h1', :text => 'Help')	
    end

    it "should have the right title" do
      visit '/static_pages/help'
      expect(page).to have_title("Americo | Help")
    end
 
  end

  describe "About page" do
  	
    it "should have the h1 'About Us'" do
      
      visit '/static_pages/about'
      expect(page).to have_selector('h1', :text => 'About Us')	
    end
    
    it "should have the right title" do
      visit '/static_pages/about'
      expect(page).to have_title("Americo | About Us")
    end

  end

  describe "Contact page" do
  	
    it "should have the h1 'Contact Us'" do
      
      visit '/static_pages/contact'
      expect(page).to have_selector('h1', :text => 'Contact')	
    end
    
    it "should have the right title" do
      visit '/static_pages/contact'
      expect(page).to have_title("Americo | Contact")
    end

  end

end
