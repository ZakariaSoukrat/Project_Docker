FROM python:3.13-rc-slim

RUN apt-get update && apt-get install -y apache2-utils

# Set the working directory inside the container
WORKDIR /seed

# Copy files into the container
COPY . .

# Make the generate-votes.sh script executable
RUN chmod +x ./generate-votes.sh

#when using a windows system we got the error message $'\r': command not found 
#which typically indicates an issue with line endings in a shell script. 
#It seems that the shell script generate-votes.sh has Windows-style line endings (\r\n) instead of Unix-style line endings (\n).
#To fix this issue, you can convert the line endings of the shell script to Unix format. 
#We can use the dos2unix command-line tool to accomplish this.
#If you use a linux system you can optionly comment the next line
RUN apt-get install dos2unix && dos2unix ./generate-votes.sh

# Run the make-data.py script to generate data before starting the service
RUN  python3 make-data.py

# Set the entrypoint to execute the generate-votes.sh script when starting the container
CMD ["bash", "./generate-votes.sh"]
