---
title: 'An Intro to Hoffman2 with R'
date: 2022-01-22
permalink: /posts/2022/01/hoffman2_basics/
tags:
  - Hoffman 2
  - computing
---

## Overview

This guide will provide you with the tools to kickstart your High
Performance Computing (HPC) journey. The purpose is not to make you an
HPC expert, but to provide an inexperienced reader with enough
information to start using the Hoffman2 computing cluster at UCLA, and
to point you to helpful resources to build upon the knowledge provided
here.

While Hoffman2 can be used to run a variety of analyses using different
tools and computing languages, this guide is written specifically to
help users who want to run R scripts. This is meant to be a “living
document”, so if you would like to see a tutorial for something that
isn’t already here, please shoot me an email at btonelli “at” ucla “dot”
edu.

Throughout the document, there are a number of links to helpful
resources that are also linked here:

-   Hoffman2 Official Documentation:
    **<https://www.hoffman2.idre.ucla.edu/>**
-   Request a Hoffman Account:
    **<https://www.hoffman2.idre.ucla.edu/Accounts/Requesting-an-account.html>**
-   Putty: **<https://www.putty.org/>**
-   Cyberduck: **<https://cyberduck.io/>**
-   The Carpentries command line learning resources:
    **<https://swcarpentry.github.io/shell-novice/>**
-   Annotated Submission Script:
    **<http://bentonelli.github.io/files/single_run.sh>**
-   Annotated Batch Script:
    **<http://bentonelli.github.io/files/multi_run.sh>**

## Brief Overview of High Performance Computing

### What is a Computing Cluster?

In simple terms, a computing cluster is an amalgamation of many separate
computers that can be used to help accelerate certain tasks. While each
individual computer that is a part of this cluster is necessarily much
(if at all) faster than a desktop computer, the power comes in
leveraging many of these computers to run a single analysis. The user
(you) can connect to UCLA’s version of this resource, the Hoffman2
cluster, remotely using a secure shell (or SSH) through the command
line. If you don’t know what a secure shell is, don’t worry, that will
be covered! After connecting, you can then interact with the cluster to
run your scripts.

![](/images/cluster_diagram.png)

### What ways can the cluster help me?

The cluster has two major advantages over running something on your
local laptop or desktop: 1) Run scripts in a way that reduces the
overall runtime. Analysis can be run in parallel using the many cores
available to the user, or take advantages of gobs of memory (RAM) that
are available on the cluster. 2) Free up your computer for other tasks.
Scripts that have excessively long run times can be off-loaded to the
cluster, even if they don’t necessary run any faster on the cluster.
These types of tasks (like running a Bayesian model with lots of data)
may not be able to be easily sped up, but will allow you to use your own
personal computer while the cluster does all the work.

![](/images/dog_cluster.jpg)

## So how do I start with Hoffman2?

### Step 1: Get an account

Hoffman2 is open open to all UCLA-affiliated staff and students, but you
do need to apply for a user account. To get a user account, you also
need to be sponsored by your PI.

To apply for an account just click this link and follow the
instructions:
**<https://www.hoffman2.idre.ucla.edu/Accounts/Requesting-an-account.html>**

Once you have an approved Hoffman account, you will get a username and
password.

### Step 2: Connect using SSH

SSH is a way for your computer to connect with resources remotely from
the command line. This step may seem daunting if you haven’t used the
command line before, but don’t be discouraged - it is pretty easy once
you get the hang of it! How you implement SSH will depend on your
operating system (e.g., Windows, MacOS), though the rest of the steps
should be the same.

#### Step 2a:

