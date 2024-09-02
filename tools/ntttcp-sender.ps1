
$sender = "10.224.1.111"
# [<number of VM cores> x 2]
$threads = 4
$duration = 10
$port = 1

ntttcp -s -m "$threads,*,$sender" -t $duration -P $port