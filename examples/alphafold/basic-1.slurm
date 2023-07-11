#!/bin/bash -l
#SBATCH --account ISAAC-STA0005
#SBATCH --chdir=/lustre/isaac/scratch/jmill165/
#SBATCH --exclusive
#SBATCH --export=ALL,SHELL=/bin/bash
#SBATCH --gpus=1
#SBATCH --cpus-per-gpu=48
#SBATCH --job-name alphafold-basic
#SBATCH --nodes=1                 # Number of nodes
#SBATCH --output=job-%J.o         # The file where the output of the terminal will be dumped
#SBATCH --partition=campus-gpu    # If not specified then default is "campus"
#SBATCH --qos=campus-gpu 
#SBATCH --time=0-24:00:00         # Wall time (days-hh:mm:ss)
############################################################
# #SBATCH --mem=0
# ^This causes the following error:
#   sbatch: error: CPU count per node can not be satisfied
#   sbatch: error: Batch job submission failed: Requested node configuration is not available
############################################################

# ALPHAFOLD HELP:
# Full AlphaFold protein structure prediction script.
# flags:
# 
# /app/alphafold/run_alphafold.py:
#   --[no]benchmark: Run multiple JAX model evaluations to obtain a timing that
#     excludes the compilation time, which should be more indicative of the time
#     required for inferencing many proteins.
#     (default: 'false')
#   --bfd_database_path: Path to the BFD database for use by HHblits.
#   --data_dir: Path to directory of supporting data.
#   --fasta_paths: Paths to FASTA files, each containing one sequence. Paths
#     should be separated by commas. All FASTA paths must have a unique basename
#     as the basename is used to name the output directories for each prediction.
#     (a comma separated list)
#   --hhblits_binary_path: Path to the HHblits executable.
#     (default: '/usr/bin/hhblits')
#   --hhsearch_binary_path: Path to the HHsearch executable.
#     (default: '/usr/bin/hhsearch')
#   --jackhmmer_binary_path: Path to the JackHMMER executable.
#     (default: '/usr/bin/jackhmmer')
#   --kalign_binary_path: Path to the Kalign executable.
#     (default: '/usr/bin/kalign')
#   --max_template_date: Maximum template release date to consider. Important if
#     folding historical test sets.
#   --mgnify_database_path: Path to the MGnify database for use by JackHMMER.
#   --model_names: Names of models to use.
#     (a comma separated list)
#   --obsolete_pdbs_path: Path to file containing a mapping from obsolete PDB IDs
#     to the PDB IDs of their replacements.
#   --output_dir: Path to a directory that will store the results.
#   --pdb70_database_path: Path to the PDB70 database for use by HHsearch.
#   --preset: <full_dbs|casp14>: Choose preset model configuration - no ensembling
#     (full_dbs) or 8 model ensemblings (casp14).
#     (default: 'full_dbs')
#   --random_seed: The random seed for the data pipeline. By default, this is
#     randomly generated. Note that even if this is set, Alphafold may still not
#     be deterministic, because processes like GPU inference are nondeterministic.
#     (an integer)
#   --template_mmcif_dir: Path to a directory with template mmCIF structures, each
#     named <pdb_id>.cif
#   --uniclust30_database_path: Path to the Uniclust30 database for use by
#     HHblits.
#   --uniref90_database_path: Path to the Uniref90 database for use by JackHMMER.
# 
# Try --helpfull to get a list of all flags.

# FATAL Flags parsing error:
#   flag --model_names=None: Flag --model_names must have a value other than None.
#   flag --uniref90_database_path=None: Flag --uniref90_database_path must have a value other than None.
#   flag --mgnify_database_path=None: Flag --mgnify_database_path must have a value other than None.
#   flag --uniclust30_database_path=None: Flag --uniclust30_database_path must have a value other than None.
#   flag --bfd_database_path=None: Flag --bfd_database_path must have a value other than None.
#   flag --pdb70_database_path=None: Flag --pdb70_database_path must have a value other than None.
#   flag --template_mmcif_dir=None: Flag --template_mmcif_dir must have a value other than None.
#   flag --max_template_date=None: Flag --max_template_date must have a value other than None.
#   flag --obsolete_pdbs_path=None: Flag --obsolete_pdbs_path must have a value other than None.

# cd /lustre/isaac/scratch/kkalhor

# export ALPHAFOLD_DATA_PATH="/lustre/isaac/scratch/kkalhor/data"
# export ALPHAFOLD_MODELS="/lustre/isaac/scratch/kkalhor/data/params"

