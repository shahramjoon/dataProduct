library(reshape2)
wd.datapath = paste0(getwd(),"/data")
wd.init = getwd()
setwd(wd.datapath)





fertility <- read.table("fertility.csv", 
                        sep=",", 
                        header=TRUE, 
                        na.strings=c("NA","#DIV/0!", ""), 
                        stringsAsFactors=FALSE,
                        fileEncoding="latin1")

setwd(wd.init)


country <- unique(fertility[fertility$Notes=="c", c("Area")])
region <- unique(fertility[is.na(fertility$Notes), c("Area")])

fertility$Notes <- factor(fertility$Notes)
fertility$Period <- factor(fertility$Period)
fertility$Variant <- NULL
fertility <- fertility [1:2814,]
country <- sort(country)
region <- sort(region)

data <- melt (fertility, id.vars=c("Area","Period") ,
              measure.vars=c("g15_19","g20_24", "g25_29", "g30_34", "g35_39", "g40_44", "g45_49"), 
              variable.name="agegroup", value.name="cnt")


summarydata <- ddply ( data, c("Area", "Period"), summarise, total=sum(cnt))

#p <- ggplot(t , aes(x=Period, y=cnt, group=agegroup))+
#  geom_line(aes(group=agegroup, color=agegroup)) + geom_point(aes(group=agegroup, color=agegroup)) + 
#  labs ( x="Period", y="Number of Births")+
#  stat_summary(aes(colour="Mean",shape="Mean",group=1), fun.y=mean, geom="line", size=1.1)+
#  ggtitle("Births By Five-Year Age Group of Mother, Major Area, Region or Country 1950-2010")+
#  theme(panel.grid.major = element_blank(),
#        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
#        axis.title = element_text(face = "bold", size = 10))