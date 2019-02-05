#Get brick/daub data
#clp, 10/25/16
#Updated for North Dependency Stables, 11/18 clp

setwd("P:/Projects/2014/North Dependency Stable/R code")

require(RPostgreSQL)

# tell DBI which driver to use
# establish the connection
source('credentials.R')

NDepBrkDaub <-dbGetQuery(DRCcon,'
SELECT
"public"."tblContext"."ContextID",
"public"."tblContext"."QuadratID",
"public"."tblContext"."FeatureNumber",
"public"."tblGenArtifact"."Quantity",
"public"."tblGenArtifact"."Weight"
FROM
"public"."tblContext"
INNER JOIN "public"."tblContextSample" ON "public"."tblContextSample"."ContextAutoID" = "public"."tblContext"."ContextAutoID"
INNER JOIN "public"."tblGenerateContextArtifactID" ON "public"."tblContextSample"."ContextSampleID" = "public"."tblGenerateContextArtifactID"."ContextSampleID"
INNER JOIN "public"."tblGenArtifact" ON "public"."tblGenerateContextArtifactID"."ArtifactID" = "public"."tblGenArtifact"."ArtifactID"
INNER JOIN "public"."tblGenArtifactForm" ON "public"."tblGenArtifact"."GenArtifactFormID" = "public"."tblGenArtifactForm"."GenArtifactFormID"
WHERE
"public"."tblContext"."ProjectID" = \'52\' AND
"public"."tblGenArtifactForm"."GenArtifactForm" LIKE \'Brick%\'
ORDER BY
"public"."tblContext"."ContextID" ASC
')

sum(NDepBrkDaub$Quantity)
sum(NDepBrkDaub$Weight)
