library(ggplot2)

# element can be "total_population___both_sexes" 'rural_population' 'urban_population' 'total_population___female' 'total_population___male' 
pop_plot_func = function(dat, country, passedElement) {
  dat = subset(dat, element == passedElement)
  dat$value = dat$value/1000
  dat$unit = 'Millions'
  plot = ggplot()+aes(x = year, y = value) +
    geom_line(data = subset(dat, year <= 2021), size = 2.5, colour = "black") +
    geom_line(data = subset(dat, year<=2050), size = 1.5, colour = "black", linetype = "dotted")+
    labs(title = paste("Population of", country, sep=" "), subtitle = "Forecast done by the FAO") + ylab(paste("Population (",unique(dat$unit),")",sep=""))+xlab("")+
    theme_bw() + theme(axis.title.y = element_text(size =15, face = "bold"))+theme(axis.title.x = element_text(size =15, face = "bold"))+
      theme(axis.text.x = element_text(size = 15)) + theme(axis.text.y = element_text(size = 15)) +
      theme(plot.title = element_text(hjust = 0.5, size = 25, face = "bold"),
            plot.subtitle = element_text(hjust = 0.5, size = 15)) 
  return(plot)
}
