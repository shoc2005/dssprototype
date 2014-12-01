INSTALATION INSTRUCTIONS

====REQUREMENTS====

Database: PostgreSQL
Tested with Matlab2008b
Toolboxes must installed:
	Database toolbox
	Genetic Algorithm and Direct Search Toolbox
	Optimization Toolbox
	Parallel Computing Toolbox
	Statistics Toolbox

====DATABASE CONFIGURATION====

DSS prototype using PostgreSQL database for storing experiment`s metrics` values.
I. The last version of PostgreSQL recomended (download from: http://www.postgresql.org/download).
II. After instalation of PostgreSQL using pgAdmin create database named ‘afrodita’ with UTF8 encoding.
III. After creating the database restore if from dump file ‘database_dump.backup’ in root of sources. The database is empty with predefined tables and experiment metadata.
IV. The DSS prototype for using Database toolbox with PostgreSQL database need JDBC driver:
	1) Download driver from http://jdbc.postgresql.org/download.html.
	2) Uncompress JAR file to the MATLABROOT\java\... (for example to the path: C:\Program Files\MATLAB\R2008b\java\jar\).
	3) Copy $MATLABROOT\toolbox\local\classpath.txt to other location.
	4) Append the full path to the JAR file in end of classpath.txt and save.
	5) Override $MATLABROOT\toolbox\local\classpath.txt with modified classpath.txt file.
V. In files ‘save_to_db.m’ and ‘eval_metrics.m’ modify variable ‘conn’ (in the top of file) 
 providing database User name and Password and PostgreSQL server listening port (default 5432) and optionary the dbname (default afrodita). For example: conn = database('afrodita','postgres_user','password', 'org.postgresql.Driver', 'jdbc:postgresql://localhost:5432/afrodita');

====PLOTS` PATH CONFIGURATION====

Provide figures (Pareto set diagram and Euclidean distance diagram) output absolute path in file ‘plots.m’ for variable plots_path (in top of the file). 
For example: plots_path =‘c:\DSS_ROOT\plots\’.

====MATLAB PATH CONFIGURATION====

Set the Matlab paths for DSS. 
1) Press Matlab Start button then DesctopTools->Path
2) Press button ‘Add with Subfolders’ and choose DSS prototype root folder
3) Press Save button.
4) Test DSS prototype: type ‘testingtool’ in matlab command line. If windows opens then it works! If no, then restart matlab.

====RUN DSS PROTOTYPE====
Type ‘testingtool’ in matlab command line.

Congratulations!