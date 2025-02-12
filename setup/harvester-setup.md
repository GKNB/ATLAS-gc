# Harvester instance management

The Test Harvester instance at NERSC manages the `NERSC_Perlmutter_Globus_Test` 
queue.

Harvester runs under the `usatlas` collaboration account. Steps required to use 
the `usatlas` collaboration account:

```shell
# create a proxy on your local machine
./sshproxy.sh -c usatlas
# connect to Perlmutter login node as "usatlas" user
ssh -i ~/.ssh/usatlas usatlas@perlmutter.nersc.gov
```

## Code directory structure

The Harvester code tree is located in the directory 
`/global/common/software/m2616/harvester-perlmutter-test/`

```shell
usatlas@perlmutter:login35:~> ls -l /global/common/software/m2616/harvester-perlmutter-test/
total 2367
drwxrws--- 2 usatlas m2616     2048 Dec 15 08:40 bin
drwxrws--- 2 usatlas m2616      512 Dec 15 08:40 conf
-rw-r--r-- 1 usatlas m2616  1301272 Jan 10 14:03 cric_ddmendpoints.json
-rw-r--r-- 1 usatlas m2616   983150 Jan 10 14:03 cric_pandaqueues.json
drwxrws--- 8 usatlas m2616      512 Dec 15 10:58 etc
drwxrws--- 3 usatlas m2616      512 Dec 15 10:55 globus
drwxrws--- 2 usatlas m2616      512 Dec 15 08:36 include
drwxrws--- 3 usatlas m2616      512 Dec 15 08:36 lib
lrwxrwxrwx 1 usatlas m2616        3 Dec 15 08:36 lib64 -> lib
drwxrws--- 3 usatlas m2616      512 Dec 15 08:38 local
-rw-r--r-- 1 usatlas m2616     3028 Jan 10 14:03 NERSC_Perlmutter_ES2_queuedata.json
-rw-r--r-- 1 usatlas m2616     3180 Jan 10 14:03 NERSC_Perlmutter_ES_queuedata.json
-rw-r--r-- 1 usatlas m2616     3311 Jan 10 14:03 NERSC_Perlmutter_GPU_queuedata.json
-rw-r--r-- 1 usatlas m2616     3182 Jan 10 14:03 NERSC_Perlmutter_queuedata.json
-rw-r--r-- 1 usatlas m2616     3266 Jan 10 14:03 NERSC_Perlmutter_SCORE_el9_queuedata.json
-rw-r--r-- 1 usatlas m2616     3218 Jan 10 14:03 NERSC_Perlmutter_SCORE_queuedata.json
-rw-r--r-- 1 usatlas m2616     3201 Jan 10 14:03 NERSC_Perlmutter_Test_queuedata.json
-rw-r--r-- 1 usatlas m2616     3200 Jan 10 14:03 NERSC_Perlmutter_VP_queuedata.json
-rw-r--r-- 1 usatlas m2616     2252 Jan 10 13:46 output-34740639.out
-rw-r--r-- 1 usatlas m2616     2252 Jan 10 13:49 output-34744596.out
-rw-r--r-- 1 usatlas m2616     2168 Jan 10 14:03 output-34752502.out
drwxrws--- 2 usatlas m2616      512 Dec 15 13:28 periodic
-rw-rw---- 1 usatlas m2616      135 Dec 15 08:36 pyvenv.cfg
-rw-rw---- 1 usatlas m2616     5448 Dec 15 08:33 README.md
-rw-rw---- 1 usatlas m2616      872 Dec 15 08:33 remove-log-scope.patch
-rwxrwx--- 1 usatlas m2616     2278 Dec 15 08:33 setup-perlmutter-env.sh
-rwxrwx--- 1 usatlas m2616     1442 Dec 15 08:33 start-foreground.sh
drwxrws--- 4 usatlas m2616      512 Dec 22 05:55 tokens
drwxrws--- 3 usatlas m2616      512 Dec 15 10:47 var
```

The Test Harvester config files are located in the subdirectory `./etc/panda/`
- `/global/common/software/m2616/harvester-perlmutter-test/etc/panda/`

```shell
usatlas@perlmutter:login35:~> ls -l /global/common/software/m2616/harvester-perlmutter-test/etc/panda/panda_harvester.cfg
-rw-rw---- 1 usatlas m2616 22199 Jan  9 04:33 /global/common/software/m2616/harvester-perlmutter-test/etc/panda/panda_harvester.cfg
usatlas@perlmutter:login35:~> ls -l /global/common/software/m2616/harvester-perlmutter-test/etc/panda/panda_queueconfig.json
-rw-rw---- 1 usatlas m2616 22782 Dec 21 17:01 /global/common/software/m2616/harvester-perlmutter-test/etc/panda/panda_queueconfig.json
```

