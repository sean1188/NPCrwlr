defmodule Parser do

  def parse_student_profile(nil), do: [] 

  def parse_student_profile({content, url}) do
    # Scrape dem juicy memes
    student_name = content 
    |> Scraper.scrapes_name()
    |> IO.inspect

    student_desc = content 
    |> Scraper.scrapes_desc()
    # |> IO.inspect
    
    student_job = 
    content 
    |> Scraper.scrapes_job()
    # |> IO.inspect
    
    student_class = 
    content 
    |> Scraper.scrapes_class()
    # |> IO.inspect

    student_skill = 
    content 
    |> Scraper.scrapes_skill()
    # |> IO.inspect

    student_contacts =
    content 
    |> Scraper.scrapes_contacts()
    # |> IO.inspect

    student_image =
    {content, url} 
    |> Scraper.scrapes_image()
    |> IO.inspect
    
    # Package and return
    %{
      name: student_name, 
      class: student_class,
      profession: student_job,
      profile: student_desc,
      skills: student_skill, 
      contacts: student_contacts,
      picture: student_image,
    }

  end

  def parse_student_portfolio(nil), do: [] 
  def parse_student_portfolio({content, _}) do
    content
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> Enum.filter(fn x -> String.starts_with?(x, "/2017/browsestudent/profile?id=") end )
    |> Enum.map(fn x -> "http://eportfolio.ict.np.edu.sg" <> x end )
    # |> Enum.drop(130)

  end

end