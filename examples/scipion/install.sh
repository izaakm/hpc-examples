# python3 -m scipioninstaller -conda -noXmipp -noAsk /path/for/scipion
# ^ This fails, reports the following list of commands as the source of the
# error. IE the above command is running the following commands.  The error
# itself was related to mpi4py. Tracing down the subsuquent error messages I
# was able to piece together a conda environment that seemed to work.
cd /lustre/isaac/scratch/jmill165/scipion &&
. "/nfs/home/jmill165/scratch/miniconda-for-scipion/bin/../etc/profile.d/conda.sh" &&
# conda create -y -n scipion3 python=3.8 &&
conda create -y -n scipion3 -c conda-forge python=3.8 mpi4py mpich gxx_linux-64 &&
conda activate scipion3 &&
mkdir -p software/lib &&
mkdir -p software/bindings &&
mkdir -p software/em &&
export SCIPION_HOME=/lustre/isaac/scratch/jmill165/scipion &&
pip install scipion-pyworkflow &&
pip install scipion-app
