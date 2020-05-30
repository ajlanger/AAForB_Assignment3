library(dplyr)
library(ggplot2)

cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")



# --------------------------------------------------------------
# Performance comparison on validation data
# --------------------------------------------------------------

df <- tibble(Model=c("LR","NB","MLP"), 
       Accuracy=c(0.6730, 0.6162, 0.6477),
       F1=c(0.6652, 0.6237, 0.6437),
       Kappa=c(0.3679, 0.2906, 0.3259),
       ROC=c(0.7768, 0.7223, 0.7336))

df_long <- tidyr::gather(df, Metric, Performance, Accuracy:ROC, factor_key=TRUE)

ggplot(df_long, aes(x=Metric,y=Performance, fill=Model)) +
  geom_bar(stat="identity", position=position_dodge()) +
  labs(x="Summary Metric") + 
  scale_fill_manual(values=c(cbbPalette[7:8], cbbPalette[4])) + coord_flip()

ggsave("output/figures/performanceS_validation.png", units = "cm", height = 4, width = 14)



# --------------------------------------------------------------
# Performance comparison on test and live predictions
# --------------------------------------------------------------


df <- tibble(Dataset=c("Test","LIve"), 
             Accuracy=c(0.6780, 0.6162),
             F1=c(0.6671, 0.7426),
             Kappa=c(0.3781, 0.2539),
             ROC=c(0.7768, 0.7480))

df_long <- tidyr::gather(df, Metric, Performance, Accuracy:ROC, factor_key=TRUE)


ggplot(df_long, aes(x=Metric,y=Performance, fill=Dataset)) +
  geom_bar(stat="identity", position=position_dodge()) +
  labs(x="Summary Metric") + 
  scale_fill_manual(values=c(cbbPalette[7:8], cbbPalette[4])) + coord_flip()

ggsave("output/figures/performanceS_validation.png", units = "cm", height = 4, width = 14)


