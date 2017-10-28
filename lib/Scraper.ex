defmodule Scraper do

  defp scrapes_text_fuzzy(content) do 
    content
    |> Floki.text(deep: true, js: false, sep: ", ")
  end

  defp scrapes_text(content) do
    content
    |> Floki.text(deep: false, js: false)
  end

  def scrapes_name(content) do
    content
    |> Floki.find(".sName") 
    |> scrapes_text()
  end

  def scrapes_desc(content) do
    content
    |> Floki.find(".sDesc")
    |> scrapes_text_fuzzy()
  end

  def scrapes_job(content) do
    content
    |> Floki.find(".sJobRole") 
    |> scrapes_text_fuzzy()
  end

  def scrapes_class(content) do
    content
    |> Floki.find(".sCourse") 
    |> scrapes_text()
    |> String.last()
  end

  def scrapes_skill(content) do
    content
    |> Floki.find(".sSkill") 
    |> scrapes_text_fuzzy()
  end

  def scrapes_contacts(content) do
    content
    |> Floki.find(".sContact") 
    |> Floki.find("a") 
    |> Floki.attribute("href")
  end

  def scrapes_image(nil), do: nil
  def scrapes_image({content, _}) do
    content
    |> Floki.find("img")
    |> Floki.attribute("src")
    |> Enum.filter(&(String.starts_with?(&1, "/2017/img/profiles") and !String.ends_with?(&1, "/")))
    |> Enum.map(&("http://eportfolio.ict.np.edu.sg"<>&1))
    |> Enum.at(0)
  end

end