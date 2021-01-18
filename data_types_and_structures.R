

# constants - unchanging elements in R----
2
"A"

# variables -place-holders to which data can be assigned and changed----
x
y
z
my_number
LETTERS

# Let's assign some data to variables
# Note that x is different from "x" or 'x'

x = 2
y <- 3

x
y
z = x

x = 5

# What is the value of z now?

# Variable names
gene_name_p53 = "TP53"
gene_id_p53 = 7157
is_oncogene_p53 = FALSE
gene_7157 = "TP53"
# 7157_gene = 4 # this won't work because a variable name can't start with a number

# Types of data----
num_participants = 25       # numeric
my_uni = "Oxford"           # character
am_i_happy_today = TRUE     # logical

# Conversion of data types TODO ----

# What is the data type for gene_id below?
gene_id = "7157"
class(gene_id)

# Data Structures----
# Atomic vectors - most basic data type, can be of length => 0
# length 0
num_participants = numeric()
my_uni = character()
am_i_happy_today = logical()

# length 1 - we have done this already!
num_genes = 2

# length > 1 - we need to use the c() function or the : operator for a sequence of numbers
gene_num = 1:4
gene_names = c("TP53", "PTEN", "RB1", "MYC")
gene_ids = c(7157, 5728, 5925, 4609)

# Contents of atomic vectors are of a single type; if not, they are 'coerced'
gene_name_p53 = "TP53"
gene_id_p53 = 7157
is_oncogene_p53 = FALSE
info_p53 = c(gene_name_p53, gene_id_p53, is_oncogene_p53)
info_p53

info_p53 = c(gene_id_p53, is_oncogene_p53)
info_p53

# Subsetting atomic vectors with []
gene_names[1]
gene_names[2:4]
gene_names[c(2,4)]

# lists
info_p53 = list(gene_name_p53, gene_id_p53, is_oncogene_p53)
info_p53

all_genes = list(num = gene_num, name = gene_names, id = gene_ids)
all_genes

# Subsetting lists is slightly different: [] yields a list, [[]] or $ yields an element of a list
all_genes[1]

all_genes[[1]]
all_genes[["name"]]
all_genes$name

# data frames 
all_genes_df = data.frame(num = gene_num, name = gene_names, id = gene_ids)
all_genes_df

# subsetting data frames with [row, column]
all_genes_df[2:3, 1:3]
all_genes_df[2:3, ]
all_genes_df[, 2]
all_genes$name

# Q: Subset all_genes_df for only the 2nd and 3rd rows
all_genes[ , ]

print(gene_names)
length(gene_names)
class(gene_names)
str(gene_names)
