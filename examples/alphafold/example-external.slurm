#!/bin/bash
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=128G
#SBATCH --time=1-00:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=<your email here>
#SBATCH --exclude=crysis,singularity,matrix,amp-3,gpu03,frost-[1-8]

module load alphafold

srun \
    singularity exec \
    --nv \
    --pwd /opt/alphafold \
    /opt/rit/singularity/images/alphafold/2.1.1/alphafold.sif \
    python /opt/alphafold/run_alphafold.py \
    --fasta_paths=/work/LAS/kaung-lab/saiful/alphafold/pdlp5_pip3b.fasta \
    --output_dir=/work/LAS/kaung-lab/saiful/alphafold \
    --data_dir=/work/LAS/BioDatabase/alphafold \
    --db_preset=full_dbs \
    --model_preset=multimer \
    --uniprot_database_path=/work/LAS/BioDatabase/alphafold/uniprot/uniprot.fasta \
    --uniref90_database_path=/work/LAS/BioDatabase/alphafold/uniref90/uniref90.fasta \
    --pdb_seqres_database_path=/work/LAS/BioDatabase/alphafold/pdb_seqres/pdb_seqres.txt \
    --mgnify_database_path=/work/LAS/BioDatabase/alphafold/mgnify/mgy_clusters_2018_12.fa \
    --bfd_database_path=/work/LAS/BioDatabase/alphafold/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt \
    --uniclust30_database_path=/work/LAS/BioDatabase/alphafold/uniclust30/uniclust30_2018_08 \
    --template_mmcif_dir=/work/LAS/BioDatabase/alphafold/pdb_mmcif/mmcif_files \
    --obsolete_pdbs_path=/work/LAS/BioDatabase/alphafold/pdb_mmcif/obsolete.dat \
    --max_template_date=2021-11-01 \
    "$@"


