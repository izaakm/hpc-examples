AlphaFold3
==========

How to set up your json file for AlphaFold3 (AlphaFold Server)

Source: [google-deepmind/alphafold/server] on GitHub

Submit your proteins to AlphaFold3 Server
=========================================

1. Go to [alphafoldserver.com][]
    - > Remaining jobs refresh each day
    - > Jobs can be up to 5,000 tokens - see more details on token calculation,
      > accepted formats, seed selection and other features in our FAQ
1. Click "Upload JSON"

    > You can create up to 100 jobs. All uploaded jobs are saved as drafts in
    > history.
    >
    > Each saved draft has a JSON file you can reuse. Please refer to this example
    > for JSON file syntax and refer to our FAQs.

1. About the JSON file:
    - `name`: Allowed characters are: letters, numbers, spaces, dashes, underscores, colons.
1. Click "Submit [...] jobs as drafts"
1. Click "Continue and preview job"

About the results
=================

[How can I interpret confidence metrics to check the accuracy of structures?][_1]
---------------------------------------------------------------------------------

Similar to AlphaFold2 and AlphaFold-Multimer, outputs include confidence
metrics. The main metrics are:

- **pLDDT**: a per-atom confidence estimate on a 0-100 scale where a higher
  value indicates higher confidence. pLDDT aims to predict a modified LDDT
  score that only considers distances to polymers. For proteins this is similar
  to the [lDDT-Cα metric] but with more granularity as it can vary per atom not
  just per residue. For ligand atoms the modified LDDT considers the errors
  only between the ligand atom and polymers not other ligand atoms, and for
  DNA/RNA a wider radius of 30A is used for the modified LDDT instead of 15A.
  The pLDDT is shown as color outputs in the image of the structure, using the
  same value to color mapping as in AFDB.
- **PAE (predicted aligned error)**: estimate of the error in the relative
  position and orientation between two tokens in the predicted structure.
  Higher values indicate higher predicted error and therefore lower confidence.
  For proteins and nucleic acids, PAE score is essentially the same as
  AlphaFold2, where the error is measured relative to frames constructed from
  the protein backbone. For small molecules and post-translational
  modifications, a frame is constructed for each atom from its closest
  neighbors from a reference conformer.
- **pTM and ipTM scores**: the predicted template modeling (pTM) score and the
  interface predicted template modeling (ipTM) score are both derived from a
  measure called the template modeling (TM) score. This measures the accuracy
  of the entire structure ([Zhang and Skolnick, 2004]; [Xu and Zhang, 2010]). A
  pTM score above 0.5 means the overall predicted fold for the complex might be
  similar to the true structure. ipTM measures the accuracy of the predicted
  relative positions of the subunits within the complex. Values higher than 0.8
  represent confident high-quality predictions, while values below 0.6 suggest
  likely a failed prediction. ipTM values between 0.6 and 0.8 are a gray zone
  where predictions could be correct or incorrect. TM score is very strict for
  small structures or short chains, so pTM assigns values less than 0.05 when
  fewer than 20 tokens are involved; for these cases PAE or pLDDT may be more
  indicative of prediction quality.

For detailed description of these confidence metrics see our [paper]. For
protein components, the [AlphaFold: A Practical guide] course for structures
provides additional tutorials on the confidence metrics.

If you are interested in a specific entity or interaction, then there are
confidences available in the downloadable outputs that are specific to each
chain or chain-pair, as opposed to the full complex. See [json section] for
more details on all the confidence metrics that are returned.

[_1]: https://alphafoldserver.com/faq#how-can-i-interpret-confidence-metrics-to-check-the-accuracy-of-structures
[lDDT-Cα metric]: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3799472/
[Zhang and Skolnick, 2004]: https://doi.org/10.1002/prot.20264
[Xu and Zhang, 2010]: https://doi.org/10.1093/bioinformatics/btq066
[paper]: https://www.nature.com/articles/s41586-024-07487-w
[AlphaFold: A Practical guide]: https://www.ebi.ac.uk/training/online/courses/alphafold/inputs-and-outputs/evaluating-alphafolds-predicted-structures-using-confidence-scores/
[json section]: https://alphafoldserver.com/faq#how-do-i-interpret-all-the-outputs-in-the-downloaded-json-files


JSON file format for AlphaFold Server jobs
==========================================

