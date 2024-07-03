#!/usr/bin/env bash
#SBATCH --account ACF-UTK0011
#SBATCH --partition campus-gpu-large
#SBATCH --qos campus-gpu 
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --gpus 1
#SBATCH --cpus-per-gpu 48
#SBATCH --time 24:00:00
#SBATCH --job-name alphafold-example

source /usr/share/Modules/init/bash
module load alphafold/2.0.0
export ALPHAFOLD_IMAGE=${ALPHAFOLD_IMAGE:-/sw/isaac/applications/alphafold/2.0.0/singularity_image/alphafold2.sif}

# --data_dir=/alphafold-downloads
# export DATADIR="/lustre/isaac/examples/data/"

# --uniref90_database_path=/alphafold-data/alphafold/uniref90/uniref90.fasta
# --mgnify_database_path=/alphafold-data/alphafold/mgnify/mgy_clusters_2022_05.fa
# --uniclust30_database_path=/alphafold-data/alphafold/uniref30/UniRef30_2021_03
# --bfd_database_path=/alphafold-data/alphafold/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt
# --pdb70_database_path=/alphafold-data/alphafold/pdb70/pdb70
# --template_mmcif_dir=/alphafold-data/alphafold/pdb_mmcif/mmcif_files/
# --obsolete_pdbs_path=/alphafold-data/alphafold/pdb_mmcif/obsolete.dat
export ALPHAFOLD_DIR="/lustre/isaac/examples/data/alphafold"

# Input.
# export FASTA="/lustre/isaac/examples/data/fasta/P01308.fasta"
# export FASTA="<PATH TO YOUR FASTA>"
export EXAMPLES_DIR="/lustre/isaac/examples"

# Output.
export OUTPUT_DIR="$SCRATCHDIR/data/outputs/alphafold/$(date +%s)"

mkdir -pv $OUTPUT_DIR

# ACCESSING EXTERNAL FILES WITHIN CONTAINERS
# By default, Singularity bind mounts the $HOME, /tmp, and $PWD directories
# within the container at runtime. On Open Enclave resources the user's $HOME
# and $SCRATCHDIR directories are bind mounted within the container at runtime.
#
# Therefore, these changes will persist once the container exits.
# 
# If additional external locations are needed from within the container, the
# --bind option can be used to define the additional bind mounts.

singularity \
    exec \
    --nv \
    --bind $EXAMPLES_DIR:/examples \
    --bind $ALPHAFOLD_DIR:/alphafold \
    --bind $(mktemp -d):/etc \
    "$ALPHAFOLD_IMAGE" \
    /app/run_alphafold.sh \
    --data_dir="/alphafold" \
    --bfd_database_path="/alphafold/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt" \
    --mgnify_database_path="/alphafold/mgnify/mgy_clusters_2022_05.fa" \
    --obsolete_pdbs_path="/alphafold/pdb_mmcif/obsolete.dat" \
    --pdb70_database_path="/alphafold/pdb70/pdb70" \
    --template_mmcif_dir="/alphafold/pdb_mmcif/mmcif_files/" \
    --uniclust30_database_path="/alphafold/uniref30/UniRef30_2021_03" \
    --uniref90_database_path="/alphafold/uniref90/uniref90.fasta" \
    --model_names=model_1 \
    --max_template_date=2020-05-14 \
    --output_dir="$OUTPUT_DIR" \
    --fasta_paths="/examples/data/fasta/P01308.fasta"

exit 0
