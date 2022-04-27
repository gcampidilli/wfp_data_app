# figure out how to run python script from R

library('reticulate')
use_python("./www/python3")
source_python('./www/outputToTemplate.py')
pdf('download_test.pdf')
convert('./www/sample_output/student_intro.txt')
dev.off()

# make practice into function
