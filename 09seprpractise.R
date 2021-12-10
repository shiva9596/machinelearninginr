summary()
getwd()
wbcd <-read.csv("C:/Users/91970/Documents/wisc_bc_data.csv",stringsAsFactors = FALSE)
str(wbcd)
wbcd = wbcd[-1]
table(wbcd$diagnosis)
wbcd$diagnosis = factor(wbcd$diagnosis,levels = c("B","M"), labels = c("Benign","Malignant"))
round(prop.table(table(wbcd$diagnosis))*100,digits=1)

summary(wbcd[c("radius_mean","area_mean","smoothness_mean")])
