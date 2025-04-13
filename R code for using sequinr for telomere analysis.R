# Telomeric Repeat Analysis in Chromosome Sequences
# Author: Jyothi Swaroop C

# Load required library
library("seqinr")

# Read the chromosome sequence in FASTA format
# Make sure the "chromosome.fasta" file is in your working directory
sequence <- read.fasta(file = "chromosome.fasta")

# Convert sequence to uppercase string
seq_str <- toupper(paste(sequence[[1]], collapse = ""))

# Define telomeric repeat patterns
forward_repeat <- "TTAGGG"
reverse_repeat <- "GGGATT"
forward_comp <- "AATCCC"
reverse_comp <- "CCCTAA"

# Find positions of each repeat type in the sequence
forward_pos <- gregexpr(forward_repeat, seq_str)[[1]]
reverse_pos <- gregexpr(reverse_repeat, seq_str)[[1]]
forward_comp_pos <- gregexpr(forward_comp, seq_str)[[1]]
reverse_comp_pos <- gregexpr(reverse_comp, seq_str)[[1]]

# Count occurrences (exclude -1 which indicates no match)
repeat_data <- data.frame(
  RepeatType = c("Forward", "Reverse", "Forward Complement", "Reverse Complement"),
  Count = c(
    sum(forward_pos > 0),
    sum(reverse_pos > 0),
    sum(forward_comp_pos > 0),
    sum(reverse_comp_pos > 0)
  )
)

# Export result to a CSV file
write.csv(repeat_data, "telomeric_repeat_counts.csv", row.names = FALSE)

# Generate a bar chart for visual representation
barplot(
  repeat_data$Count,
  names.arg = repeat_data$RepeatType,
  col = "skyblue",
  main = "Telomeric Repeat Counts",
  xlab = "Repeat Type",
  ylab = "Count"
)
