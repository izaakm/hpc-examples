#!/bin/bash -l
#SBATCH --account ISAAC-STA0005
#SBATCH --partition=campus-gpu
#SBATCH --qos=campus-gpu 
#SBATCH --export=ALL,SHELL=/bin/bash
#SBATCH --chdir=/lustre/isaac/scratch/jmill165/
#SBATCH --exclusive
#SBATCH --gpus=1
#SBATCH --cpus-per-gpu=48
#SBATCH --job-name alphafold-basic
#SBATCH --nodes=1
#SBATCH --output=jobs/job-%J.o
#SBATCH --time=0-24:00:00


export DATADIR="/lustre/isaac/examples/data/"
export ALPHAFOLD_DIR="${DATADIR}/alphafold"

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

exit 0
