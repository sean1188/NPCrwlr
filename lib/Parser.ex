defmodule Parser do

  def parse_student_profile(nil), do: [] 

  def parse_student_profile({content, url}) do
    # Scrape dem juicy memes
    student_name = content |> Floki.find(".sName") 
    |> Scraper.scrape_raw()
    # |> IO.inspect

    student_desc = content |> Floki.find(".sDesc") 
    |> Scraper.scrape_raw()
    # |> IO.inspect
    
    student_job = 
    content |> Floki.find(".sJobRole") 
    |> Scraper.scrape_raw()
    # |> IO.inspect
    
    student_course = 
    content |> Floki.find(".sCourse") 
    |> Scraper.scrape_nested()
    # |> IO.inspect

    student_skill = 
    content |> Floki.find(".sSkill") 
    |> Scraper.scrape_nested()
    # |> IO.inspect

    student_contacts =
    content 
    |> Floki.find(".sContact") 
    |> Floki.find("a") 
    |> Floki.attribute("href")
    # |> IO.inspect

    student_image =
    {content, url} 
    |> parse_profile_image()
    |> IO.inspect

  end

  def parse_student_portfolio(nil), do: [] 

  def parse_student_portfolio({content, url}) do
    content
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> Enum.filter(fn x -> String.starts_with?(x, "/2017/browsestudent/profile?id=") end )
    |> Enum.map(fn x -> "http://eportfolio.ict.np.edu.sg" <> x end )

  end

  def parse_profile_image(nil), do: []

  def parse_profile_image({content, url}) do
    content
    |> Floki.find("img")
    |> Floki.attribute("src")
    |> Enum.filter(&(String.starts_with?(&1, "/2017/img/profiles") and !String.ends_with?(&1, "/")))
    |> Enum.map(&("http://eportfolio.ict.np.edu.sg"<>&1))
  end

end