# singularity exec -B $ALPHAFOLD_DATA_PATH:/data -B $ALPHAFOLD_MODELS -B .:/etc /sw/isaac/applications/alphafold/2.0.0/singularity_image/alphafold2.sif /app/run_alphafold.sh --data_dir=/data --output_dir=/lustre/isaac/scratch/kkalhor/alphafold_output/output_scriptv5/ --fasta_paths=/lustre/isaac/scratch/kkalhor/proteinSEQ.fasta    --max_template_date=2020-05-14 --model_names=model_1 --uniref90_database_path=/lustre/isaac/scratch/kkalhor/data/uniref90/uniref90.fasta --mgnify_database_path=/lustre/isaac/scratch/kkalhor/data/mgnify/mgy_clusters_2022_05.fa --uniclust30_database_path=/lustre/isaac/scratch/kkalhor/data/uniref30/UniRef30_2021_03 --bfd_database_path=/lustre/isaac/scratch/kkalhor/data/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt --pdb70_database_path=/lustre/isaac/scratch/kkalhor/data/pdb70/pdb70 --template_mmcif_dir=/lustre/isaac/scratch/kkalhor/data/pdb_mmcif/mmcif_files --obsolete_pdbs_path=/lustre/isaac/scratch/kkalhor/data/pdb_mmcif/obsolete.dat
# ^ is missing --nv

# cd /lustre/isaac/scratch/jmill165/

# /lustre/isaac/examples/data/alphafold/
#   bfd/
#   mgnify/
#   params/
#   pdb70/
#   pdb_mmcif/
#   pdb_seqres/ # only for AlphaFold-Multimer
#   src_code/
#   uniprot/    # only for AlphaFold-Multimer
#   uniref30/
#   uniref90/


# singularity \
#     exec \
#     --nv \
#     -B $ALPHAFOLD_DATA_PATH:/data \
#     -B $ALPHAFOLD_MODELS \
#     -B .:/etc \
#     /sw/isaac/applications/alphafold/2.0.0/singularity_image/alphafold2.sif \
#     /app/run_alphafold.sh \
#     --data_dir=/data \
#     --output_dir=/lustre/isaac/scratch/kkalhor/alphafold_output/output_scriptv5/ \
#     --fasta_paths=/lustre/isaac/scratch/kkalhor/proteinSEQ.fasta    \
#     --model_names=model_1 \
#     --max_template_date=2020-05-14 \
#     --template_mmcif_dir=/lustre/isaac/scratch/kkalhor/data/pdb_mmcif/mmcif_files \
#     --bfd_database_path=/lustre/isaac/scratch/kkalhor/data/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt \
#     --mgnify_database_path=/lustre/isaac/scratch/kkalhor/data/mgnify/mgy_clusters_2022_05.fa \
#     --pdb70_database_path=/lustre/isaac/scratch/kkalhor/data/pdb70/pdb70 \
#     --uniclust30_database_path=/lustre/isaac/scratch/kkalhor/data/uniref30/UniRef30_2021_03 \
#     --uniref90_database_path=/lustre/isaac/scratch/kkalhor/data/uniref90/uniref90.fasta \

export DATADIR="/lustre/isaac/examples/data/"
export ALPHAFOLD_DIR="${DATADIR}/alphafold"
# export ALPHAFOLD_PARAMS="${DATADIR}/alphafold/params/"

export FASTA="/nfs/home/jmill165/data/downloads/P01308.fasta"
export OUTPUT_DIR="/lustre/isaac/scratch/jmill165/data/outputs/$(date +%s)"

mkdir -pv $OUTPUT_DIR

singularity \
    exec \
    --nv \
    -B $DATADIR:/alphafold-data \
    -B $OUTPUT_DIR:/my-outputs \
    -B $ALPHAFOLD_DIR:/alphafold-downloads \
    -B .:/etc \
    /sw/isaac/applications/alphafold/2.0.0/singularity_image/alphafold2.sif \
    /app/run_alphafold.sh \
    --fasta_paths="$FASTA" \
    --data_dir=/alphafold-downloads \
    --output_dir=/my-outputs \
    --model_names=model_1 \
    --uniref90_database_path=/alphafold-data/alphafold/uniref90/uniref90.fasta \
    --mgnify_database_path=/alphafold-data/alphafold/mgnify/mgy_clusters_2022_05.fa \
    --uniclust30_database_path=/alphafold-data/alphafold/uniref30/UniRef30_2021_03 \
    --bfd_database_path=/alphafold-data/alphafold/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt \
    --pdb70_database_path=/alphafold-data/alphafold/pdb70/pdb70 \
    --template_mmcif_dir=/alphafold-data/alphafold/pdb_mmcif/mmcif_files/ \
    --max_template_date=2020-05-14 \
    --obsolete_pdbs_path=/alphafold-data/alphafold/pdb_mmcif/obsolete.dat

# END
