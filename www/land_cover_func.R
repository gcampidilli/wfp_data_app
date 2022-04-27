library(ggplot2)
library('viridis')

land_cover_func = function(dat, country) {
  
  dat = subset(dat, element == "area_from_cci_lc")
  dat = dat[order(dat$value, decreasing = T),]
  sum(dat$value, na.rm = T)
  
  # only keep top 4 land cover categories, everything else will be 'other'
  plot_df = dat[1:5,]
  plot_df$item[5] = 'other'
  plot_df$value[5] = sum(dat$value, na.rm = T) - sum(dat$value[1:4], na.rm = T)
  plot_df$value = plot_df$value/100
  plot_df$unit = 'square km'
  plot_df$item = factor(plot_df$item, levels = plot_df$item)  
  
  
  plot =  ggplot(plot_df, aes(x=item, y = value, fill = item)) +
          geom_bar( stat = "identity") +
          scale_fill_viridis(discrete = TRUE, direction=-1) + 
          scale_color_manual(values=c("black", "white")) +
          xlab("") +
          ylab(parse(text='Kilometer ^ 2'))+
          labs(title = "Land cover")+
          theme_bw()+
          theme(legend.position='bottom',
                legend.direction = 'vertical',
                legend.justification = "left",
                axis.line = element_line(color='black'),
                plot.background = element_blank(),
                panel.grid.major = element_line(color='#F5F5F5'),
                panel.grid.minor = element_line(color='#F5F5F5'),
                panel.border = element_blank(),
                axis.text.y = element_text(size = 12),
                axis.title.x=element_blank(),
                axis.text.x=element_blank(),
                axis.ticks.x=element_blank(),
                legend.text = element_text(size=15),
                legend.title = element_blank(),
                axis.title.y = element_text(size = 15),
                plot.title = element_text(hjust = 0.5, size = 25, face = "bold"))

  return(plot)
}






