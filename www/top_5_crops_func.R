library(ggplot2)

# element can be "total_population___both_sexes" 'rural_population' 'urban_population' 'total_population___female' 'total_population___male' 
top_5_crops_func = function(dat, country) {
  general_items = c('Cereals, Total', 'Fruit Primary', 'Vegetables Primary', 'Vegetables, fresh nes', 'Pulses nes', 
                    'Pulses, Total', 'Fruit, stone nes', 'Fruit, fresh nes', 'Sugar Crops Primary', "Citrus Fruit, Total",
                    "Fruit, tropical fresh nes", "Fruit, citrus nes", "Treenuts, Total", "Citrus Fruit, Total", 
                    "Vegetables, leguminous nes")
  dat = dat[-c(which(dat$item %in% general_items)),]
  crop_df_area_harvested = dat[which(dat$element == 'area_harvested'),]
  crop_df_area_harvested = crop_df_area_harvested[order(crop_df_area_harvested$value, decreasing = T),]
  crop_df_area_harvested$value = crop_df_area_harvested$value/100
  crop_df_area_harvested$unit = 'square km'
  
  top_5_crops = vector()
  top_5_crops[1] = paste('1. ', crop_df_area_harvested$item[1], ' (', crop_df_area_harvested$value[1], ' square km)', sep = "")
  top_5_crops[2] = paste('2. ', crop_df_area_harvested$item[2], ' (', crop_df_area_harvested$value[2], ' square km)', sep = "")
  top_5_crops[3] = paste('3. ', crop_df_area_harvested$item[3], ' (', crop_df_area_harvested$value[3], ' square km)', sep = "")
  top_5_crops[4] = paste('4. ', crop_df_area_harvested$item[4], ' (', crop_df_area_harvested$value[4], ' square km)', sep = "")
  top_5_crops[5] = paste('5. ', crop_df_area_harvested$item[5], ' (', crop_df_area_harvested$value[5], ' square km)', sep = "")

  return(top_5_crops)
}

