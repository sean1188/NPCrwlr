defmodule NPCrwlr do

  def update(url \\ "http://eportfolio.ict.np.edu.sg/2017/browsestudent") do
    url
    |> fetch()
    |> Parser.parse_student_portfolio()
    |> Enum.map(&(maps_student_profile(&1)))
    # |> IO.inspect

  end

  defp maps_student_profile(profile) do
    profile_data = 
      profile
      |> fetch()
    profile = profile_data |> Parser.parse_student_profile()
  end

  # Fetch content from page
  defp fetch(nil), do: nil 
  defp fetch(url) do 
    case HTTPoison.get(url, %{}, follow_redirect: true) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> 
        {body, url}
      {:error, error} -> 
        IO.inspect error 
        nil
      _ -> nil
    end
  end


  # Saves all images from an array of urls
  # defp save(urls) do
  #   Enum.each urls, fn x ->
  #     IO.inspect HTTPoison.get!(x)
  #     case HTTPoison.get!(x) do
  #       %HTTPoison.Response{status_code: 200, body: body, request_url: req} -> 
  #         img_name =
  #           ~r/[0-9]{2}/
  #           |> Regex.scan(req)
  #           |> Enum.at(2)
  #           |> Enum.at(0)
          
  #         File.write!("./#{img_name}.png", body)
  #       {:error, error} -> 
  #         IO.inspect error
  #       _ -> IO.puts "no match"

  #     end
  #   end
  # end
      

end
