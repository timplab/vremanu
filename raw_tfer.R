library(tidyverse)
library(googlesheets)

workdir="~/Data/vre"

gs_auth(token = "~/googlesheets_token.rds")

fullsheet=gs_url("https://docs.google.com/spreadsheets/d/1sOa1AP7K9mwNjgPX4qeBbRlqxAa6-gUBazj_QLvcAcE/edit?usp=sharing")
dataloc=gs_read(fullsheet, ws="VRE_0905")


##Transfer data to aws

if (TRUE) {

    dir.create(file.path(workdir), recursive=TRUE)
    
    
    for (i in 1:dim(dataloc)[1]) {
        
        ##ill data			       			
        system(paste0("scp timp@duchess.timplab.com:", dataloc$illumina.r1[i], " ", file.path(workdir, basename(dataloc$illumina.r1[i]))))
        system(paste0("scp timp@duchess.timplab.com:", dataloc$illumina.r2[i], " ", file.path(workdir, basename(dataloc$illumina.r2[i]))))
        ##Nano data
        if(!is.na(dataloc$nanopore.raw[i])) {	
            system(paste0("scp timp@duchess.timplab.com:", dataloc$nanopore.fasta[i], " ", file.path(workdir, basename(dataloc$nanopore.fasta[i]))))
        }
        
    }
}
