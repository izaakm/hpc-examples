% AlphaFold

1. Download reference data

```
$ ALPHAFOLD=/sw/isaac/applications/alphafold/2.0.0/singularity_image/alphafold2.sif
$ singularity shell -B /lustre/isaac/examples/data:/data $ALPHAFOLD
Singularity> cd /app/
Singularity> ./run_alphafold.sh --help
Full AlphaFold protein structure prediction script.
flags:

/app/alphafold/run_alphafold.py:
  --[no]benchmark: Run multiple JAX model evaluations to obtain a timing that
    excludes the compilation time, which should be more indicative of the time
    required for inferencing many proteins.
    (default: 'false')
  --bfd_database_path: Path to the BFD database for use by HHblits.
  --data_dir: Path to directory of supporting data.
  --fasta_paths: Paths to FASTA files, each containing one sequence. Paths
    should be separated by commas. All FASTA paths must have a unique basename
    as the basename is used to name the output directories for each prediction.
    (a comma separated list)
  --hhblits_binary_path: Path to the HHblits executable.
    (default: '/usr/bin/hhblits')
  --hhsearch_binary_path: Path to the HHsearch executable.
    (default: '/usr/bin/hhsearch')
  --jackhmmer_binary_path: Path to the JackHMMER executable.
    (default: '/usr/bin/jackhmmer')
  --kalign_binary_path: Path to the Kalign executable.
    (default: '/usr/bin/kalign')
  --max_template_date: Maximum template release date to consider. Important if
    folding historical test sets.
  --mgnify_database_path: Path to the MGnify database for use by JackHMMER.
  --model_names: Names of models to use.
    (a comma separated list)
  --obsolete_pdbs_path: Path to file containing a mapping from obsolete PDB IDs
    to the PDB IDs of their replacements.
  --output_dir: Path to a directory that will store the results.
  --pdb70_database_path: Path to the PDB70 database for use by HHsearch.
  --preset: <full_dbs|casp14>: Choose preset model configuration - no ensembling
    (full_dbs) or 8 model ensemblings (casp14).
    (default: 'full_dbs')
  --random_seed: The random seed for the data pipeline. By default, this is
    randomly generated. Note that even if this is set, Alphafold may still not
    be deterministic, because processes like GPU inference are nondeterministic.
    (an integer)
  --template_mmcif_dir: Path to a directory with template mmCIF structures, each
    named <pdb_id>.cif
  --uniclust30_database_path: Path to the Uniclust30 database for use by
    HHblits.
  --uniref90_database_path: Path to the Uniref90 database for use by JackHMMER.

Try --helpfull to get a list of all flags.
```

See also
========

- Official
    - https://github.com/deepmind/alphafold
    - https://colab.research.google.com/github/deepmind/alphafold/blob/main/notebooks/AlphaFold.ipynb
- ColabFold
    - https://github.com/sokrypton/ColabFold
    - https://colab.research.google.com/github/sokrypton/ColabFold/blob/main/AlphaFold2.ipynb
- https://github.com/lipan6461188/AlphaFold-StepByStep


<!-- END -->