You can [download an example JSON file here]; here we describe the contents of
this example JSON file.

This JSON file consists of a list of dictionaries (even in the case of a single
dictionary, a single-element list must be used), with each dictionary
containing a job description. Therefore, you can specify multiple jobs in one
JSON file.

Each job description contains a job name, a list of PRNG seeds (which can be an
empty list for automated random seed assignment), and a list of entities
(molecules) to be modeled.

AlphaFold Server JSON files are especially useful for automation of repetitive
modeling jobs (e.g. to screen interactions of one protein with a small number
of others). The easiest way to construct an initial JSON file is to run a
modeling job via AlphaFold Server GUI and use it as a template. AlphaFold
Server will produce a zip file containing modeling results. Inside the zip file
you will find a JSON file named `<job_name>_job_request.json` containing the
job inputs. These files offer a convenient starting point for generating new
jobs as they are easily editable in standard text editors or in programming
environments like Google Colab notebooks.

Note that comments are not allowed in JSON files.

Job name, seeds and sequences
-----------------------------

-   `name` is a string with the job name. This is how the job will appear as in
    the job history table.
-   `modelSeeds` is a list of strings of uint32 seed values (e.g.
    `["1593933729", "4273"]`). Seeds are used to run the modeling. We recommend
    providing an empty list, in which case a single random seed will be used.
    This is the recommended option.
-   `sequences` is a list of dictionaries that carry descriptions of the
    entities (molecules) for modeling.

``` json
{
  "name": "Test Fold Job Number One",
  "modelSeeds": [],
  "sequences": [...]
}
```

Entity types
------------

Valid entity types mirror those available in the AlphaFold Server web
interface:

-   `proteinChain` -- used for proteins
-   `dnaSequence` -- used for DNA (single strand)
-   `rnaSequence` -- used for RNA (single strand)
-   `ligand` -- used for allowed ligands
-   `ion` -- used for allowed ions

### Protein chains

`sequence` is a string containing protein sequence; the same limitations as in
the UI are in place, e.g. only letters corresponding to amino acids are
allowed, as defined by IUPAC. Only 20 standard amino acid type are supported.

`count` is the number of copies of this protein chain (integer).

`glycans` is an optional list of dictionaries that carries descriptions of the
protein glycosylation.

-   `residues` is a string defining glycan. Please refer to the [FAQ] for the
    format description and allowed glycans.
-   `position` is a position of the amino acid to which the glycan is attached
    (integer, 1-based indexing).

`modifications` is an optional list of dictionaries that carries descriptions
of the post-translational modifications.

-   `ptmType` is a string containing the [CCD code] of the modification; the
    same codes are allowed as in the UI.
-   `position` is a position of the modified amino acid (integer).
-   Allowed modifications: `CCD_SEP`, `CCD_TPO`, `CCD_PTR`, `CCD_NEP`,
    `CCD_HIP`, `CCD_ALY`, `CCD_MLY`, `CCD_M3L`, `CCD_MLZ`, `CCD_2MR`,
    `CCD_AGM`, `CCD_MCS`, `CCD_HYP`, `CCD_HY3`, `CCD_LYZ`, `CCD_AHB`,
    `CCD_P1L`, `CCD_SNN`, `CCD_SNC`, `CCD_TRF`, `CCD_KCR`, `CCD_CIR`, `CCD_YHA`

``` json
{
  "proteinChain": {
    "sequence": "PREACHINGS",

    "glycans": [
      {
        "residues": "NAG(NAG)(BMA)",
        "position": 8
      },
      {
        "residues": "BMA",
        "position": 10
      }
    ],

    "modifications": [
      {
        "ptmType": "CCD_HY3",
        "ptmPosition": 1
      },
      {
        "ptmType": "CCD_P1L",
        "ptmPosition": 5
      }
    ],

    "count": 1
  }
},
{
  "proteinChain": {
    "sequence": "REACHER",
    "count": 1
  }
}
```

### DNA chains

Please note that the `dnaSequence` type refers to single stranded DNA. If you
wish to model double stranded DNA, please add a second `"dnaSequence`",
carrying the sequence of the reverse complement strand.

`sequence` is a string containing a DNA sequence; the same limitations as in
the UI are in place, i.e. only letters A, T, G, C are allowed.

`count` is a number of copies of this DNA chain (integer).

