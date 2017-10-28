# Mongodb interface 
defmodule Database do 

  def connect() do
    Mongo.start_link(database: "NPCrwlr")
  end

  def insert_results({_, conn}, data) do
    for i <- data, do: Mongo.insert_one!(conn, "StudentData", i)
  end

  def drop_data({_, conn}) do
    conn
    |> Mongo.delete_many("StudentData", %{})
  end
  

end