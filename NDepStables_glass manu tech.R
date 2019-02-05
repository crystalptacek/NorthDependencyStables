#Get Glass ManuTech
#clp, 10/24/16
#Updated for North Dependency Stables, 11/18

setwd("P:/Projects/2014/North Dependency Stable/R code")

require(RPostgreSQL)

# tell DBI which driver to use
# establish the connection
source('credentials.R')

NDepGlassManuTech <-dbGetQuery(DRCcon,'
SELECT
"public"."tblContext"."ContextID",
"public"."tblContext"."QuadratID",
"public"."tblContext"."FeatureNumber",
"public"."tblGlass"."Quantity",
"public"."tblGlassManuTech"."GlassManuTech"
FROM
"public"."tblContext"
INNER JOIN "public"."tblContextSample" ON "public"."tblContextSample"."ContextAutoID" = "public"."tblContext"."ContextAutoID"
INNER JOIN "public"."tblGenerateContextArtifactID" ON "public"."tblContextSample"."ContextSampleID" = "public"."tblGenerateContextArtifactID"."ContextSampleID"
INNER JOIN "public"."tblGlass" ON "public"."tblGenerateContextArtifactID"."ArtifactID" = "public"."tblGlass"."ArtifactID"
INNER JOIN "public"."tblGlassManuTech" ON "public"."tblGlass"."GlassManuTechID" = "public"."tblGlassManuTech"."GlassManuTechID"
WHERE
"public"."tblContext"."ProjectID" = \'52\'
ORDER BY
"public"."tblContext"."ContextID" ASC
')

#Aggregate by ManuTech Types
justform<-aggregate(NDepGlassManuTech$Quantity, by=list(NDepGlassManuTech$GlassManuTech), FUN=sum)
colnames(justform)<- c("ManuTech","Count")
