## script to analysis flowcell result
# set working directory
setwd('D:/Bioinfo_Analysis/wangshang/Exon_stat')
# prepare library
#BiocManager::install('dplyr')
library('dplyr')
library('ggplot2')
library('tidyr')

# load data
dat1 <- read.table('human_CDS_len_stats.txt',header = TRUE, sep = '\t')
dat2 <- read.table('mouse_CDS_len_stats.txt',header = TRUE, sep = '\t')
datatable <- left_join(dat1, dat2, by = 'Range')
colnames(datatable) <- c('Range', 'Human','Mouse')
datatable$Range <- as.vector(datatable$Range)
datatable$Range[1] <- '0-100  '
datatable$Range[11] <- '>1000  '
datatable$Human <- datatable$Human/sum(datatable$Human)*100
datatable$Mouse <- datatable$Mouse/sum(datatable$Mouse)*100
datatable <- gather(datatable, Species,Value, -Range)
datatable$Range <- factor(datatable$Range, levels = as.vector(datatable$Range[1:11]))
datatable$Value <- round(datatable$Value, 1)
windowsFonts(CA=windowsFont("Calibri")) # windows system

ggplot(datatable, aes(x = Range, y = Value, fill = Species)) +
  geom_bar(stat="identity",width=0.8,position='dodge')+
  geom_text(stat='identity',
            aes(label=Value), color="black", size=7,
            position=position_dodge(0.9),
            vjust = -0.4)+
  labs(title = 'CDS Length distribution', 
     y = 'Frequency(%)', 
     x = '')+
    theme(plot.title = element_text(size = 45,,hjust = 0.5, face = 'bold',family = 'CA'),
        axis.text.x = element_text(size =25, face = 'bold', color = 'black',family = 'CA', angle = 60, vjust = 1.4,hjust = 1.5),
        axis.text.y = element_text(size =25, face = 'bold', color = 'black',family = 'CA', angle =90, hjust = 0.5),
        axis.title.x = element_text(size = 45, face = 'bold',family = 'CA'),
        axis.title.y = element_text(size = 30, face = 'bold',family = 'CA'),
        legend.title = element_blank(),
        legend.text = element_text(size = 30, face = 'bold',family = 'CA'),
        legend.background = element_blank(),
        # legend.key = element_rect(fill = NA, colour = NA, size=1),
        legend.position = c(0.8,0.8))

ggsave("CDS_len_plot.jpg", device = "jpeg", width = 12.5, height = 10, dpi = 300)


