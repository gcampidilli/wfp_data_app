
# element can be "total_population___both_sexes" 'rural_population' 'urban_population' 'total_population___female' 'total_population___male' 
urban_rural_func = function(dat, country) {
  dat <- population_all_data[toupper(population_all_data$area)==toupper(country),][c(6,8:10)]
  dat = dat[which(dat$element %in% c('rural_population', 'urban_population')),]
  dat_recent_year = dat[which(dat$year == 2019),]
  rural_pop = dat_recent_year[which(dat_recent_year$element == 'rural_population'),]$value
  urban_pop = dat_recent_year[which(dat_recent_year$element == 'urban_population'),]$value
  
  rural_percent = round((rural_pop/(rural_pop+urban_pop))*100, digits = 2)
  urban_percent = round((urban_pop/(rural_pop+urban_pop))*100, digits = 2)
  
  plot_df = data.frame(population = c('Rural','Urban'), percent = c(rural_percent, urban_percent))
  
  plot = ggplot(plot_df, aes(x="", y = percent, fill = population))+
    geom_col(color='black') +
    geom_text(aes(label = paste(population,paste(percent,'%',sep=''),sep='\n')),
              position = position_stack(vjust = 0.5), size = 6) +
    coord_polar(theta = "y") +
    theme_void() +
    theme(legend.position="none") +
    theme(plot.title = element_text(hjust = 0.5, size = 20, face = "bold"))+
    scale_fill_manual(values=c('#daea81', '#c8ddeb'))
  
  return(plot)
}

urban_rural_vec = function(dat, country) {
  dat <- population_all_data[toupper(population_all_data$area)==toupper(country),][c(6,8:10)]
  dat = dat[which(dat$element %in% c('rural_population', 'urban_population')),]
  dat_recent_year = dat[which(dat$year == 2019),]
  rural_pop = dat_recent_year[which(dat_recent_year$element == 'rural_population'),]$value
  urban_pop = dat_recent_year[which(dat_recent_year$element == 'urban_population'),]$value
  
  rural_percent = round((rural_pop/(rural_pop+urban_pop))*100, digits = 2)
  urban_percent = round((urban_pop/(rural_pop+urban_pop))*100, digits = 2)
  
  return(as.character(c(urban_percent, rural_percent)))
}
