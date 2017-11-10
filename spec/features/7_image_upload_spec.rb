require "rails_helper"

feature "Photos" do
  scenario "new page should have file upload button", points: 1 do
    owner = create(:user)
    login_as(owner, :scope => :user)
    visit "/photos/new"
    expect(page).to have_css("input[type='file']")
  end

  scenario "new page should upload file for photo", points: 2 do
    owner = create(:user)
    login_as(owner, :scope => :user)
    visit "/photos/new"

    fill_in("Caption", :with => 'photogram')
    attach_file("Image", Rails.root + "spec/fixtures/horse.jpg")
    click_on("Create Photo")

    expect(Photo.count).to eq(1)
  end

  scenario "show page should display uploaded photo", points: 2 do
    owner = create(:user)
    login_as(owner, :scope => :user)

    visit "/photos/new"
    fill_in("Caption", :with => 'photogram')
    attach_file("Image", Rails.root + "spec/fixtures/horse.jpg")
    click_on("Create Photo")

    photo = Photo.first

    visit "/photos/#{photo.id}"
    expect(page).to have_css("img[src*='#{photo.image}']")
  end

end
