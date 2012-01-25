Given /^I have no slides$/ do
  Slide.delete_all
end

Given /^I (only )?have slides titled "?([^\"]*)"?$/ do |only, titles|
  Slide.delete_all if only
  titles.split(', ').each do |title|
    Slide.create(:text => title)
  end
end

Then /^I should have ([0-9]+) slides?$/ do |count|
  Slide.count.should == count.to_i
end
