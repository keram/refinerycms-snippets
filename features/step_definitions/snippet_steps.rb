Given /^I have no snippets$/ do
  Snippet.delete_all
end

Given /^I (only )?have snippets titled "?([^\"]*)"?$/ do |only, titles|
  Snippet.delete_all if only
  titles.split(', ').each do |title|
    Snippet.create(title: title)
  end
end

Then /^I should have ([0-9]+) snippets?$/ do |count|
  Snippet.count.should == count.to_i
end