`modifications` is an optional list of dictionaries that carries descriptions
of the DNA chemical modifications.

-   `modificationType` is a string containing [CCD code] of modification; the
    same codes are allowed as in the UI.
-   `basePosition` is a position of the modified nucleotide (integer).
-   Allowed modifications: `CCD_5CM`, `CCD_C34`, `CCD_5HC`, `CCD_6OG`,
    `CCD_6MA`, `CCD_1CC`, `CCD_8OG`, `CCD_5FC`, `CCD_3DR`

``` json
{
  "dnaSequence": {
    "sequence": "GATTACA",

    "modifications": [
      {
        "modificationType": "CCD_6OG",
        "basePosition": 1
      },
      {
        "modificationType": "CCD_6MA",
        "basePosition": 2
      }
    ],

    "count": 1
  }
},
{
  "dnaSequence": {
    "sequence": "TGTAATC",
    "count": 1
  }
}
```

### RNA chains

`sequence` is a string containing RNA sequence (single strand); the same
limitations as in the UI are in place, e.g. only letters A, U, G, C are
allowed.

`count` is a number of copies of this RNA chain (integer).

`modifications` is an optional list of dictionaries that carries descriptions
of the RNA chemical modifications.

-   `modificationType` is a string containing [CCD code] of modification; the
    same codes are allowed as in the UI.
-   `basePosition` is a position of the modified nucleotide (integer).
-   Allowed modifications: `CCD_PSU`, `CCD_5MC`, `CCD_OMC`, `CCD_4OC`,
    `CCD_5MU`, `CCD_OMU`, `CCD_UR3`, `CCD_A2M`, `CCD_MA6`, `CCD_6MZ`,
    `CCD_2MG`, `CCD_OMG`, `CCD_7MG`, `CCD_RSQ`

``` json
{
  "rnaSequence": {
    "sequence": "GUAC",

    "modifications": [
      {
        "modificationType": "CCD_2MG",
        "basePosition": 1
      },
      {
        "modificationType": "CCD_5MC",
        "basePosition": 4
      }
    ],

    "count": 1
  }
}
```

### Ligands

`ligand` is a string containing the [CCD code] of the ligand; the same codes
are allowed as in the UI.

`count` is the number of copies of this ligand (integer).

Allowed ligands: `CCD_ADP`, `CCD_ATP`, `CCD_AMP`, `CCD_GTP`, `CCD_GDP`,
`CCD_FAD`, `CCD_NAD`, `CCD_NAP`, `CCD_NDP`, `CCD_HEM`, `CCD_HEC`, `CCD_PLM`,
`CCD_OLA`, `CCD_MYR`, `CCD_CIT`, `CCD_CLA`, `CCD_CHL`, `CCD_BCL`, `CCD_BCB`

``` json
{
  "ligand": {
    "ligand": "CCD_ATP",
    "count": 1
  }
},
{
  "ligand": {
    "ligand": "CCD_HEM",
    "count": 2
  }
}
```

### Ions

`ion` is a string containing [CCD code] of the ion; the same codes are allowed
as in the UI. The ion charge is implicitly specified by the CCD code.

`count` is a number of copies of this ion (integer).

Allowed ions: `MG`, `ZN`, `CL`, `CA`, `NA`, `MN`, `K`, `FE`, `CU`, `CO`

``` json
{
  "ion": {
    "ion": "MG",
    "count": 2
  }
},
{
  "ion": {
    "ion": "NA",
    "count": 3
  }
}
```

Additional modeling jobs
========================

You may specify multiple jobs in one JSON file. This is an example of a simple
job request for one protein chain and two copies of the palindromic DNA
sequence:

``` json
{
  "name": "Test Fold Job Number Two",
  "modelSeeds": [],
  "sequences": [
    {
      "proteinChain": {
        "sequence": "TEACHINGS",
        "count": 1
      }
    },
    {
      "dnaSequence": {
        "sequence": "TAGCTA",
        "count": 2
      }
    }
  ]
}
```

[google-deepmind/alphafold/server]: https://github.com/google-deepmind/alphafold/tree/f251de6613cb478207c732bf9627b1e853c99c2f/server
[download an example JSON file here]: https://github.com/google-deepmind/alphafold/blob/main/server/example.json
[FAQ]: https://alphafoldserver.com/faq
[CCD code]: https://www.wwpdb.org/data/ccd


<!-- END -->
