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
    when /the trades\s? page/
      trades_path
    when /the new trade\s? page/
      new_trade_path
    when /Alex's Giroux trade page/
      trade_path(@alex_giroux_trade)
    when /John's Tavares trade page/
      trade_path(@john_tavares_trade)
    when /Matt's McDonagh trade page/
      trade_path(@matt_mcdonagh_trade)
    when /Mike's offer page/
      trade_offer_path(@alex_giroux_trade, @mike_offer_for_alex_giroux)
    when /Matt's offer page/
      trade_offer_path(@matt_mcdonagh_trade, @ryan_offer_for_matt_mcdonagh)
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