For Windows: Download [PuTTY](https://www.putty.org/) For Mac: Open
Terminal (can be found in the `Applications/` folder)

#### Step 2b:

-  At the command line prompt, type in “ssh”, space, your Hoffman2 username, then the “address” of the cluster. It’ll look something like:

ssh <USERNAME@hoffman2.idre.ucla.edu>

-  Press Enter, and then type in you password when prompted.

-  Once you’re in, you’ll get a message welcoming you to the Hoffman2 Cluster. You did it!

#### Step 3: Accessing your files

When you register for a Hoffman2 account, you will have a designated
space on the cluster. You can think of this like hard drive space. This
space will be your “home directory”. It is a folder with all of your
personal thigns (scripts, data, results, etc.). If you are comfortable
navigating through directors (i.e. folders) and files from the command
line, you can do that. A basic tutorial of the command line can be found
[here](https://swcarpentry.github.io/shell-novice/).

If you are a normal person, using the command line to navigate this way
will be a daunting prospect. That’s where
[Cyberduck](https://cyberduck.io/) comes in. Cyberduck is a third-party
platform that provides a Graphical User Interface (GUI) that connects
with your space on Hoffman2. Once Cyberduck (or another platform like
it) is set up, you can drag and drop your files directly into, or out
of, Hoffman2. Handy!

To get Cyberduck set up, navigate to the website:
**<https://cyberduck.io/>** and follow the instructions to download.

-  Open Cyberduck on your computer, click “Open Connection”, choose the SFTP protocol, and enter:

-  Server: hoffman2.idre.ucla.edu
-  Username: your username (same as above)
-  Password: your password

Once you are in, you should see your home directory. You can then start
dragging and dropping like crazy.

#### Step 4: Using Hoffman2 to run scripts

Running scripts on Hoffman2 can be done in a variety of ways. Which
approach you decide to use will depend on what type of task you are
trying to perform (running thousands of simulations, Bayesian models, or
processing a batch of images), and what works best for you!

Here, the examples are all R-based (because that’s what’s most
applicable to the Tingley Lab), but there are certainly other ways to
run jobs in all sorts of languages.

The [Hoffman2 documentation page](https://www.hoffman2.idre.ucla.edu/)
has a wide range of examples, but some of the basic ways are explored
below:

##### Method 1) submit.sh -\> example.R

One of the easier ways to run a script is by submitting a “batch job”.
To do this, we will create and run a submission script. In this way, we
create a .sh script that tells the cluster to execute our .R script (the
code we actually wan to run). Using this method, we need to be sure to
write all output from our .R script to a file (like a .csv or .rds) to
make sure we save our results.

An example of a submission script is provided
[here](http://bentonelli.github.io/files/single_run.sh). This submission
script basically acts as the “Run all” in Rstudio, executing all the
code in a .R script. But the submission file also includes important
information about the computational resources you are requesting to use
on the cluster.

Regardless of the method for running jobs on the cluster, you will need
to request resources, which brings us to…

#### Computational Resources Interlude

Because you aren’t using your personal computer to run your script, you
need to tell the cluster how much memory, how many cores, and how much
time it should allocate to your task. Making these requests can be
daunting for a number of reasons. First, it’s often hard to know how
long or how much memory your job will run for! So how do you pick
numbers???

Importantly, if your task exceeds the amount of resources you requested,
it will be terminated by the cluster. You don’t want this to happen,
especially when your script needs to run for an extended period of time.
Once you allocate resources, it CANNOT be changed, which means that if
you allocated 9 days for your task that will take 10, you will be very
sad when your task terminates when it is 90% finished.

Same thing goes for memory. If your script tries to load a massive 10GB
file into memory, and you only allocated 2GB of memory, Hoffman2 will
boot you off. Sad =(.

Conversely, if you request TOO many resources, your script will
(practically) never run. The cluster uses a scheduling algorithm to
decide which order your tasks execute in. The more resources you
request, the farther down your task is placed the to-do list of the
cluster.

So you want to optimize by requests just enough resources to get your
task to run without failing, and to get it running as quickly as
possible. How you do that?

Testing your code first with a smaller dataset, running only a few
simulations, or otherwise using less resources than you expect to use in
your final task can give you an indication of what resources you should
request. Yes, this is an extra step, but the last thing you want is to
wait 3 days for your task to start running, only to have it fail within
10 seconds because you didn’t request enough memory!

##### Method 2) Run R directly using an interactive session

This option can be helpful to run scripts that may not take a very long
time, scripts where you need to interact with the results (exploratory
analyses), or do testing for a bigger job.

Interactive sessions allow you to “interact” with R just like you would
if you were on your laptop. To open up an interactive session, you need
to:

1.  Connect to the cluster using SSH

2.  Request resources using the line:

srun –partition=general –qos=general –mem=5G –pty bash

(where 5G is the total memory allocated to the session)

1.  Load R using: load module R

2.  Launch R by typing: R

3.  You are in! You can use R like you would normally. Remember, your
    working directory will be your home directory (named with your user
    name).

##### Method 3) Run an R script a bunch of times

When you want to execute a job that needs to run multiple times, like
running a bunch of simulations, you can create a “array script,” example
[here](http://bentonelli.github.io/files/multi_run.sh). These scripts
are very similar to the example above, but have an additional line to
tell the cluster to run your script a certain number of times. Remember:
you need to make sure your .R script spits out a .csv, .rds, or other
file type for your results to be saved.

### Conclusion

That’s it! Hopefully this guide was a gentle introduction to using R on
the Hoffman2 cluster. Feel free to share with others, and let us know if
there is anything you would like added to this tutorial (or if you found
a typo) by emailing btonelli “at” ucla (dot) edu.
