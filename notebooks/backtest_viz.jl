### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 6bac79c0-3736-11eb-3771-ffca15e7cf35
begin
	using JSON
	using Dates
	using Statistics
	using TimeSeries
	using Plots
	plotly()
end

# ╔═╡ 237ea59c-373e-11eb-1c53-e967f659957d
html"""<style>
main {
	max-width: 1200px;
}
"""

# ╔═╡ 1dee7542-3736-11eb-38c0-451dc60635f9
#df = reduce(vcat, DataFrame.(reverse(JSON.parsefile("/home/pdoyle/workspace/DailyStockModel/data/SPY.json")["historical"])))
begin
	json_list = reverse(JSON.parsefile("/home/pdoyle/workspace/DailyStockModel/data/SPY.json")["historical"])
	timestamps = [DateTime(record["date"]) for record in json_list]
	closing_prices = [record["close"] for record in json_list]
	volumes = [record["volume"] for record in json_list]
	data = (datetime = timestamps, close = closing_prices, volume = volumes)
	df = TimeArray(data, timestamp = :datetime)
end

# ╔═╡ 2a37d516-3739-11eb-1ef2-47bc61b0ae2f
begin
	closing_plot = plot(df[:close], label = "SPY",
		lw=1.5, title="SPY ETF", legend=:topleft, size=(1000, 350),
	    ylabel="Closing Price", xlabel="Date")
	
	volume_plot = plot(df[:volume], label = "SPY", color= "green",
		lw=1.5, legend=:topleft, size=(1000, 350),
	    ylabel="Trading Volume", xlabel="Date")
	plot(closing_plot, volume_plot, layout = (2, 1), size=(1000, 700))
end

# ╔═╡ 09993dc0-3740-11eb-0e1d-b7c06ce86530
# I can now act on the dataframe to produce a very simple momentum strategy.
# Pull in the rest of the NYSE and NASDAQ data!
merged_df = merge(df, moving(mean, df[:close], 10))

# ╔═╡ b9ddce9a-37ee-11eb-3215-17125bb4dfca
rename!(merged_df, :close_1 => :ten_day_average)

# ╔═╡ Cell order:
# ╠═6bac79c0-3736-11eb-3771-ffca15e7cf35
# ╠═237ea59c-373e-11eb-1c53-e967f659957d
# ╠═1dee7542-3736-11eb-38c0-451dc60635f9
# ╠═2a37d516-3739-11eb-1ef2-47bc61b0ae2f
# ╠═09993dc0-3740-11eb-0e1d-b7c06ce86530
# ╠═b9ddce9a-37ee-11eb-3215-17125bb4dfca