The Test Harvester python code is located in the subdirectory 
`./lib/python3.9/site-packages/pandaharvester/`
- `/global/common/software/m2616/harvester-perlmutter-test/lib/python3.9/site-packages/pandaharvester/`

```shell
usatlas@perlmutter:login35:~> ls -l /global/common/software/m2616/harvester-perlmutter-test/lib/python3.9/site-packages/pandaharvester/
total 58
-rw-rw---- 1 usatlas m2616    56 Dec 15 08:38 commit_timestamp.py
drwxrws--- 3 usatlas m2616  2048 Dec 15 08:38 harvesterbody
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvestercloud
drwxrws--- 3 usatlas m2616   512 Jan 10 05:22 harvestercommunicator
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvesterconfig
drwxrws--- 3 usatlas m2616  2048 Dec 15 08:38 harvestercore
drwxrws--- 3 usatlas m2616  2048 Dec 15 08:38 harvestercredmanager
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvesterextractor
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvesterfifo
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvesterfilesyncer
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvestermessenger
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvestermiddleware
drwxrws--- 3 usatlas m2616  2048 Dec 15 08:38 harvestermisc
drwxrws--- 3 usatlas m2616  2048 Dec 15 08:38 harvestermonitor
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvestermover
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvesterpayload
drwxrws--- 3 usatlas m2616  2048 Dec 15 08:38 harvesterpreparator
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvesterscripts
drwxrws--- 3 usatlas m2616  2048 Dec 15 08:38 harvesterstager
drwxrws--- 3 usatlas m2616  2048 Dec 15 08:38 harvestersubmitter
drwxrws--- 3 usatlas m2616  2048 Dec 15 08:38 harvestersweeper
drwxrws--- 3 usatlas m2616  2048 Dec 15 08:38 harvestertest
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvesterthrottler
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvesterworkermaker
drwxrws--- 3 usatlas m2616   512 Dec 15 08:38 harvesterzipper
-rw-rw---- 1 usatlas m2616     0 Dec 15 08:38 __init__.py
-rw-rw---- 1 usatlas m2616    27 Dec 15 08:38 panda_pkg_info.py
drwxrws--- 2 usatlas m2616   512 Dec 15 08:38 __pycache__
-rw-rw---- 1 usatlas m2616   999 Dec 15 08:38 README.md
```

## Commands to control Harvester instance

1. To determine if the Test Harvester instance is running, use the `sqs` command

```shell
usatlas@perlmutter:login35:~> sqs --qos workflow
JOBID        	ST USER  	NAME      NODES   TIME_LIMIT   	TIME    SUBMIT_TIME      	QOS         	START_TIME       	FEATURES   	NODELIST(REASON)
34744594     	PD usatlas   clean_period  1         1:00:00   	0:00    2025-01-10T10:06:52  workflow    	2025-02-01T00:00:00       cron       	(BeginTime)    
34744595     	PD usatlas   clean_freque  1           45:00   	0:00    2025-01-10T11:36:42  workflow    	2025-01-10T11:50:00       cron       	(BeginTime)    
34744596     	PD usatlas   Test_Harvest  1     30-00:00:00   	0:00    2025-01-10T10:06:52  workflow    	N/A                       cron       	(Dependency)   
34744593     	R  usatlas   Harvester     1     30-00:00:00	1:35:47 2025-01-10T10:06:52  workflow    	2025-01-10T10:09:00       cron       	login25   	 
34740639     	R  usatlas   Test_Harvest  1     30-00:00:00	6:29:42 2025-01-10T05:12:51  workflow    	2025-01-10T05:15:05       cron       	login09
```

