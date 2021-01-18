# testing the truth value of an expression ----
1 < 2
34 > 35
1 <= (2/2)
1 >= (2/2)
"A" == "B"
"TP53" == toupper("tp53")
"A" %in% LETTERS

goi_name = "PTEN"
if(goi_name %in% gene_names) {
  print("The gene of interest is in the gene set")
}



# the while loop performs an action as long as a condition is true ----
am_i_happy_today = TRUE
while(am_i_happy_today) {  # an infinite loop
  print("happy")
}

while(am_i_happy_today) {  # a loop that runs only once
  print("happy")
  am_i_happy_today = FALSE
}

counter = 1
while(counter <= 20) {
  print(counter)
  counter = counter + 1
}

index = 1
while(index < 27) {
  new_text = paste("letter", index, "is", LETTERS[index])
  print(new_text)
  index = index + 1
}

# the for loop iterates over a vector or a list ----
# perform an action over every item
gene_names = c("TP53", "PTEN", "RB1", "MYC")
for(each_item in gene_names) {
  each_item_lcase = tolower(each_item)
  print(each_item_lcase)
}

