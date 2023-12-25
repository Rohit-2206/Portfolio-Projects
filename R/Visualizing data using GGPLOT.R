library(ggplot2)
library(palmerpenguins)

ggplot(penguins)+
  geom_smooth(mapping=aes(x=flipper_length_mm,y=body_mass_g)) +
  geom_point(mapping=aes(x=flipper_length_mm,y=body_mass_g,
                          color=species,shape=species))

ggplot(penguins)+
  geom_jitter(mapping=aes(x=flipper_length_mm,y=body_mass_g))

