module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the About Us\s?page/
      about_path
    when /Egan's details\s?page/
      user_path(@alex)
    when /edit Egan's\s?record/
      edit_user_path(@alex)
    when /the new user\s?page/
      new_user_path
    when /the login\s? page/
      login_path
    when /log out\s?/
      logout_path
    when /the teams\s?page/
      teams_path
    when /the Flyers\s? page/
      team_path(@flyers)
    when /Giroux's\s? page/
      player_path(@giroux)
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
