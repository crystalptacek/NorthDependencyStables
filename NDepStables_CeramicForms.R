#Get ceramic form info
#LB, 10.4.16
#clp, 10.24.16 updated for North Dependency

setwd("P:/Projects/2014/North Dependency Stable/R code")

require(RPostgreSQL)

# tell DBI which driver to use
# establish the connection
source('credentials.R')

NDepcerm <-dbGetQuery(DRCcon,'
SELECT
"public"."tblContext"."ContextID",
"public"."tblContext"."QuadratID",
"public"."tblContext"."FeatureNumber",
"public"."tblCeramic"."Quantity",
"public"."tblCeramicVesselCategory"."CeramicVesselCategory",
"public"."tblCeramicForm"."CeramicForm"
FROM
"public"."tblContext"
INNER JOIN "public"."tblContextSample" ON "public"."tblContextSample"."ContextAutoID" = "public"."tblContext"."ContextAutoID"
INNER JOIN "public"."tblGenerateContextArtifactID" ON "public"."tblContextSample"."ContextSampleID" = "public"."tblGenerateContextArtifactID"."ContextSampleID"
INNER JOIN "public"."tblCeramic" ON "public"."tblCeramic"."GenerateContextArtifactID" = "public"."tblGenerateContextArtifactID"."GenerateContextArtifactID"
INNER JOIN "public"."tblCeramicVesselCategory" ON "public"."tblCeramic"."CeramicVesselCategoryID" = "public"."tblCeramicVesselCategory"."CeramicVesselCategoryID"
INNER JOIN "public"."tblCeramicForm" ON "public"."tblCeramicForm"."CeramicFormID" = "public"."tblCeramic"."CeramicFormID"
WHERE
"public"."tblContext"."ProjectID" = \'52\'
ORDER BY
"public"."tblContext"."ContextID" ASC
')


#Subsume some Forms into Form Categories: Table, Utilitarian, and Teawares
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Basket'] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Bottle'] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Jar'] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Storage Jar'] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Tile, fireplace'] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Gaming Piece'] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Bottle, blacking'] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Bowl'] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Bowl, punch'] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Box'] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Castor'] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Chamberpot'] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Coffee Pot'] <- 'Tea'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Colander'] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm =='Cup'] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Drug Jar/Salve Pot']<- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Flower Pot' ] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Jug' ] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Milk Pan' ] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Mold, jelly' ] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Mug/Can' ] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Mustard Pot' ] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Pitcher/Ewer' ] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Plate' ] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Platter' ] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Porringer' ] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Salve Pot' ] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Saucer' ] <- 'Tea'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Sea Kale Pot' ] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Serving Dish, unid.' ] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Storage Vessel' ] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Tankard' ] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Teabowl' ] <- 'Tea'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Teacup' ] <- 'Tea'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Teapot' ] <- 'Tea'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Tureen' ] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Unid: Tableware' ] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Unid: Teaware' ] <- 'Tea'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Unid: Utilitarian' ] <- 'Utilitarian'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Unidentifiable' ] <- 'Unidentifiable'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Vegetable Dish' ] <- 'Table'
NDepcerm$CeramicForm[NDepcerm$CeramicForm == 'Wash Basin' ] <- 'Utilitarian'

#Aggregate by Form Types
justform<-aggregate(NDepcerm$Quantity, by=list(NDepcerm$CeramicForm), FUN=sum)
colnames(justform)<- c("Form","Count")

####Hollow and Flat Tablewares

#Subset all ceramics to get only table wares
NDeptable <- subset(NDepcerm, NDepcerm$CeramicForm  %in%  c('Table'))

#Create new field that combines category and form
NDeptable$FormCat <- paste(NDeptable$CeramicVesselCategory, NDeptable$CeramicForm, sep="_")

#Summarize data by new field of Category and Form
justtable<-aggregate(NDeptable$Quantity, by=list(NDeptable$FormCat), FUN=sum)
colnames(justform)<- c("Form","Count")
