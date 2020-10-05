> energy <- read.csv("Downloads/annual_generation_state_2019.csv", head = TRUE)

> energy_by_source <- energy %>% group_by(state) %>% filter(type_of_producer == "Total Electric Power Industry" & energy_source != "Total") %>% mutate(total_generation_mwh = sum(generation_mwh))

> energy_by_source_summary <- energy_by_source %>% group_by(state, energy_source) %>% summarize(generation_percent_by_energy_source = (generation_mwh/total_generation_mwh)*100)

# Change order of the state levels by the generation_percent_by_energy_source value for coal

> energy_by_source_summary$state = factor(energy_by_source_summary$state, levels = rev(levels(reorder(energy_by_source_summary[energy_by_source_summary$energy_source == "Coal",]$state,energy_by_source_summary[energy_by_source_summary$energy_source=="Coal",]$generation_percent_by_energy_source))))

# Add a column with lifecycle carbon by energy source.  Data from two references (see below)

> energy_by_source_summary <- energy_by_source_summary %>% mutate(lifecycle_co2_emissions_grams_per_kwh = ifelse(energy_source == "Coal", 943, ifelse(energy_source == "Geothermal", 13, ifelse(energy_source == "Hydroelectric Conventional", 11, ifelse(energy_source == "Natural Gas", 599, ifelse(energy_source == "Nuclear", 20, ifelse(energy_source == "Other", 1, ifelse(energy_source == "Other Biomass", 43, ifelse(energy_source == "Other Gases", 599, ifelse(energy_source == "Petroleum", 738, ifelse(energy_source == "Pumped Storage", 1, ifelse(energy_source == "Solar Thermal and Photovoltaic", 38, ifelse(energy_source == "Wind", 25, ifelse(energy_source == "Wood and Wood Derived Fuels", 43, 1))))))))))))))

> energy_by_source_summary <- energy_by_source_summary %>% mutate(lifecycle_co2_combined = lifecycle_co2_emissions_grams_per_kwh*(generation_percent_by_energy_source/100))

> energy_by_source_summary_per_kwh <- energy_by_source_summary %>% group_by(state) %>% summarize(lifecycle_co2_combined_per_kwh = sum(lifecycle_co2_combined))

> energy_by_source_summary_per_kwh %>% filter(state != "US-Total") %>% ggplot(aes(x = state, y = lifecycle_co2_combined_per_kwh)) + geom_point() + labs(title = "Average Lifecycle Carbon per kWh by State", y = "Average Grams of CO2 per kWh", x = "State")

> mycolors <- colorRampPalette(brewer.pal(8, "RdYlBu"))(13)

> energy_by_source_summary %>% filter(energy_source != "Total" & state != "US-Total") %>% ggplot(aes(x = state, y = generation_percent_by_energy_source)) + geom_bar(aes(fill = energy_source), stat = "identity") + scale_fill_manual(values = mycolors) + theme(axis.text.x = element_text(colour = "black", angle = 45, hjust = 1)) + labs(title = "Distribution of Energy by Source per State", y = "Energy Generation (%)", fill = "Energy Source")

> energy_by_source_summary %>% filter(energy_source != "Total" & state != "US-Total") %>% ggplot(aes(x = state, y = generation_percent_by_energy_source)) + geom_bar(aes(fill = energy_source), stat = "identity") + geom_point(data = subset(energy_by_source_summary_per_kwh, state != "US-Total"), aes(y = (lifecycle_co2_combined_per_kwh)/10, x = state)) + scale_fill_manual(values = mycolors) + scale_y_continuous(sec.axis = sec_axis(~.*10, name = "Average Grams of CO2 per kWh per State")) + theme(axis.text.x = element_text(colour = "black", angle = 45, hjust = 1)) + labs(title = "Distribution of Energy by Source per State", y = "Energy Generation (%)", x = "State", fill = "Energy Source")
