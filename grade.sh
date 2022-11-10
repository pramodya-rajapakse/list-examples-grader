# Create your grading script here

rm -rf student-submission
echo "Removed previous directory"
git clone $1 student-submission
echo "cloned student-submission directory"
cd student-submission
echo "moved into student-submission directory"

file=ListExamples.java
echo "assigned file name"

# check if student code has correct file submitted
if [[ -e ListExamples.java ]]
then
	echo "file was found"
else
	echo "file was not found"
	exit
fi

# get student code and your java files into same directory
mkdir test_folder
cp ListExamples.java ../TestListExamples.java test_folder
echo "copied student code and test code into new folder"
cd test_folder
# compile students code and your tests, input redirection, need to change path for junit
javac -cp .:../../lib/hamcrest-core-1.3.jar:../../lib/junit-4.13.2.jar *.java 2> error.txt > out.txt
if [[ $? -eq 0 ]]
then 
	echo "files compiled correctly, exit code 0"
else
	echo "files did not compile"
	cat error.txt
fi

# run java files with junit tests, output redirect into text file
java -cp .:../../lib/hamcrest-core-1.3.jar:../../lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > junit.txt
if [[ $? -eq 0 ]]
then
	echo "ran java files"
else
	echo "error, could not not run java files"
	cat junit.txt
fi
