# BashLogCorrector
Takes corrupted directory structure as input, using grep searches for valid log files, then reformats all log files in date format MM/DD/YYYY to UK Standard format, DD/MM/YYYY and outputs all valid log files in a new directory structure depending on the year and month of the log. 


Usage: 
bash logFileCorrector.sh ./CorruptedDirectoryStructure

To test: 
bash logFileCorrector.sh ./ExampleInputs/test01_in/