The Test Harvester instance has the name `Test_Harvester`. Note, there may be 
two instances at once, due to the way the workflow QOS works (for more details 
see [NERSC Documentation - Workflow QOS](https://docs.nersc.gov/jobs/workflow/workflow-queue/))

2. To stop the Test Harvester instance use the `scancel` command. Run the `sqs`
command again to make sure you don’t have the `Test_Harvester` workflow running.

```shell
usatlas@perlmutter:login35:~> scancel --cron 34740639
usatlas@perlmutter:login35:~> sqs --qos workflow
JOBID        	ST USER  	NAME      NODES   TIME_LIMIT   	TIME    SUBMIT_TIME      	QOS         	START_TIME       	FEATURES   	NODELIST(REASON)
34744596     	CG usatlas   Test_Harvest   1    30-00:00:00   	3:20    2025-01-10T10:06:52  workflow    	2025-01-10T13:46:06       cron       	login12   	 
34744594     	PD usatlas   clean_period   1        1:00:00   	0:00    2025-01-10T10:06:52  workflow    	2025-02-01T00:00:00       cron       	(BeginTime)    
34744595     	PD usatlas   clean_freque   1          45:00   	0:00    2025-01-10T13:36:07  workflow    	2025-01-10T13:50:00       cron       	(BeginTime)    
34744593     	R  usatlas   Harvester      1    30-00:00:00	3:40:39 2025-01-10T10:06:52  workflow    	2025-01-10T10:09:00       cron       	login25   
usatlas@perlmutter:login35:~> scancel --cron 34744596
usatlas@perlmutter:login35:~> sqs --qos workflow
JOBID        	ST USER  	NAME      NODES   TIME_LIMIT   	TIME    SUBMIT_TIME      	QOS         	START_TIME       	FEATURES   	NODELIST(REASON)
34744594     	PD usatlas   clean_period   1        1:00:00   	0:00    2025-01-10T10:06:52  workflow    	2025-02-01T00:00:00       cron       	(BeginTime)    
34744595     	PD usatlas   clean_freque   1          45:00   	0:00    2025-01-10T13:36:07  workflow    	N/A                       cron       	(BeginTime)    
34744593     	R  usatlas   Harvester      1    30-00:00:00	3:41:01 2025-01-10T10:06:52  workflow    	2025-01-10T10:09:00       cron       	login25
```

3. To restart the test Harvester instance - one must edit the `scrontab` (we
are using the default editor `vi`).

```shell
usatlas@perlmutter:login35:~> scrontab -e
```

- Look for lines in the file such as the following 

```shell
#DISABLED: #SCRON -C cron
#DISABLED: #SCRON -q workflow
#DISABLED: #SCRON -A m2616
#DISABLED: #SCRON -t 30-00:00:00
#DISABLED: #SCRON --time-min=8:00:00
#DISABLED: #SCRON --dependency=singleton
#DISABLED: #SCRON -o output-%j.out
#DISABLED: #SCRON --open-mode=truncate
#DISABLED: #SCRON --job-name=Test_Harvester
#DISABLED: #SCRON --chdir=/global/common/software/m2616/harvester-perlmutter-test
#DISABLED: */3 * * * * /global/common/software/m2616/harvester-perlmutter-test/start-foreground.sh
```

- Remove `#DISABLED: ` from the lines associated with the Test Harvester 
  instance (note the space after the colon). The lines should look like this 
  before you save the crontab file.

```shell
#SCRON -C cron
#SCRON -q workflow
#SCRON -A m2616
#SCRON -t 30-00:00:00
#SCRON --time-min=8:00:00
#SCRON --dependency=singleton
#SCRON -o output-%j.out
#SCRON --open-mode=truncate
#SCRON --job-name=Test_Harvester
#SCRON --chdir=/global/common/software/m2616/harvester-perlmutter-test
*/3 * * * * /global/common/software/m2616/harvester-perlmutter-test/start-foreground.sh
```

- Save your result and exit the editor.
- Use `sqs` to see if the Test Harvester instance is starting up.

```shell
usatlas@perlmutter:login35:~> sqs --qos workflow
JOBID        	ST USER  	NAME      NODES   TIME_LIMIT   	TIME  SUBMIT_TIME      	QOS         	START_TIME       	FEATURES   	NODELIST(REASON
34752500     	PD usatlas   clean_period   1        1:00:00   	0:00  2025-01-10T14:01:05  workflow    	2025-02-01T00:00:00  cron       	(BeginTime)    
34752501     	PD usatlas   clean_freque   1          45:00   	0:00  2025-01-10T14:01:05  workflow    	2025-01-10T14:05:00  cron       	(BeginTime)    
34752499     	PD usatlas   Harvester      1    30-00:00:00   	0:00  2025-01-10T14:01:05  workflow    	2025-01-10T14:03:00  cron       	(Dependency)   
34752502     	PD usatlas   Test_Harvest   1    30-00:00:00   	0:00  2025-01-10T14:01:05  workflow    	2025-01-10T14:03:00  cron       	(BeginTime)    
34744593     	R  usatlas   Harvester      1    30-00:00:00	3:52:08  2025-01-10T10:06:52  workflow    	2025-01-10T10:09:00  cron       	login25
```

