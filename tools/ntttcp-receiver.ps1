
$receiver = "10.0.0.5"
# [<number of VM cores> x 2]
$threads = 4
$duration = 10
$port = 1

ntttcp -r -m "$threads,*,$receiver" -t $duration -P $port