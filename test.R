# test - workshop


library(OmnipathR)
#browseVignettes("OmnipathR")

##### DBs:

# Network (interactions)
# Enzyme-substrate relationships (enzsub)
# Protein complexes (complexes)
# Annotations (annotations)
# Intercellular communication roles (intercell)



##### 1. GENE REGULATORY INTERACTIONS
# Not individual interactions but resource are classified into the datasets above, so these can overlap. Each interaction type and dataset has its dedicated function in OmnipathR, above we provide links to their help pages. As an example, let’s see the gene regulatory interactions:



gri <- import_transcriptional_interactions()

## Warning: One or more parsing issues, call `problems()` on your data frame for details, e.g.:
##   dat <- vroom(...)
##   problems(dat)

dat <- vroom(...)
problems(dat)

gri


# 
# 3.1.1.1 Igraph integration
# 
library(igraph)
# The network data frames can be converted to igraph graph objects, so you can make use of the graph and visualization methods of igraph:
gr_graph <- interaction_graph(gri)
gr_graph

class(gr_graph)

# ### option 1 - useless. too big
# layout <- layout_with_fr(gr_graph)
# plot(gr_graph, layout = layout, vertex.label = V(gr_graph)$Name, vertex.size = 30)

 
paths <- find_all_paths(
  graph = gr_graph,
  start = c('EGFR', 'STAT3'),
  end = c('AKT1', 'ULK1'),
  attr = 'name'
)

paths

#As this is a gene regulatory network, the paths are TFs regulating the transcription of other TFs.


## 3.1.2 Enzyme-substrate relationships

enz_sub <- import_omnipath_enzsub()
enz_sub


#This data frame also can be converted to an igraph object:
  
es_graph <- enzsub_graph(enz_sub)
es_graph

#It is also possible to add effect signs (stimulatory or inhibitory) to enzyme-PTM relationships:

es_signed <- get_signed_ptms(enz_sub)

## 3.1.3 Protein complexes
cplx <- import_omnipath_complexes()
cplx
# The resulted data frame provides the constitution and stoichiometry of protein complexes, with references.


# 3.1.4 Annotations
# The annotations query type includes a diverse set of resources (about 60 of them), about protein function, localization, structure and expression. For most use cases it is better to convert the data into wide data frames, as these correspond to the original format of the resources. If you load more than one resources into wide data frames, the result will be a list of data frames, otherwise one data frame. 
#See a few examples with localization data from UniProt, tissue expression from Human Protein Atlas and pathway information from SignaLink:

uniprot_loc <- import_omnipath_annotations(
  resources = 'UniProt_location',
  wide = TRUE
)
uniprot_loc


#The entity_type field can be protein, mirna or complex. Protein complexes mostly annotated based on the consensus of their members, we should be aware that this is an in silico inference.

#In case of spelling mistake either in parameter names or values OmnipathR either corrects the mistake or gives a warning or error:
  
uniprot_loc <- import_omnipath_annotations(
    resources = 'Uniprot_location',
    wide = TRUE
  )

## Warning in omnipath_check_param(param): The following resources are not available: Uniprot_location. Check
## the resource names for spelling mistakes.

#Above the name of the resource is wrong. If the parameter name is wrong, it throws an error:
  
uniprot_loc <- import_omnipath_annotations(
    resuorces = 'UniProt_location',
    wide = TRUE
  )


#Singular vs. plural forms and a few synonyms are automatically corrected:

uniprot_loc <- import_omnipath_annotations(
  resource = 'UniProt_location',
  wide = TRUE
)

#Another example with tissue expression from Human Protein Atlas:

hpa_tissue <- import_omnipath_annotations(
  resources = 'HPA_tissue',
  wide = TRUE,
  # Limiting to a handful of proteins for a faster vignette build:
  proteins = c('DLL1', 'MEIS2', 'PHOX2A', 'BACH1', 'KLF11', 'FOXO3', 'MEFV')
)
hpa_tissue

#And pathway annotations from SignaLink:

slk_pathw <- import_omnipath_annotations(
  resources = 'SignaLink_pathway',
  wide = TRUE
)
slk_pathw
