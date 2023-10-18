process DECOY_PY_RAT {

    label 'process_single'

    input:
    val input_file
    val add_decoys
    val decoy_prefix

    output:
    path("*.target-decoy.fasta"), emit: ofile
    path("*.target.fasta"), emit: ofile_target
    path("*.decoy.fasta"), emit: ofile_decoy
    path "*.log", emit: log

    script:
    // define log file
    def log_file ="${input_file.baseName}.log"
    // obtain the decoys and targets (make sequence isobaric, replace 'I' to 'L')
    // concatenate targets and decoys

    // TODO!! USE the para ADD_DECOYS. If false, only copy the given file
    """
    python /opt/dbscripts/src/decoyPYrat.v2.py  --output_fasta "${input_file.baseName}.decoy.fasta"  --decoy_prefix=${decoy_prefix} "${input_file}" > "${log_file}" 2>&1
    mv "${input_file.getParent()}/${input_file.baseName}.target.fasta"  .
    cat "${input_file.baseName}.target.fasta" "${input_file.baseName}.decoy.fasta" > "${input_file.baseName}.target-decoy.fasta"
    """

}



