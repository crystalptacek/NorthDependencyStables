#Get glass vessel form data
#clp, 10/25/16
#updated 11/18 for North Dependency Stables, clp


setwd("P:/Projects/2014/North Dependency Stable/R code")

require(RPostgreSQL)

# tell DBI which driver to use
# establish the connection
source('credentials.R')


NDepGlass <-dbGetQuery(DRCcon,'
SELECT
"public"."tblContext"."ContextID",
"public"."tblContext"."QuadratID",
"public"."tblContext"."FeatureNumber",
"public"."tblGlass"."Quantity",
"public"."tblGlassForm"."GlassForm"
FROM
"public"."tblContext"
INNER JOIN "public"."tblContextSample" ON "public"."tblContextSample"."ContextAutoID" = "public"."tblContext"."ContextAutoID"
INNER JOIN "public"."tblGenerateContextArtifactID" ON "public"."tblContextSample"."ContextSampleID" = "public"."tblGenerateContextArtifactID"."ContextSampleID"
INNER JOIN "public"."tblGlass" ON "public"."tblGenerateContextArtifactID"."ArtifactID" = "public"."tblGlass"."ArtifactID"
INNER JOIN "public"."tblGlassForm" ON "public"."tblGlass"."GlassFormID" = "public"."tblGlassForm"."GlassFormID"
WHERE
"public"."tblContext"."ProjectID" = \'52\'
ORDER BY
"public"."tblContext"."ContextID" ASC
')

#Aggregate by Form Types
justform<-aggregate(NDepGlass$Quantity, by=list(NDepGlass$GlassForm), FUN=sum)
colnames(justform)<- c("Form","Count")
