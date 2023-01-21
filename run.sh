# Datasets="twitter"
# Datasets="epinions"
# Datasets="arc"
# Datasets="wiki"
Datasets="twitter epinions wiki"
# Programs="reach"
# Programs="cc"
# Programs="sssp"
Programs="reach cc sssp"
# Datasets="vec"
# Programs="presum"

# args: prog, query, data
function runbd ()
{
	# ./bin/run-example datalog.Experiments spark.sql.shuffle.partitions=2 --program=99 --file=redir_$1.txt --queryform="$2" --baserelation_arc=../datasets/$3/$3$Sfx.csv 2> log 
	./bin/run-example datalog.Experiments --program=99 --file=redir_$1.txt --queryform="$2" --baserelation_arc=../datasets/$3/$3$Sfx.csv 2> log 
	return 0
}

function qry ()
{
	case "$1" in
		"reach") Query="reach(A)."; Sfx="" ;;
		"cc") Query="cc(X,Y)."; Sfx="" ;;
		"presum") Query="presum(X,Y)."; Sfx="" ;;
		"sssp") Query="sssp(X,Y)."; Sfx="-w" ;;
		*) echo "bad program";;
	esac
	return 0
}

for P in $Programs
do
	for D in $Datasets
		do
			echo " BENCHMARKING $P on $D" ;
			qry $P &&
			# runbd $P-opt $Query $D &&
			runbd $P $Query $D 
		done
done