require "rails_helper"

feature "Users:" do

  scenario "show page header have follow/following button", points: 1 do
    user_1 = create(:user)
    user_2 = create(:user)
    login_as(user_1, :scope => :user)
    visit "/users/#{user_2.id}"

    expect(page).to have_css("button", text: 'Follow')
  end

  scenario "In show page after cliking follow button should change to following" do
    user_1 = create(:user)
    user_2 = create(:user)
    user_3 = create(:user)

    login_as(user_1, :scope => :user)
    visit "/users/#{user_2.id}"
    find("button", text: 'Follow').click

    expect(page).not_to have_css("button", text: 'Follow')
    expect(page).to have_css("a", text: 'Following')
  end

  scenario "In show page after cliking following button should change to follow" do
    user_1 = create(:user)
    user_2 = create(:user)
    user_3 = create(:user)

    login_as(user_1, :scope => :user)
    visit "/users/#{user_2.id}"
    find("button", text: 'Follow').click

    find("a", text: 'Following').click

    expect(page).to have_css("button", text: 'Follow')
    expect(page).not_to have_css("a", text: 'Following')
  end

  scenario "show page header have number of post with count", points: 1 do
    user_1 = create(:user)
    user_2 = create(:user)
    login_as(user_1, :scope => :user)
    visit "/users/#{user_2.id}"

    expect(page).to have_css("p", text: 'posts')
  end

  scenario "show page header should display count of followers", points: 1 do
    user_1 = create(:user)
    user_2 = create(:user)
    login_as(user_1, :scope => :user)
    visit "/users/#{user_2.id}"

    expect(page).to have_css("p", text: 'followers')
  end

  scenario "show page header should display count of followed users", points: 1 do
    user_1 = create(:user)
    user_2 = create(:user)
    login_as(user_1, :scope => :user)
    visit "/users/#{user_2.id}"

    expect(page).to have_css("p", text: 'following')
  end

end

feature "Timeline:" do

  scenario "header should display timeline link", points: 1 do
    user = create(:user)
    login_as(user, :scope => :user)
    visit "/"
    within('nav') do
      expect(page).to have_link(nil, href: '/my_timeline')
    end
  end


  scenario "my timeline page should display photos of followed users", points: 5 do
    
  end

end
