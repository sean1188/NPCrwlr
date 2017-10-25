defmodule Scraper do
  def scrape_raw(foo) do
    foo
    |> Enum.at(0) |> elem(2) |> Enum.at(0) 
  end

  def scrape_nested(foo) do
    foo
    |> Enum.at(0) |> elem(2) |> Enum.at(1)  
  end
end