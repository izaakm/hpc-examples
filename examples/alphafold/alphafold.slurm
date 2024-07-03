#!/bin/bash -l
#SBATCH --account ACF-UTK0011
#SBATCH --partition campus-gpu-bigmem
#SBATCH --qos campus-gpu 
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --gpus 1
#SBATCH --cpus-per-gpu 48
#SBATCH --time 24:00:00
#SBATCH --job-name alphafold-basic
#SBATCH --chdir /lustre/isaac/scratch/jmill165
#SBATCH --output jobs/latest/%j-%x.o
###SBATCH --export ALL,SHELL=/bin/bash
###SBATCH --exclusive


source /usr/share/Modules/init/bash
module load alphafold/2.0.0
# export ALPHAFOLD_IMAGE=${ALPHAFOLD_IMAGE:-/sw/isaac/applications/alphafold/2.0.0/singularity_image/alphafold2.sif}


# --data_dir=/alphafold-downloads
export DATADIR="/lustre/isaac/examples/data/"

# --uniref90_database_path=/alphafold-data/alphafold/uniref90/uniref90.fasta
# --mgnify_database_path=/alphafold-data/alphafold/mgnify/mgy_clusters_2022_05.fa
# --uniclust30_database_path=/alphafold-data/alphafold/uniref30/UniRef30_2021_03
# --bfd_database_path=/alphafold-data/alphafold/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt
# --pdb70_database_path=/alphafold-data/alphafold/pdb70/pdb70
# --template_mmcif_dir=/alphafold-data/alphafold/pdb_mmcif/mmcif_files/
# --obsolete_pdbs_path=/alphafold-data/alphafold/pdb_mmcif/obsolete.dat
export ALPHAFOLD_DIR="/lustre/isaac/examples/data/alphafold"

# Input.
# export FASTA="/nfs/home/jmill165/data/downloads/P01308.fasta"
export FASTA="/lustre/isaac/scratch/jmill165/examples/examples/alphafold/P01308.fasta"

# Output.
export OUTPUT_DIR="/lustre/isaac/scratch/jmill165/data/outputs/alphafold/$(date +%s)"

mkdir -pv $OUTPUT_DIR

singularity \
    exec \
    --nv \
    -B $OUTPUT_DIR:/output \
    -B $ALPHAFOLD_DIR:/alphafold \
    -B .:/etc \
    /sw/isaac/applications/alphafold/2.0.0/singularity_image/alphafold2.sif \
    /app/run_alphafold.sh \
    --fasta_paths="$FASTA" \
    --data_dir="/alphafold" \
    --output_dir=/output \
    --model_names=model_1 \
    --max_template_date=2020-05-14 \
    --bfd_database_path="/alphafold/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt" \
    --mgnify_database_path="/alphafold/mgnify/mgy_clusters_2022_05.fa" \
    --obsolete_pdbs_path="/alphafold/pdb_mmcif/obsolete.dat" \
    --pdb70_database_path="/alphafold/pdb70/pdb70" \
    --template_mmcif_dir="/alphafold/pdb_mmcif/mmcif_files/" \
    --uniclust30_database_path="/alphafold/uniref30/UniRef30_2021_03" \
    --uniref90_database_path="/alphafold/uniref90/uniref90.fasta"

exit 0
